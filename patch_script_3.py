with open("src/planning_wsthanh/src/path_planning/src/path_manager_node.cpp", "r") as f:
    lines = f.readlines()

new_class = """class AdaptiveMITControlNode {
private:
    ros::NodeHandle nh;
    ros::Subscriber odom_sub;
    ros::Subscriber sign_sub;
    ros::Publisher car_cmd_pub;
    ros::Publisher error_pub;
    ros::Timer timer;

    // --- Thông số Xe (Lấy từ MATLAB của Châu) ---
    const double L = 0.118;             
    const double steer_limit = 23.0 * M_PI / 180.0; 
    const double dt = 0.1;              
    int look_ahead_val = 10;      
    const double margin = 0.01;         

    // --- Biến Trạng thái & Tối ưu ---
    nav_msgs::Odometry last_odom;
    bool path_ready = false;
    bool odom_received = false;
    std::vector<double> delta_plan;     
    
    // Đếm bước thực thi: Khi blind_step > 0, xe chạy mù theo kế hoạch đã vạch
    int blind_step = 0; 

public:
    AdaptiveMITControlNode() {
        odom_sub = nh.subscribe("/odometry/filtered", 1, &AdaptiveMITControlNode::odometryCallback, this);
        sign_sub = nh.subscribe("/detected_objects", 10, PathManager::signCallback);
        
        car_cmd_pub = nh.advertise<std_msgs::String>("/car1/command", 1);
        error_pub = nh.advertise<std_msgs::Float64MultiArray>("/mit/errors", 1);
        
        PathManager::init(nh); 
        if (PathManager::loading_condensed_path()) {
            path_ready = true;
            ROS_INFO("MIT Adaptive Node: Path successfully loaded.");
        }

        delta_plan.assign(3, 0.0);
        timer = nh.createTimer(ros::Duration(dt), &AdaptiveMITControlNode::controlLoop, this);
    }

    void odometryCallback(const nav_msgs::Odometry::ConstPtr& msg) {
        last_odom = *msg;
        odom_received = true;
    }

    void stopCar() {
        std_msgs::String speed_msg, steer_msg;
        speed_msg.data = "{\\"action\\": \\"1\\", \\"speed\\": 0.0}";
        steer_msg.data = "{\\"action\\": \\"2\\", \\"steerAngle\\": 0.0}";
        car_cmd_pub.publish(speed_msg);
        car_cmd_pub.publish(steer_msg);
    }

    void controlLoop(const ros::TimerEvent&) {
        if (!path_ready || !odom_received) return;

        double current_v_ref = PathManager::v_ref;
        if (PathManager::is_stopping_for_sign) {
            double elapsed = (ros::Time::now() - PathManager::stop_start_time).toSec();
            if (elapsed < 3.0) current_v_ref = 0.0;
            else {
                PathManager::is_stopping_for_sign = false;
                PathManager::current_sign = PathManager::TrafficSign::NONE;
            }
        }

        // ==========================================
        // CHẾ ĐỘ 1: NHẮM MẮT CHẠY MÙ THEO KẾ HOẠCH CŨ
        // ==========================================
        if (blind_step > 0 && blind_step < delta_plan.size()) {
            double steerDeg = delta_plan[blind_step] * 180.0 / M_PI;
            double final_steer_to_car = -steerDeg;

            std_msgs::String speed_msg, steer_msg;
            std::stringstream ss_v, ss_s;
            ss_v << "{\\"action\\": \\"1\\", \\"speed\\": " << std::fixed << std::setprecision(2) << current_v_ref << "}";
            ss_s << "{\\"action\\": \\"2\\", \\"steerAngle\\": " << std::fixed << std::setprecision(2) << final_steer_to_car << "}";
            speed_msg.data = ss_v.str();
            steer_msg.data = ss_s.str();
            
            car_cmd_pub.publish(speed_msg);
            car_cmd_pub.publish(steer_msg);

            ROS_INFO(">>> [CHAY MU %d/%d] Steer: %.2f deg (Tự chạy không đo MAP)", blind_step + 1, (int)delta_plan.size(), steerDeg);

            blind_step++;
            if (blind_step >= delta_plan.size()) {
                blind_step = 0; // Đã chạy xong hết chuỗi, nhịp sau sẽ mở mắt đo map lại
            }
            return; // Dừng tại đây, không tốn CPU tính toán MIT
        }

        // ==========================================
        // CHẾ ĐỘ 2: MỞ MẮT ĐO MAP VÀ LẬP KẾ HOẠCH MỚI
        // ==========================================
        double x_real = last_odom.pose.pose.position.x;
        double y_real = last_odom.pose.pose.position.y;
        double psi_real = tf2::getYaw(last_odom.pose.pose.orientation);
        double v = std::max(0.1, last_odom.twist.twist.linear.x); 

        Eigen::Vector3d current_state(x_real, y_real, psi_real);
        int target_idx_dummy;
        PathManager::find_next_waypoint(target_idx_dummy, current_state);
        
        int current_idx = PathManager::last_waypoint_index;

        double dist_to_end_sq = pow(PathManager::state_refs.bottomRows(1)(0,0) - x_real, 2) + 
                                pow(PathManager::state_refs.bottomRows(1)(0,1) - y_real, 2);
        
        if (current_idx > PathManager::state_refs.rows() - 45 || dist_to_end_sq < 0.01) {
            ROS_INFO_THROTTLE(1.0, "Goal Reached. Stopping.");
            stopCar();
            return; 
        }

        double gamma = 0.1;
        int steps = 3;
        double total_yaw_diff = 0.0;
        int window_size = 20; 
        int total_nodes = PathManager::state_refs.rows();
        int future_limit = std::min(current_idx + window_size, total_nodes); 

        for (int i = current_idx; i < future_limit - 1; ++i) {
            if (i + 1 >= total_nodes) break; 
            double h1 = PathManager::state_refs(i, 2);
            double h2 = PathManager::state_refs(i+1, 2);
            double diff = atan2(sin(h2 - h1), cos(h2 - h1));
            total_yaw_diff += std::abs(diff);
        }

        double ref_x_curr = PathManager::state_refs(current_idx, 0);
        double ref_y_curr = PathManager::state_refs(current_idx, 1);
        double error_current = sqrt(pow(x_real - ref_x_curr, 2) + pow(y_real - ref_y_curr, 2));

        if (total_yaw_diff > 0.9) { 
            gamma = 0.8;               
            steps = 2;                 
            look_ahead_val = 5;       
            ROS_INFO_THROTTLE(0.5, "DANG CONG GAT (Total Diff: %.2f)", total_yaw_diff);
        } 
        else if (total_yaw_diff > 0.5) { 
            gamma = 0.6; 
            steps = 2;
            look_ahead_val = 5;
            ROS_INFO_THROTTLE(0.5, "DANG VAO CUA (Total Diff: %.2f)", total_yaw_diff);
        }
        else { 
            gamma = 0.3; 
            steps = 3; 
            look_ahead_val = 5;       
        }

        if (error_current > 0.20) {
            look_ahead_val = 25; 
            gamma = 0.5;        
        }

        // Bỏ biến Receding Horizon Shift cũ, tạo mảng trắng toàn bộ
        if ((int)delta_plan.size() != steps) delta_plan.assign(steps, 0.0);

        ROS_INFO("1. MO MAT DO MAP | X: %.2f | Y: %.2f | Plan: Tinh %d Goc De Chay Mu", x_real, y_real, steps);

        double last_E = 0.0;
        double last_pred_x = 0.0;
        double last_pred_y = 0.0;

        for (int iter = 0; iter < 50; ++iter) {
            std::vector<double> delta_prev = delta_plan;
            std::vector<double> xp(steps), yp(steps), psi_p(steps);
            double temp_psi = psi_real;
            double temp_x = x_real;
            double temp_y = y_real;

            // [*] ĐÚNG THEO Ý TƯỞNG CỦA BẠN: TARGET CỐ ĐỊNH Ở ĐIỂM "look_ahead_val" PHÍA TRƯỚC LÀM ĐÍCH
            int target_idx = std::min(current_idx + look_ahead_val, total_nodes - 1);
            double ref_xf = PathManager::state_refs(target_idx, 0);
            double ref_yf = PathManager::state_refs(target_idx, 1);
            double ref_psif = PathManager::state_refs(target_idx, 2); 

            // Cộng dồn Grad lỗi tương lai về thẳng delta_plan[0] nếu muốn (Tích tụ sai số dần lên đầu)
            double grad_for_delta0 = 0.0;

            for(int s=0; s<steps; ++s) {
                // [*] SỬA LỖI ĐỘNG CƠ THỜI GIAN:
                // Để plan 3 góc ứng với 3 nhịp ROS thực tế (3x0.1s), ta PHẢI CHỈ ĐỊNH dt_step = 0.1 
                // Thay vi tính bằng khoảng cách đến đích rất xa có khi lệch lên tới 2 giây
                double dt_step = 0.1; // CỐ ĐỊNH = dt ROS
                
                double tan_delta = tan(delta_plan[s]);
                double d_psi = (v * tan_delta / L) * dt_step;
                
                if (std::abs(d_psi) < 1e-4) {
                    temp_x += v * dt_step * cos(temp_psi);
                    temp_y += v * dt_step * sin(temp_psi);
                    temp_psi += d_psi;
                } else {
                    double R = L / tan_delta;
                    temp_x += R * (sin(temp_psi + d_psi) - sin(temp_psi));
                    temp_y -= R * (cos(temp_psi + d_psi) - cos(temp_psi));
                    temp_psi += d_psi;
                }
                temp_psi = atan2(sin(temp_psi), cos(temp_psi));

                xp[s] = temp_x; yp[s] = temp_y;
                psi_p[s] = temp_psi; 

                double dx_err = temp_x - ref_xf;
                double dy_err = temp_y - ref_yf;
                
                // Sai số của bước chạy hiện thời so với quỹ đạo tương lai tít xa (Đường thẳng đi tới đích)
                double E = -dx_err * sin(ref_psif) + dy_err * cos(ref_psif);

                // Thêm Heading Error như code bản nháp cứng cáp
                double yaw_err = temp_psi - ref_psif;
                yaw_err = atan2(sin(yaw_err), cos(yaw_err));

                double E_total = E + 0.5 * yaw_err; 

                if (s == 0) {
                    last_E = E;
                    last_pred_x = xp[s];
                    last_pred_y = yp[s];
                }

                double discount_factor = 1.0 / (s + 1.0); 
                grad_for_delta0 += discount_factor * (E_total * 1.5);

                // Dùng E_total để sửa lỗi luôn góc s nếu bạn muốn các góc delta linh hoạt tự lượn
                if (s > 0) {
                    delta_plan[s] -= gamma * E_total * 1.5; 
                    delta_plan[s] = std::max(-steer_limit, std::min(steer_limit, delta_plan[s]));
                }
            }

            // GÓC CHÍNH BÉO delta_plan[0] CẦN HỨNG TẤT CẢ TRÁCH NHIỆM
            delta_plan[0] -= gamma * grad_for_delta0;
            delta_plan[0] = std::max(-steer_limit, std::min(steer_limit, delta_plan[0]));

            double max_diff = 0;
            for(int s=0; s<steps; ++s) max_diff = std::max(max_diff, std::abs(delta_plan[s] - delta_prev[s]));
            if (max_diff < 1e-4) break;
        }

        double steerDeg = delta_plan[0] * 180.0 / M_PI;
        double final_steer_to_car = -steerDeg;

        std_msgs::String speed_msg, steer_msg;
        std::stringstream ss_v, ss_s;
        ss_v << "{\\"action\\": \\"1\\", \\"speed\\": " << std::fixed << std::setprecision(2) << current_v_ref << "}";
        ss_s << "{\\"action\\": \\"2\\", \\"steerAngle\\": " << std::fixed << std::setprecision(2) << final_steer_to_car << "}";
        speed_msg.data = ss_v.str();
        steer_msg.data = ss_s.str();
        
        car_cmd_pub.publish(speed_msg);
        car_cmd_pub.publish(steer_msg);

        // Bật cờ gọi ROS chạy hệ thống "Chạy Nhắm Mắt" cho nhịp kế tiếp
        blind_step = 1;
        if (blind_step >= delta_plan.size()) {
            blind_step = 0; 
        }

        std_msgs::Float64MultiArray err_msg;
        err_msg.data.push_back(error_current);
        err_msg.data.push_back(steerDeg);
        error_pub.publish(err_msg);
    }
};
"""

with open("src/planning_wsthanh/src/path_planning/src/path_manager_node.cpp", "w") as f:
    f.writelines(lines[:16])
    f.write(new_class)
    idx_main = -1
    for i, line in enumerate(lines):
        if "int main(int argc, char** argv)" in line:
            idx_main = i
            break
            
    if idx_main != -1:
        f.writelines(lines[idx_main:])
