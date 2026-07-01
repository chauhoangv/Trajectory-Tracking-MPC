#pragma once

#include <boost/asio.hpp>
#include <ros/ros.h>
#include <sensor_msgs/Imu.h>
#include <nav_msgs/Odometry.h>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <memory>
#include <thread>
#include <string>
#include <vector>
#include <sstream>
#include <iomanip>
#include <cmath>
#include <algorithm>
#include <std_msgs/String.h>

namespace Sensing {

class SerialBridge {
public:
    SerialBridge(ros::NodeHandle& nh) {
        imu_pub = nh.advertise<sensor_msgs::Imu>("/car1/imu", 10);
        odom_pub = nh.advertise<nav_msgs::Odometry>("/car1/odometry", 10);

        try {
            serial = std::make_shared<boost::asio::serial_port>(io, "/dev/ttyACM0");
            serial->set_option(boost::asio::serial_port_base::baud_rate(115200));
            
            cmd_sub = nh.subscribe("/car1/command", 10, &SerialBridge::command_callback, this);

            std::this_thread::sleep_for(std::chrono::seconds(2));
            
            std::string init_cmds = "#kl:30;;\r\n#encoder:1;;\r\n#imu:1;;\r\n";
            boost::asio::write(*serial, boost::asio::buffer(init_cmds));
            ROS_INFO("Sensing Node: Active Nucleo: %s", init_cmds.c_str());

            start_async_read();
            worker_thread = std::thread([this]() { io.run(); });
            ROS_INFO("Sensing Node: Connected to /dev/ttyACM0");
        } catch (const std::exception& e) {
            ROS_ERROR("Sensing Node: Serial Error: %s", e.what());
        }
    }

    ~SerialBridge() { 
        if (serial && serial->is_open()) {
            std::string stop_cmds = "#speed:0.00;;\r\n#steer:0.00;;\r\n";
            boost::system::error_code ec;
            boost::asio::write(*serial, boost::asio::buffer(stop_cmds), ec);
        }
        io.stop(); 
        if(worker_thread.joinable()) worker_thread.join(); 
    }

private:
    boost::asio::io_service io;
    std::shared_ptr<boost::asio::serial_port> serial;
    std::thread worker_thread;
    ros::Publisher imu_pub, odom_pub;
    ros::Subscriber cmd_sub;

    char rxBuf[4096];
    std::size_t rxLen = 0;

    // Biến để ổn định hướng (Auto-Align)
    double yaw_offset = 0.0;
    bool yaw_initialized = false;
    bool is_reversing = false;

    // Speed smoothing state
    double filtered_vx = 0.0;
    const double alpha = 0.18; // EMA filter factor: lower = smoother, more lag.

    void command_callback(const std_msgs::String::ConstPtr& msg) {
        if (serial && serial->is_open()) {
            std::string data = msg->data;
            std::stringstream to_send;
            
            try {
                if (data.find("\"action\": \"1\"") != std::string::npos) {
                    size_t pos = data.find("\"speed\":");
                    if (pos != std::string::npos) {
                        double speed = std::stod(data.substr(pos + 8));
                        is_reversing = (speed < 0.0);
                        to_send << "#speed:" << std::fixed << std::setprecision(2) << speed * 1000 << ";;\r\n";
                    }
                } else if (data.find("\"action\": \"2\"") != std::string::npos) {
                    size_t pos = data.find("\"steerAngle\":");
                    if (pos != std::string::npos) {
                        double steer = std::stod(data.substr(pos + 13));
                        // Giới hạn góc lái an toàn (max 35 độ * 10 = 350) và đảo dấu Trái/Phải
                        double final_steer = std::clamp(-steer * 10.0, -200.0, 280.0);
                        to_send << "#steer:" << std::fixed << std::setprecision(2) << final_steer << ";;\r\n";
                    }
                }

                if (!to_send.str().empty()) {
                    boost::asio::write(*serial, boost::asio::buffer(to_send.str()));
                    // ROS_INFO("Sensing Node: Outgoing Serial: %s", to_send.str().c_str());
                }
            } catch (...) { /* Bỏ qua rác */ }
        }
    }

