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

    // --- Thông số Xe ---
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
    
    int blind_step = 0; 
    int hold_ticks = 0; // Số nhịp ROS cần nhắm mắt giữ vô lăng

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
        // CHẾ ĐỘ 1: NHẮM MẮT CHẠY MÙ (GIỮ CỨNG VÔ LĂNG)
        // ==========================================
        if (blind_step > 0 && blind_step < hold_ticks) {
            // LỖI SAI LÀ Ở ĐÂY LÚC NÃY TRUY CẬP delta_plan[blind_step]
            // Thực tế delta_plan[0] ĐÃ ĐỦ BAO QUÁT chặng đường 2 giây tương lai. 
            // Ta chỉ việc GIỮ CHẾT delta_plan[0] để xe phi thẳng cho mượt!
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

            ROS_INFO(">>> [CHAY MU %d/%d] Giữ tay lái Steering cũ: %.2f deg", blind_step + 1, hold_ticks, steerDeg);

            blind_step++;
            if (blind_step >= hold_ticks) {
                blind_step = 0; 
            }
            return; 
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
        int steps = 1; // Chỉ cần dùng 1 step không gian (delta_plan[0]) vì 1 step đã bằng hơn 2.0s tương lai!
        double total_yaw_diff = 0.0;
        int window_size = 20; 
        int total_nodes = PathManager::state_refs.rows();
        int future_limit = std::min(current_idx + window_size, total_nodes); 

        for (int i = current_idx; i < future_limit - 1; ++i) {
            double h1 = PathManager::state_refs(i, 2);
            double h2 = PathManager::state_refs(i+1, 2);
            double diff = atan2(sin(h2 - h1), cos(h2 - h1));
            total_yaw_diff += std::abs(diff);
        }

        double ref_x_curr = PathManager::state_refs(current_idx, 0);
        double ref_y_curr = PathManager::state_refs(current_idx, 1);
        double error_current = sqrt(pow(x_real - ref_x_curr, 2) + pow(y_real - ref_y_curr, 2));

        // TÍNH TOÁN ĐỊA HÌNH VÀ ĐỘ DÀI "MÙ THỜI GIAN" (Hold Ticks)
        if (total_yaw_diff > 0.9) { 
            gamma = 0.8;               
            look_ahead_val = 5;       
            hold_ticks = 1; // Cua gắt, không được nhắm mắt! 10Hz real time.
            ROS_INFO_THROTTLE(0.5, "DANG CONG GAT (Total Diff: %.2f)", total_yaw_diff);
        } 
        else if (total_yaw_diff > 0.5) { 
            gamma = 0.6; 
            look_ahead_val = 7;
            hold_ticks = 3; // Cua nhẹ, có thể thư giãn giữ vô lăng 0.3s (3 nhịp)
            ROS_INFO_THROTTLE(0.5, "DANG VAO CUA (Total Diff: %.2f)", total_yaw_diff);
        }
        else { 
            gamma = 0.4; 
            look_ahead_val = 14; // Đường thẳng, nhìn cực xa cho đầm xe!
            hold_ticks = 5; // Đường thẳng tắp, trói vô lăng chạy 5 nhịp 0.5s rồi mới tính tiếp
        }

        if (error_current > 0.20) {
            look_ahead_val = 15; 
            gamma = 0.5;        
            hold_ticks = 1; // Lệch quỹ đạo quá nhiều bắt buộc phải mở con mắt lên ngay
        }

        if ((int)delta_plan.size() != steps) delta_plan.assign(steps, 0.0);

        ROS_INFO("1. MO MAT DO MAP | X: %.2f | Y: %.2f | Plan: Tinh 1 Goc & Nham mat giu %d nhip", x_real, y_real, hold_ticks);

        double last_E = 0.0;
        double last_pred_x = 0.0;
        double last_pred_y = 0.0;

        for (int iter = 0; iter < 50; ++iter) {
            std::vector<double> delta_prev = delta_plan;
            std::vector<double> xp(steps), yp(steps), psi_p(steps);
            double temp_psi = psi_real;
            double temp_x = x_real;
            double temp_y = y_real;

            for(int s=0; s<steps; ++s) {
                int target_idx = std::min(current_idx + (s+1) * look_ahead_val, total_nodes - 1);
                double ref_xf = PathManager::state_refs(target_idx, 0);
                double ref_yf = PathManager::state_refs(target_idx, 1);
                double ref_psif = PathManager::state_refs(target_idx, 2); 

                double dist_to_target = sqrt(pow(ref_xf - temp_x, 2) + pow(ref_yf - temp_y, 2));
                // LƯU Ý PHÉP THUẬT Ở ĐÂY: dt_step (thời gian ảo tới node nhìn trước) lên tới 2.0s lận!
                double dt_step = dist_to_target / std::max(0.1, v); 
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

                 double dx_err = temp_x - ref_xf;
                double dy_err = temp_y - ref_yf;
                
                double E = -dx_err * sin(ref_psif) + dy_err * cos(ref_psif);
                double yaw_err = temp_psi - ref_psif;
                yaw_err = atan2(sin(yaw_err), cos(yaw_err));

                double E_total = E + 1.0 * yaw_err; 
                double E_effective = E_total * ((cos(yaw_err) >= 0) ? 1.0 : -1.0);

                delta_plan[s] -= gamma * E_effective * 1.5; 
                delta_plan[s] = std::max(-steer_limit, std::min(steer_limit, delta_plan[s]));
            }

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

        // Khởi động đếm số NHỊP GIỮ (hold_ticks) cho chu kỳ nhắm mắt kế tiếp
        blind_step = 1;
        if (blind_step >= hold_ticks) {
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
    # The original file was correctly purged to 289 lines when we deleted duplicates.
    # Lines after the original class end at index 269 usually. But wait!
    # In my previous python del lines[268:292], it shifted things.
    # We should safely find `int main(int argc, char** argv) {`
    
    idx_main = -1
    for i, line in enumerate(lines):
        if "int main(int argc, char** argv)" in line:
            idx_main = i
            break
            
    if idx_main != -1:
        f.writelines(lines[idx_main:])
