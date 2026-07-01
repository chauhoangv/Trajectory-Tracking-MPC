#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <nav_msgs/Odometry.h>
#include <nav_msgs/Path.h>
#include <sensor_msgs/Imu.h>
#include <std_msgs/String.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Float64MultiArray.h>
#include <Eigen/Dense>
#include <tf2/utils.h>
#include <tf2/LinearMath/Quaternion.h>
#include <algorithm>
#include <iomanip>
#include <path_planning/planning/PathManager.h>
#include <std_msgs/Float32.h>
#include <vector>
#include <cmath>
#include <chrono>
#include <fstream>

// =============================================================================
// 1. PHẦN LẤY DỮ LIỆU (ĐỂ LƯU FILE + VẼ BIỂU ĐỒ)
// =============================================================================

// --- Cấu trúc dữ liệu ghi nhận trạng thái xe tại mỗi chu kỳ ---
struct LogRecord {
    double timestamp;   
    std::string type;   
    int cycle_id;       // Chu kỳ điều khiển
    int iter;           // Chỉ số vòng lặp tối ưu hiện tại (chỉ dùng cho PLANNING)
    int step;           // Chỉ số bước dự báo tương lai trong  kính nhìn trước
    double x, y, psi;   // Trạng thái tọa độ (x, y) và góc hướng (yaw) của xe
    double e_lat;       // Sai số lệch ngang
    double e_yaw;       // Sai số góc hướng 
    double steer;       // Góc lái tính toán tại chu kỳ 
    double e_total;     // Tổng giá trị hàm chi phí tại bước này
    double w_lat;       // Trọng số bám ngang
    double w_head;      // Trọng số hướng 
};

// --- Lớp quản lý ghi file dữ liệu CSV phục vụ phân tích thuật toán ---
class CSVLogger {
public:
    CSVLogger(const std::string& path) : filename(path) {
        file.open(filename, std::ios::out);
        file << "timestamp,type,cycle_id,iter,step,x,y,psi,e_lat,e_yaw,steer,e_total,w_lat,w_head\n";
    }
    ~CSVLogger() { if(file.is_open()) file.close(); }
    
    void log(const LogRecord& r) {
        if (!file.is_open()) return;
        file << r.timestamp << "," << r.type << "," << r.cycle_id << "," << r.iter << "," << r.step << ","
             << std::fixed << std::setprecision(4) << r.x << "," << r.y << "," << r.psi << ","
             << r.e_lat << "," << r.e_yaw << "," << r.steer << "," << r.e_total << ","
             << r.w_lat << "," << r.w_head << "\n";
    }
    void flush() { file.flush(); }

private:
    std::string filename;
    std::ofstream file;
};


// =============================================================================
// 2. KHAI BÁO BỘ ĐIỀU KHIỂN THÍCH NGHI (ADAPTIVE MIT CONTROLLER)
// =============================================================================

class AdaptiveMITControlNode {
private:
    // --- Giao tiếp ROS ---
    ros::NodeHandle nh;
    ros::Subscriber odom_sub;       // Nhận dữ liệu định vị 
    ros::Subscriber sign_sub;       // Nhận thông tin biển báo giao thông từ Camera, chưa tích hợp với Lộc
    ros::Subscriber path_ready_sub; // Nhận tín hiệu đã lập xong quỹ đạo toàn cục
    ros::Publisher car_cmd_pub;     // Gửi lệnh điều khiển (Tốc độ & Góc lái) xuống xe
    ros::Publisher error_pub;       // Gửi dữ liệu sai số
    ros::Publisher path_pub;        
    ros::Publisher perf_pub;        // Gửi thời gian tính toán của vòng lặp tìm góc lái tối ưu
    ros::Timer timer;               

    // --- Thông số vật lý của Xe ---
    const double L = 0.26;                          // Chiều dài cơ sở thực tế của xe (mét)
    const double steer_limit = 23.0 * M_PI / 180.0; // Giới hạn góc lái vật lý tối đa (23 độ sang rad)
    const double dt = 0.1;                          // Tần số lấy mẫu điều khiển (100ms)
    const double margin = 0.05;                     // Biên sai số ngang cho phép để giữ góc lái cũ (5cm)