    void start_async_read() {
        serial->async_read_some(boost::asio::buffer(rxBuf + rxLen, 4096 - rxLen),
            [this](const boost::system::error_code& ec, std::size_t n) {
                if (!ec) { rxLen += n; scan_frames(); start_async_read(); }
            });
    }

    void scan_frames() {
        for (std::size_t i = 0; i < rxLen; ++i) {
            if (i > 0 && rxBuf[i-1] == ';' && rxBuf[i] == ';') {
                std::size_t end_idx = i - 1; 
                std::size_t start_idx = 0;
                bool found_at = false;
                for (std::size_t j = end_idx; j > 0; --j) {
                    if (rxBuf[j-1] == '@') {
                        start_idx = j - 1;
                        found_at = true;
                        break;
                    }
                }
                
                if (found_at) {
                    process_payload(rxBuf + start_idx, end_idx - start_idx);
                }
                
                std::size_t consumed = i + 1;
                while (consumed < rxLen && (rxBuf[consumed] == '\r' || rxBuf[consumed] == '\n')) {
                    consumed++;
                }
                
                std::memmove(rxBuf, rxBuf + consumed, rxLen - consumed);
                rxLen -= consumed;
                i = -1;
            }
        }
    }

    void process_payload(char* p, std::size_t len) {
        if (len == 0) return;
        char temp = p[len];
        p[len] = '\0';
        std::string payload(p);
        p[len] = temp;
        
        if (payload.length() > 3 && payload[0] == '@') {
            size_t colon_pos = payload.find(':');
            if (colon_pos != std::string::npos) {
                std::string id_str = payload.substr(1, colon_pos - 1);
                std::string val_str = payload.substr(colon_pos + 1);
                
                int id = 0;
                try { id = std::stoi(id_str); } catch(...) { return; }
                
                std::vector<double> values;
                std::stringstream ss(val_str);
                std::string item;
                while (std::getline(ss, item, ',')) {
                    try { values.push_back(std::stod(item)); } catch(...) {}
                }
                
                if (values.empty()) return;
                
                ROS_INFO_THROTTLE(1.0, "Raw Payload Dump: %s", payload.c_str());

                // ID 5 = Encoder Velocity (@5:<speed_cm_s>)
                if (id == 5) { 
                    nav_msgs::Odometry odom;
                    odom.header.stamp = ros::Time::now();
                    odom.header.frame_id = "odom";
                    odom.child_frame_id = "base_link";
                    
                    double raw_v = values[0];
                    double scale_factor = 102.735; 
                    double current_vx = std::abs(raw_v / scale_factor);
                    
                    if (is_reversing) {
                        current_vx = -current_vx;
                    }

                    // --- LOW PASS FILTER (EMA) ---
                    // Formula: y[n] = alpha * x[n] + (1 - alpha) * y[n-1]
                    filtered_vx = (alpha * current_vx) + (1.0 - alpha) * filtered_vx;
                    
                    // Apply a tiny deadband to force absolute zero when stopped
                    if (std::abs(filtered_vx) < 0.005) {
                        filtered_vx = 0.0;
                    }

                    odom.twist.twist.linear.x = filtered_vx;
                    
                    // Covariance: Since we are filtering, we can slightly 
                    // decrease the twist covariance to tell the EKF the signal is cleaner
                    for (int j = 0; j < 36; j += 7) {
                        odom.pose.covariance[j] = 0.01;
                        odom.twist.covariance[j] = 0.005; // Cleaner signal
                    }
                    odom_pub.publish(odom);
                }
                // ID 7 = IMU (Format: @7:<Roll>,<Pitch>,<Yaw>,<Gx>,<Gy>,<Gz>,<Ax>,<Ay>,<Az>)
                else if (id == 7 && values.size() == 9) { // Kiểm tra đúng 9 giá trị để tránh rác
                    // ROS_INFO("IMU Raw: val[0]=%.2f | val[1]=%.2f | val[2]=%.2f", values[0], values[1], values[2]);

                    sensor_msgs::Imu msg;
                    msg.header.stamp = ros::Time::now();
                    msg.header.frame_id = "chassis";
                    
                    // --- ORIENTATION từ Euler angles (Roll/Pitch/Yaw) ---
                    double roll_deg  = values[0];
                    double pitch_deg = values[1];
                    
                    // TỰ ĐỘNG CÂN BẰNG HƯỚNG: Lấy giá trị đầu tiên làm điểm 0 (North)
                    // SỬA LỖI: Bỏ qua 50 frame đầu tiên (khoảng 0.5s) chờ BNO055 khởi động xong để tránh dữ liệu rác
                    static int init_counter = 0;
                    if (!yaw_initialized) {
                        init_counter++;
                        if (init_counter > 50) {
                            yaw_offset = values[2];
                            yaw_initialized = true;
                            ROS_INFO("Sensing Node: Yaw Coordinated! Offset: %.2f", yaw_offset);
                        }
                    }
                    
                    // Tính Yaw tương đối so với lúc khởi động.
                    // Yaw ban đầu sẽ là 0.0 (Hướng Đông - Map East)
                    double yaw_deg = -(values[2] - yaw_offset) + 0.0;
                    ROS_INFO_THROTTLE(1.0, "IMU Check: RawYaw=%.2f | GyroZ=%.2f | FinalYaw=%.2f", values[2], values[5], yaw_deg);
                    
                    double rad = M_PI / 180.0;
                    tf2::Quaternion q;
                    q.setRPY(roll_deg * rad, pitch_deg * rad, yaw_deg * rad);
                    q.normalize();
                    
                    msg.orientation.x = q.x();
                    msg.orientation.y = q.y();
                    msg.orientation.z = q.z();
                    msg.orientation.w = q.w();
                    
                    // --- GYROSCOPE (Gx, Gy, Gz) - values[3,4,5] ---
                    // Chuyển từ Độ/giây sang Rad/giây (chuẩn ROS)
                    msg.angular_velocity.x = values[3] * rad;
                    msg.angular_velocity.y = values[4] * rad;
                    // ĐẢO DẤU Gz: IMU báo Phải=Dương, ROS cần Trái=Dương
                    msg.angular_velocity.z = -values[5] * rad;
                    
                    // Deadband nhỏ (0.01 rad/s ~ 0.57 deg/s) để lọc nhiễu số nguyên
                    if (std::abs(msg.angular_velocity.z) < 0.01) {
                        msg.angular_velocity.z = 0.0;
                    }
                    
                    // --- ACCELEROMETER (Ax, Ay, Az) - values[6,7,8] ---
                    // Ax: Hướng tới (Khớp chuẩn ROS)
                    // Ay: Hướng sang Trái (Khớp chuẩn ROS)
                    // Az: Linh kiện báo Xuống=Dương. ROS chuẩn Lên=Dương => PHẢI ĐẢO DẤU!
                    msg.linear_acceleration.x = values[6] * 9.81;
                    msg.linear_acceleration.y = values[7] * 9.81;
                    msg.linear_acceleration.z = -values[8] * 9.81; // Đảo dấu Az
                    
                    // Covariance: orientation nhỏ (tin tưởng cao vì là fusion từ Nucleo)
                    // angular_velocity trung bình, acceleration ít được dùng
                    msg.orientation_covariance[0] = 0.005;
                    msg.orientation_covariance[4] = 0.005;
                    msg.orientation_covariance[8] = 0.005;
                    msg.angular_velocity_covariance[0] = 0.02;
                    msg.angular_velocity_covariance[4] = 0.02;
                    msg.angular_velocity_covariance[8] = 0.02;
                    msg.linear_acceleration_covariance[0] = 0.04;
                    msg.linear_acceleration_covariance[4] = 0.04;
                    msg.linear_acceleration_covariance[8] = 0.04;
                    
                    imu_pub.publish(msg);
                }
            }
        }
    }
};
}