    // --- Trạng thái hệ thống & Bộ lọc mượt góc lái ---
    nav_msgs::Odometry last_odom;       // Dữ liệu định vị mới nhất nhận từ cảm biến
    bool path_ready = false;            // Cờ xác nhận quỹ đạo toàn cục đã nạp 
    bool odom_received = false;         // Cờ báo đã nhận được phản hồi từ định vị
    double current_planned_steer = 0.0; // Góc lái tối ưu tính toán từ chu kỳ trước
    bool has_planned_steer = false;     // Cờ kiểm tra sự tồn tại của góc lái tối ưu cũ
    double last_steer_deg = 0.0;        // Góc lái vật lý gửi xuống xe ở chu kỳ trước (đơn vị độ)
    const double alpha_sim = 0.7;       // Hệ số mô phỏng trễ cơ cấu servo (chỉ lấy 70% góc mới + 30% góc cũ)
    const double alpha_out = 1.0;       // Hệ số lọc mượt góc lái đầu ra gửi xuống xe (1.0 = hiện tại không lọc)
    CSVLogger* logger;                 
    int cycle_count = 0;                // Bộ đếm số chu kỳ điều khiển
    bool ref_logged = false;         

public:
    AdaptiveMITControlNode() {
        // Đăng ký nhận dữ liệu ROS
        odom_sub = nh.subscribe("/odometry/filtered", 1, &AdaptiveMITControlNode::odometryCallback, this);
        path_ready_sub = nh.subscribe("/path_ready", 1, &AdaptiveMITControlNode::pathReadyCallback, this);
        sign_sub = nh.subscribe("/detected_objects", 10, PathManager::signCallback);

        // Khai báo xuất dữ liệu ROS
        car_cmd_pub = nh.advertise<std_msgs::String>("/car1/command", 1);
        error_pub = nh.advertise<std_msgs::Float64MultiArray>("/mit/errors", 1);
        path_pub = nh.advertise<nav_msgs::Path>("/planned_path", 1, true);
        perf_pub = nh.advertise<std_msgs::Float32>("/mit/plan_time", 1);
        
        PathManager::init(nh);
        path_ready = false;
        ROS_INFO("MIT Adaptive Node: Waiting for /path_ready signal from Global Planner...");

        current_planned_steer = 0.0;
        has_planned_steer = false;
        
        // Khởi tạo file log CSV lưu tạm
        std::string log_name = "/tmp/planning_dump.csv";
        logger = new CSVLogger(log_name);
        ROS_INFO("MIT Study Logger initialized: %s", log_name.c_str());

        // Kích hoạt Timer chạy vòng lặp điều khiển định kỳ mỗi 100ms
        timer = nh.createTimer(ros::Duration(dt), &AdaptiveMITControlNode::controlLoop, this);
    }

    // Xử lý nạp quỹ đạo toàn cục từ Global Planner
    void pathReadyCallback(const std_msgs::String::ConstPtr& msg) {
        if (msg->data == "ready" && !path_ready) {
            if (PathManager::loading_condensed_path()) {
                path_ready = true;
                ROS_INFO("MIT Adaptive Node: Path successfully loaded. Ready to follow!");
                publishPath();

                // Lưu quỹ đạo tham chiếu chuẩn vào log phục vụ phân tích ngoại tuyến
                if (!ref_logged && logger) {
                    for (int i = 0; i < PathManager::state_refs.rows(); ++i) {
                        logger->log({0.0, "REFERENCE", 0, 0, i,
                                     PathManager::state_refs(i, 0),
                                     PathManager::state_refs(i, 1),
                                     PathManager::state_refs(i, 2),
                                     0.0, 0.0, 0.0, 0.0, 0.0, 0.0});
                    }
                    ref_logged = true;
                    logger->flush();
                    ROS_INFO("MIT Study: Reference Path logged.");
                }
            }
        }
    }

    // Nhận và lưu trữ thông tin tọa độ thực tế của xe
    void odometryCallback(const nav_msgs::Odometry::ConstPtr& msg) {
        last_odom = *msg;
        odom_received = true;
    }

    // Lệnh dừng khẩn cấp xe (tốc độ = 0, góc lái = 0)
    void stopCar() {
        std_msgs::String speed_msg, steer_msg;
        speed_msg.data = "{\"action\": \"1\", \"speed\": 0.0}";
        steer_msg.data = "{\"action\": \"2\", \"steerAngle\": 0.0}";
        last_steer_deg = 0.0;
        car_cmd_pub.publish(speed_msg);
        car_cmd_pub.publish(steer_msg);
    }

    void publishPath() {
        if (PathManager::state_refs.rows() == 0) return;

        nav_msgs::Path path_msg;
        path_msg.header.stamp = ros::Time::now();
        path_msg.header.frame_id = "map";

        for (int i = 0; i < PathManager::state_refs.rows(); ++i) {
            geometry_msgs::PoseStamped pose;
            pose.header = path_msg.header;
            pose.pose.position.x = PathManager::state_refs(i, 0);
            pose.pose.position.y = PathManager::state_refs(i, 1);
            pose.pose.position.z = 0.0;
            tf2::Quaternion q;
            q.setRPY(0, 0, PathManager::state_refs(i, 2));
            pose.pose.orientation.x = q.x();
            pose.pose.orientation.y = q.y();
            pose.pose.orientation.z = q.z();
            pose.pose.orientation.w = q.w();
            path_msg.poses.push_back(pose);
        }
        path_pub.publish(path_msg);
    }

    // =============================================================================
    // 3. VÒNG LẶP ĐIỀU KHIỂN CHÍNH (10HZ)
    // =============================================================================
    void controlLoop(const ros::TimerEvent&) {
        // --- BƯỚC 1: KIỂM TRA ĐIỀU KIỆN KHỞI CHẠY & BIỂN BÁO ---
        if (!path_ready || !odom_received) return;
        if (PathManager::state_refs.rows() == 0) return;

        double current_v_ref = PathManager::v_ref;

        // Phần sườn xử lý biển báo (làm tương tự, nhưng hiện tại chưa tích hợp với Lộc)
        if (PathManager::is_stopping_for_sign) {
            double elapsed = (ros::Time::now() - PathManager::stop_start_time).toSec();
            if (elapsed < 3.0) current_v_ref = 0.0; // VD dừng xe 3 giây khi gặp biển báo
            else {
                PathManager::is_stopping_for_sign = false;
                PathManager::current_sign = PathManager::TrafficSign::NONE;
            }
        }

        // --- BƯỚC 2: ĐỊNH VỊ XE & TẠO ĐIỂM XE ẢO RA PHÍA TRƯỚC XE THỰC 15CM (BÙ TRƯỢT/TRỄ/...) ---
        double x_real = last_odom.pose.pose.position.x;
        double y_real = last_odom.pose.pose.position.y;
        double psi_real = tf2::getYaw(last_odom.pose.pose.orientation);

        // Tạo điểm ảo phía trước xe thực tế 15cm để bù trễ, trượt 
        const double look_ahead_offset = 0.15;
        double x_ghost = x_real + look_ahead_offset * cos(psi_real);
        double y_ghost = y_real + look_ahead_offset * sin(psi_real);

        double v = 0.24; // Vận tốc di chuyển cố định của xe (m/s) (Đo từ cảm biến)
        Eigen::Vector3d current_state(x_ghost, y_ghost, psi_real);
        int target_idx_dummy;
        PathManager::find_next_waypoint(target_idx_dummy, current_state);
        int current_idx = PathManager::last_waypoint_index;

        // --- BƯỚC 3: TÍNH TOÁN SAI SỐ HIỆN TẠI (LATERAL ERROR) ---
        double ref_x_curr = PathManager::state_refs(current_idx, 0);
        double ref_y_curr = PathManager::state_refs(current_idx, 1);
        double dx = x_ghost - ref_x_curr;
        double dy = y_ghost - ref_y_curr;
        double psi_ref = PathManager::state_refs(current_idx, 2);
        
        // Chiếu sai lệch tọa độ lên pháp tuyến quỹ đạo để tìm khoảng cách lệch ngang thực tế
        double error_current = -dx * std::sin(psi_ref) + dy * std::cos(psi_ref); 

        double ts = ros::Time::now().toSec();
        if (logger) {
            double E_norm = std::abs(error_current) / 0.20; // Chuẩn hóa lỗi theo biên cho phép 20cm
            if (E_norm > 1.0) E_norm = 1.0 + 0.05 * (E_norm - 1.0); // Bão hòa lỗi khi lệch quá nhiều
            logger->log({ts, "HISTORY", cycle_count, 0, 0, x_real, y_real, psi_real, E_norm, 0.0, last_steer_deg / 180.0 * M_PI, 0.0, 0.0, 0.0});
        }

        // Kiểm tra điều kiện dừng khi xe đã đi về gần đích
        double dist_to_end_sq = pow(PathManager::state_refs.bottomRows(1)(0,0) - x_ghost, 2) +
                                pow(PathManager::state_refs.bottomRows(1)(0,1) - y_ghost, 2);
        if (current_idx > PathManager::state_refs.rows() - 5 || dist_to_end_sq < 0.01) {
            ROS_INFO_THROTTLE(1.0, "Goal Reached. Stopping.");
            stopCar();
            return;
        }

        // --- BƯỚC 4: THÍCH NGHI THÔNG SỐ (ADAPTIVE TUNING) THEO ĐỘ CONG ĐƯỜNG PHÍA TRƯỚC ---
        // Phóng bán kính cố định ra phía trước 0.4m và tính độ cong trong bán kính nhìn trước
        // Nếu cong nhiều -> giảm tầm nhìn, cong ít -> tăng tầm nhìn
        double gamma = 0.1;
        int steps = 15;
        double total_yaw_diff = 0.0;
        int total_nodes = PathManager::state_refs.rows();

        // 4.1. Tìm chỉ số điểm mốc nằm cách xe đúng 0.4m thực tế
        int scan_limit_idx = current_idx;
        double scan_radius_sq = pow(0.40, 2); 

        for (int i = current_idx; i < total_nodes; ++i) {
            double d_sq = pow(PathManager::state_refs(i, 0) - x_ghost, 2) +
                        pow(PathManager::state_refs(i, 1) - y_ghost, 2);
            if (d_sq >= scan_radius_sq) {
                scan_limit_idx = i;
                break;
            }
        }
        if (scan_limit_idx == current_idx && total_nodes > 0) {
            scan_limit_idx = std::min(total_nodes - 1, current_idx + 20);
        }

        // 4.2. Tính toán độ tích lũy lệch góc (độ cong) trong khoảng tầm nhìn quét 0.4m
        for (int i = current_idx; i < scan_limit_idx; ++i) {
            double h1 = PathManager::state_refs(i, 2);
            double h2 = PathManager::state_refs(i+1, 2);
            double diff = atan2(sin(h2 - h1), cos(h2 - h1));
            total_yaw_diff += std::abs(diff);
        }

        double look_ahead_radius = 0.45; 

        // 4.3. Chọn bán kính nhìn xa (look_ahead_radius) và hệ số (gamma) tương ứng với độ cong
        if (total_yaw_diff > 0.6) { // Cua gắt
            gamma = 0.20; 
            look_ahead_radius = 0.35;
            ROS_INFO_THROTTLE(0.5, "HARD_TURN (Diff: %.2f) -> Radius: 0.35m, Gamma: 0.20", total_yaw_diff);
        } else if (total_yaw_diff > 0.3) { // Cua trung bình
            gamma = 0.15; 
            look_ahead_radius = 0.40;
            ROS_INFO_THROTTLE(0.5, "SHARP_CURVE (Diff: %.2f) -> Radius: 0.40m, Gamma: 0.15", total_yaw_diff);
        } else if (total_yaw_diff > 0.12) { // Cua nhẹ
            gamma = 0.10; 
            look_ahead_radius = 0.45;
            ROS_INFO_THROTTLE(0.5, "SLIGHT_TURN (Diff: %.2f) -> Radius: 0.45m, Gamma: 0.10", total_yaw_diff);
        } else { // Đường thẳng
            gamma = 0.08; 
            look_ahead_radius = 0.45;
        }

        // Ưu tiên : Rút ngắn tầm nhìn xa khi xe đang bị lệch làn nhiều (> 10cm) để kéo xe về làn gấp hơn
        if (std::abs(error_current) > 0.1) {
            look_ahead_radius = 0.35;
            gamma = 0.15;
        }

        // 4.4. Định nghĩa điểm đích thực tế để bám (target_node_idx) và ép số bước mô phỏng cho mô hình xe đạp (steps)
        int target_node_idx = current_idx;
        int search_limit = std::min(total_nodes, current_idx + 80);
        for (int i = current_idx; i < search_limit; ++i) {
            double d_sq = pow(PathManager::state_refs(i, 0) - x_ghost, 2) +
                        pow(PathManager::state_refs(i, 1) - y_ghost, 2);
            if (d_sq >= pow(look_ahead_radius, 2)) {
                target_node_idx = i;
                break;
            }
        }
        if (target_node_idx == current_idx && total_nodes > 0) target_node_idx = search_limit - 1;

        steps = std::max(5, target_node_idx - current_idx);

        if (logger) {
            logger->log({ts, "TARGET_NODE", cycle_count, target_node_idx, 0,
                        PathManager::state_refs(target_node_idx, 0),
                        PathManager::state_refs(target_node_idx, 1),
                        PathManager::state_refs(target_node_idx, 2),
                        0.0, 0.0, 0.0, 0.0, 0.0, 0.0});
        }

        // --- BƯỚC 5: KIỂM TRA ĐIỀU KIỆN GIỮ GÓC LÁI CŨ (HOLD) HOẶC TÍNH MỚI (REPLAN) ---
        // Giả lập chuyển động của xe bằng mô hình xe đạp động học. Nếu áp góc lái cũ mà xe vẫn an toàn
        // nằm trong hành làn sai số cho phép (margin = 5cm), bỏ qua bước Re-plan để đỡ tính toán nhiều.
        bool is_safe = true;
        if (!has_planned_steer) is_safe = false;
        else {
            double temp_x = x_ghost;
            double temp_y = y_ghost;
            double temp_psi = psi_real;
            double sim_steer = last_steer_deg * M_PI / 180.0;
            for (int s = 0; s < steps; ++s) {
                sim_steer = alpha_sim * current_planned_steer + (1.0 - alpha_sim) * sim_steer;
                double tan_delta = tan(sim_steer);
                int way_idx = std::min(current_idx + s, (int)PathManager::state_refs.rows() - 1);
                double ref_xf_s = PathManager::state_refs(way_idx, 0);
                double ref_yf_s = PathManager::state_refs(way_idx, 1);
                double ref_psif_s = PathManager::state_refs(way_idx, 2);
                double dx_err = temp_x - ref_xf_s;
                double dy_err = temp_y - ref_yf_s;

                double e_lat_sim = -dx_err * sin(ref_psif_s) + dy_err * cos(ref_psif_s);
                if (std::abs(e_lat_sim) > margin) { is_safe = false; break; }

                double dist_node = (s < steps - 1) ?
                    sqrt(pow(PathManager::state_refs(way_idx+1,0)-ref_xf_s,2)+pow(PathManager::state_refs(way_idx+1,1)-ref_yf_s,2)) : 0.02;
                double dt_step = dist_node / std::max(0.1, v);
                double d_psi = (v * tan_delta / L) * dt_step;
                if (std::abs(d_psi) < 1e-4) {
                    temp_x += v * dt_step * cos(temp_psi); temp_y += v * dt_step * sin(temp_psi); temp_psi += d_psi;
                } else {
                    double R = L / tan_delta;
                    temp_x += R * (sin(temp_psi + d_psi) - sin(temp_psi));
                    temp_y -= R * (cos(temp_psi + d_psi) - cos(temp_psi));
                    temp_psi += d_psi;
                }
                temp_psi = atan2(sin(temp_psi), cos(temp_psi));
            }
        }
        // Nếu tương lai xe vẫn nằm trong giới hạn hành lang giữ góc lái cũ -> Tiếp tục giữ góc lái cũ
        // Nếu với vị trí hiện tại mà sài góc lái cũ thì tương lai có thể ra khỏi hành lang sai số 5cm (mỗi bên) -> Bước 6
        // Nhánh HOLD: Xe vẫn an toàn và sai số hiện tại bé hơn biên -> Giữ nguyên góc lái cũ
        if (is_safe && std::abs(error_current) < margin) {
            double steerDeg_raw = current_planned_steer * 180.0 / M_PI;
            double steerDeg = alpha_out * steerDeg_raw + (1.0 - alpha_out) * last_steer_deg;
            last_steer_deg = steerDeg;
            std::msgs::String speed_msg, steer_msg;
            std::stringstream ss_v, ss_s;
            ss_v << "{\"action\": \"1\", \"speed\": " << std::fixed << std::setprecision(2) << current_v_ref << "}";
            ss_s << "{\"action\": \"2\", \"steerAngle\": " << std::fixed << std::setprecision(2) << steerDeg << "}";
            speed_msg.data = ss_v.str(); steer_msg.data = ss_s.str();
            car_cmd_pub.publish(speed_msg); car_cmd_pub.publish(steer_msg);
            ROS_INFO_THROTTLE(0.5, ">>> [HOLD] Pos(%.2f, %.2f) -> Target[%d](<%.2f, %.2f>) | Steer: %.2f deg | Horizon: %d | E_lat: %.3fm",
                            x_ghost, y_ghost, target_node_idx,
                            PathManager::state_refs(target_node_idx, 0), PathManager::state_refs(target_node_idx, 1),
                            steerDeg, steps, error_current);
            cycle_count++;
            if (logger && cycle_count % 10 == 0) logger->flush();
            return;
        }

        // --- BƯỚC 6: THUẬT TOÁN TỐI ƯU HÓA TÌM GÓC LÁI MỚI (MIT RE-PLAN - GRADIENT DESCENT) ---
        struct IterStep {
            double x, y, psi;
            double e_lat, e_yaw, steer, e_total;
            double w_lat, w_head;
        };
        std::vector<std::vector<IterStep>> iter_buffer;
        iter_buffer.reserve(50);
        auto t_start = std::chrono::high_resolution_clock::now();
        int actual_iters = 0;
        double delta_opt = current_planned_steer;
        double last_avg_E_total = 0.0;

        double e_total_k_minus_1 = 0.0;
        double delta_k_minus_1 = 0.0;

        // 6.1. Thiết lập tỷ lệ ưu tiên tương đối của người tunning (tổng = 1.0)
        double w_lat_input = 0.0;
        double w_head_input = 0.0;
        double w_steer_input = 0.0;

        if (total_yaw_diff > 0.6) {         // Khúc cua gắt
            w_lat_input   = 0.85;
            w_head_input  = 0.01;
            w_steer_input = 0.14;
        } else if (total_yaw_diff > 0.3) {  // Khúc cua trung bình
            w_lat_input   = 0.80;
            w_head_input  = 0.01;
            w_steer_input = 0.19;
        } else {                            // Đường thẳng / Cua nhẹ
            w_lat_input   = 0.77;  
            w_head_input  = 0.03;  
            w_steer_input = 0.2;  
        }

        // Chuẩn hóa tỷ lệ tương đối về thang tổng bằng 1.0
        double w_sum = w_lat_input + w_head_input + w_steer_input;
        if (w_sum > 0.0) {
            w_lat_input /= w_sum;
            w_head_input /= w_sum;
            w_steer_input /= w_sum;
        }

        // 6.2. Hệ số quy đổi baseline vật lý giúp cân bằng lệch đơn vị giữa Mét và Radian
        double base_lat = (total_yaw_diff > 0.6) ? 30.0 : (total_yaw_diff > 0.3 ? 20.0 : 15.0);
        double base_head = (total_yaw_diff > 0.6) ? 0.01 : (total_yaw_diff > 0.3 ? 0.25 : 1.0);
        double base_steer = 5.0;

        // Trọng số vật lý thực tế cuối cùng đưa vào hàm chi phí
        double lateral_weight_orig = w_lat_input * base_lat;
        double heading_weight_orig = w_head_input * base_head;
        double w_energy_orig = w_steer_input * base_steer;

        double heading_weight = heading_weight_orig * (1.57 * 1.57);
        double lateral_weight = lateral_weight_orig * (0.20 * 0.20);
        double w_energy = w_energy_orig * (0.40 * 0.40);

        double current_physical_steer = last_steer_deg * M_PI / 180.0; //Quy đổi đơn vị góc lái thực 

        // Vòng lặp tối ưu tìm góc lái delta_opt phù hợp để điều khiển xe
        for (int iter = 0; iter < 50; ++iter) {
            actual_iters++;
            double prev_delta = delta_opt;
            double temp_x = x_ghost;
            double temp_y = y_ghost;
            double temp_psi = psi_real;

            std::vector<IterStep> current_steps;
            current_steps.reserve(steps);
            double sum_weighted_E_sq = 0.0;
            double sum_weights = 0.0;
            double sim_steer = last_steer_deg * M_PI / 180.0;

            for(int s = 0; s < steps; ++s) {
                sim_steer = alpha_sim * delta_opt + (1.0 - alpha_sim) * sim_steer;
                double tan_delta = tan(sim_steer);
                int way_idx = std::min(current_idx + s, (int)PathManager::state_refs.rows() - 1);
                double ref_xf_s = PathManager::state_refs(way_idx, 0);
                double ref_yf_s = PathManager::state_refs(way_idx, 1);
                double ref_psif_s = PathManager::state_refs(way_idx, 2);
                
                double dx_err = temp_x - ref_xf_s;
                double dy_err = temp_y - ref_yf_s;
                double E = -dx_err * sin(ref_psif_s) + dy_err * cos(ref_psif_s);
                double yaw_err = atan2(sin(temp_psi - ref_psif_s), cos(temp_psi - ref_psif_s));
            
                // Chuẩn hóa sai số
                double E_norm = std::abs(E) / 0.20;
                if (E_norm > 1.0) E_norm = 1.0 + 0.05 * (E_norm - 1.0);
            
                double yaw_err_norm = std::abs(yaw_err) / 1.57;
                if (yaw_err_norm > 1.0) yaw_err_norm = 1.0 + 0.05 * (yaw_err_norm - 1.0);

                double E_total_step = std::sqrt(lateral_weight * E_norm * E_norm + heading_weight * yaw_err_norm * yaw_err_norm);
                current_steps.push_back({temp_x, temp_y, temp_psi, E_norm, yaw_err_norm, delta_opt, E_total_step, lateral_weight, heading_weight});
                
                // Trọng số thời gian bậc 2 (s^2)
                double weight = (s + 1.0) * (s + 1.0);
                sum_weighted_E_sq += weight * (lateral_weight * E_norm * E_norm + heading_weight * yaw_err_norm * yaw_err_norm);
                sum_weights += weight;

                double dist_node = (s < steps - 1) ?
                    sqrt(pow(PathManager::state_refs(way_idx+1,0)-ref_xf_s,2)+pow(PathManager::state_refs(way_idx+1,1)-ref_yf_s,2)) : 0.02;
                double dt_step = dist_node / std::max(0.1, v);
                double d_psi = (v * tan_delta / L) * dt_step;
                if (std::abs(d_psi) < 1e-4) {
                    temp_x += v * dt_step * cos(temp_psi); temp_y += v * dt_step * sin(temp_psi); temp_psi += d_psi;
                } else {
                    double R = L / tan_delta;
                    temp_x += R * (sin(temp_psi + d_psi) - sin(temp_psi));
                    temp_y -= R * (cos(temp_psi + d_psi) - cos(temp_psi));
                    temp_psi += d_psi;
                }
                temp_psi = atan2(sin(temp_psi), cos(temp_psi));
            }
            iter_buffer.push_back(current_steps);
            double avg_E_total = 0.0;
            if (sum_weights > 0.0) {
                avg_E_total = std::sqrt(sum_weighted_E_sq / sum_weights);
            }

            // 6.4. Tính toán Độ nhạy 
            double sensitivity = (error_current >= 0.0) ? 1.5 : -1.5;
            if (iter > 0) {
                double d_delta = delta_opt - delta_k_minus_1;
                if (std::abs(d_delta) > 1e-6) {
                    sensitivity = (avg_E_total - e_total_k_minus_1) / d_delta;
                }
            }
            double grad_error = avg_E_total * sensitivity;

            e_total_k_minus_1 = avg_E_total;
            delta_k_minus_1 = delta_opt;

            // 6.5. Tính toán Gradient của biến thiên  góc lái (hạn chế bẻ lái đột ngột)
            double steer_diff = delta_opt - current_physical_steer;
            double grad_energy = (w_energy / (0.40 * 0.40)) * steer_diff;

            // 6.6. Cập nhật góc lái theo Gradient Descent 
            delta_opt -= gamma * (grad_error + grad_energy);
            delta_opt = std::max(-steer_limit, std::min(steer_limit, delta_opt));

            // Điều kiện dừng sớm: khi góc lái hội tụ 
            if (iter > 0 && std::abs(delta_opt - prev_delta) < 1e-4) //1e-4 này thì tuỳ chỉnh
            {
                last_avg_E_total = avg_E_total;
                break;
            }
            last_avg_E_total = avg_E_total;
        }

        current_planned_steer = delta_opt;
        has_planned_steer = true;

        // Đo thời gian vòng lặp (dùng để báo cáo)
        auto t_end = std::chrono::high_resolution_clock::now();
        double duration_ms = std::chrono::duration<double, std::milli>(t_end - t_start).count(); 
        ROS_INFO("[MIT PERF] Plan took %.4f ms (%d iters) | avg_E: %.4f | opt: %.2f",
                duration_ms, actual_iters, last_avg_E_total, delta_opt * 180.0 / M_PI);

        std_msgs::Float32 perf_msg; perf_msg.data = (float)duration_ms; perf_pub.publish(perf_msg);
        if (logger) logger->log({ts, "PERF", cycle_count, actual_iters, 0, 0, 0, 0, duration_ms, 0, 0, 0.0, 0.0, 0.0});

        if (!iter_buffer.empty() && logger) {
            for (size_t it_idx = 0; it_idx < iter_buffer.size(); ++it_idx) {
                for (size_t s = 0; s < iter_buffer[it_idx].size(); ++s) {
                    logger->log({ts, "PLANNING", cycle_count, (int)it_idx, (int)s,
                                    iter_buffer[it_idx][s].x, iter_buffer[it_idx][s].y, iter_buffer[it_idx][s].psi,
                                    iter_buffer[it_idx][s].e_lat, iter_buffer[it_idx][s].e_yaw, iter_buffer[it_idx][s].steer,
                                    iter_buffer[it_idx][s].e_total,
                                    iter_buffer[it_idx][s].w_lat, iter_buffer[it_idx][s].w_head});
                }
            }
            logger->flush();
        }

        // --- BƯỚC 7: MÔ PHỎNG QUỸ ĐẠO DỰ ĐOÁN CỦA GÓC LÁI HỘI TỤ CUỐI CÙNG (FINAL PLAN) ĐỂ GHI NHẬT KÝ ---
        double fx = x_ghost; double fy = y_ghost; double fpsi = psi_real;
        double sim_steer = last_steer_deg * M_PI / 180.0;
        for(int s = 0; s < steps; ++s) {
            sim_steer = alpha_sim * current_planned_steer + (1.0 - alpha_sim) * sim_steer;
            double tan_delta_final = tan(sim_steer);
            int map_idx = std::min(current_idx + s, (int)PathManager::state_refs.rows() - 1);
            double rx = PathManager::state_refs(map_idx, 0);
            double ry = PathManager::state_refs(map_idx, 1);
            double rp = PathManager::state_refs(map_idx, 2);
            double dx_e = fx - rx; double dy_e = fy - ry;
            double e_lat = -dx_e * sin(rp) + dy_e * cos(rp);
            double e_yaw = atan2(sin(fpsi - rp), cos(fpsi - rp));
            
            double E_norm = std::abs(e_lat) / 0.20;
            if (E_norm > 1.0) E_norm = 1.0 + 0.05 * (E_norm - 1.0);
            
            double yaw_err_norm = std::abs(e_yaw) / 1.57;
            if (yaw_err_norm > 1.0) yaw_err_norm = 1.0 + 0.05 * (yaw_err_norm - 1.0);
            
            if (logger) logger->log({ts, "FINAL_PLAN", cycle_count, 999, s, fx, fy, fpsi, E_norm, yaw_err_norm, current_planned_steer, 0.0, 0.0, 0.0});

            double dist_node = (s < steps - 1) ?
                sqrt(pow(PathManager::state_refs(map_idx+1,0)-rx,2)+pow(PathManager::state_refs(map_idx+1,1)-ry,2)) : 0.02;
            double dt_step = dist_node / std::max(0.1, v);
            double d_psi = (v * tan_delta_final / L) * dt_step;
            
            if (std::abs(d_psi) < 1e-4) {
                fx += v * dt_step * cos(fpsi); fy += v * dt_step * sin(fpsi); fpsi += d_psi;
            } else {
                double R = L / tan_delta_final;
                fx += R * (sin(fpsi + d_psi) - sin(fpsi));
                fy -= R * (cos(fpsi + d_psi) - cos(fpsi));
                fpsi += d_psi;
            }
            fpsi = atan2(sin(fpsi), cos(fpsi));
        }

        // --- BƯỚC 8: ĐÓNG GÓI LỆNH ĐIỀU KHIỂN & PHÁT LỆNH GỬI XUỐNG XE ---
        double steerDeg_raw = current_planned_steer * 180.0 / M_PI;
        if (std::isnan(steerDeg_raw)) steerDeg_raw = 0.0;
        
        // Lọc góc lái đầu ra (Hiện tại không lọc: alpha_out = 1)
        double steerDeg = alpha_out * steerDeg_raw + (1.0 - alpha_out) * last_steer_deg;
        last_steer_deg = steerDeg;
        
        ROS_INFO(">>> [REPLAN] Pos(%.2f, %.2f) -> Target[%d](<%.2f, %.2f>) | Steer: %.2f deg | Horizon: %d | Gamma: %.2f | E_lat: %.3fm",
                x_ghost, y_ghost, target_node_idx,
                PathManager::state_refs(target_node_idx, 0), PathManager::state_refs(target_node_idx, 1),
                steerDeg, steps, gamma, error_current);

        // Đóng gói JSON gửi sang topic ROS "/car1/command" điều khiển xe
        std_msgs::String speed_msg, steer_msg;
        std::stringstream ss_v, ss_s;
        ss_v << "{\"action\": \"1\", \"speed\": " << std::fixed << std::setprecision(2) << current_v_ref << "}";
        ss_s << "{\"action\": \"2\", \"steerAngle\": " << std::fixed << std::setprecision(2) << steerDeg << "}";
        speed_msg.data = ss_v.str(); steer_msg.data = ss_s.str();
        car_cmd_pub.publish(speed_msg); car_cmd_pub.publish(steer_msg);

        // Gửi thông số sai số để vẽ đồ thị 
        std_msgs::Float64MultiArray err_msg;
        err_msg.data.push_back(error_current); err_msg.data.push_back(steerDeg);
        error_pub.publish(err_msg);
        
        cycle_count++;
        if (logger && cycle_count % 10 == 0) logger->flush();
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "adaptive_mit_controller");
    AdaptiveMITControlNode node;
    ros::spin();
    return 0;
}