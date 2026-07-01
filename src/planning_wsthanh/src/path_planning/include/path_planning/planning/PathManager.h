#pragma once

#include "path_planning/map/GroundTruth.h"
#include "PathPlanner.hpp"
#include "TcpClient.hpp"
#include "path_planning/utils/Utility.hpp"
#include "utils/helper.h"
#include "std_msgs/Float32MultiArray.h"
#include "std_srvs/TriggerResponse.h"
#include "utils/constants.h"
#include "utils/go_to.h"
#include "utils/go_to_multiple.h"
#include "utils/waypoints.h"
#include <Eigen/Dense>
#include <chrono>
#include <cmath>
#include <ros/ros.h>
#include <std_srvs/Trigger.h>
#include <vector>
#include <string>
#include <atomic>
#include <std_msgs/String.h>

namespace PathManager {

inline std::atomic<bool> path_manager_initialized = false;
inline ros::NodeHandle* nh = nullptr;
inline PathPlanner path_planner{0.2, 40, 0.1}; // v_ref=0.2, T=0.1 => 2cm nodes

inline double T = 0.1;
inline int N = 40;
inline double v_ref = 0.2;
inline std::string pathName = "runGreedyPath";

inline double density = 1.0 / T / v_ref; 
inline double region_of_acceptance = 0.03076923 * 3 * (0.1 * 1.3) / density;
inline double region_of_acceptance_cw = region_of_acceptance / 1.5;
inline double region_of_acceptance_hw = region_of_acceptance * 1.5;

inline double t0 = 0.0;
inline int closest_waypoint_index = 0;
inline int target_waypoint_index = 0;
inline int last_waypoint_index = 0;
inline int overtake_end_index = 0;
inline double rdb_circumference = 3.95;
inline bool debug = true;

inline int v_ref_int = static_cast<int>(v_ref * 100);

inline ros::ServiceClient waypoints_client;
inline ros::ServiceClient go_to_client;
inline ros::ServiceClient go_to_multiple_client;
inline ros::ServiceClient trigger_client;

// --- QUẢN LÝ TOẠ ĐỘ VÀ TRẠNG THÁI ---
inline Eigen::MatrixXd state_refs, state_refs_original;  
inline Eigen::MatrixXd input_refs;
inline Eigen::MatrixXd normals;
inline Eigen::VectorXd state_attributes;  
inline Eigen::MatrixXd* state_refs_ptr = &state_refs;

inline std::vector<int> intersection_indices;
inline std::vector<int> intersection_state_refs_indices;
inline int intersection_index = 0;

enum ATTRIBUTE { NORMAL, CROSSWALK, INTERSECTION, ONEWAY, HIGHWAYLEFT, HIGHWAYRIGHT, ROUNDABOUT, STOPLINE, DOTTED, DOTTED_CROSSWALK };

enum class TrafficSign {
  NONE = 0, STOP, PRIORITY, CROSSWALK, HIGHWAY_ENTRY, HIGHWAY_EXIT, ROUNDABOUT, ONE_WAY, NO_ENTRY, RED_LIGHT, GREEN_LIGHT, PARKING, PEDESTRIAN
};

enum class ParkingState {
    IDLE, APPROACHING, READY_TO_REVERSE, REVERSE_STAGE_1, REVERSE_STAGE_2, FORWARD_ADJUST, WAITING, EXIT_STAGE_1, EXIT_STAGE_2
};

inline TrafficSign current_sign = TrafficSign::NONE;
inline bool is_stopping_for_sign = false;
inline ros::Time stop_start_time;
inline ros::Time last_sign_time;
inline ros::Time last_stop_cleared_time = ros::Time(0);

inline bool is_in_highway = false;
inline bool is_in_roundabout = false;
inline bool is_one_way_road = false;

inline ParkingState parking_state = ParkingState::IDLE;

/**
* @brief Hàm Callback nhận tín hiệu biển báo từ Camera
*/
inline void signCallback(const std_msgs::String::ConstPtr& msg) {
 last_sign_time = ros::Time::now(); 
 std::string detected = msg->data; 

 if (detected.find("stop") != std::string::npos) current_sign = TrafficSign::STOP;
 else if (detected.find("priority") != std::string::npos) current_sign = TrafficSign::PRIORITY;
 else if (detected.find("crosswalk") != std::string::npos) current_sign = TrafficSign::CROSSWALK;
 else if (detected.find("highway_exit") != std::string::npos) current_sign = TrafficSign::HIGHWAY_EXIT;
 else if (detected.find("highway") != std::string::npos) current_sign = TrafficSign::HIGHWAY_ENTRY;
 else if (detected.find("roundabout") != std::string::npos) current_sign = TrafficSign::ROUNDABOUT;
 else if (detected.find("onewayroad") != std::string::npos) current_sign = TrafficSign::ONE_WAY;
 else if (detected.find("no_entry") != std::string::npos) current_sign = TrafficSign::NO_ENTRY;
 else if (detected.find("pedestrian") != std::string::npos) current_sign = TrafficSign::PEDESTRIAN; 
 else if (detected.find("trafficlight_red") != std::string::npos) current_sign = TrafficSign::RED_LIGHT;
 else if (detected.find("trafficlight_green") != std::string::npos) current_sign = TrafficSign::GREEN_LIGHT;
 else if (detected.find("parking") != std::string::npos) current_sign = TrafficSign::PARKING;
 else current_sign = TrafficSign::NONE;

 switch(current_sign) {
     case TrafficSign::STOP:
       if (!is_stopping_for_sign && (ros::Time::now() - last_stop_cleared_time).toSec() > 5.0) {
           is_stopping_for_sign = true; stop_start_time = ros::Time::now();
           ROS_INFO_THROTTLE(2, "[CAMERA] Bien STOP: Dung 3s.");
       }
       break;
     default: break;
 }
}

inline void init(ros::NodeHandle& nh_, double T_, int N_, double v_ref_, const std::string& pathName_) {
  nh = &nh_; T = T_; N = N_; v_ref = v_ref_; pathName = pathName_;
  density = 1.0 / T / v_ref;
  region_of_acceptance = 0.03076923 * 3 * (0.125 * 1.3) / density;
  v_ref_int = static_cast<int>(v_ref * 100);
  path_planner = PathPlanner(v_ref, N, T);
  waypoints_client = nh->serviceClient<utils::waypoints>("/waypoint_path");
  go_to_client = nh->serviceClient<utils::go_to>("/go_to");
  trigger_client = nh->serviceClient<std_srvs::Trigger>("/notify_params_updated");
  path_manager_initialized = true;
}

inline void init(ros::NodeHandle& nh_) { init(nh_, 0.1, 40, 0.2, "runGreedyPath"); }

inline bool find_intersections(Utility& utils) {
  intersection_indices.clear(); intersection_state_refs_indices.clear();
  if (state_refs.rows() == 0) return false;
  // ... (Phần logic tìm ngã tư)
  return true;
}

inline int closest_idx_attribute() { return (state_attributes.size() > 0) ? state_attributes(target_waypoint_index) : -1; }

inline bool loading_condensed_path() {
  std_msgs::Float32MultiArray s, i, a, n;
  path_planner.set_constraints(v_ref, N, T, pathName);
  path_planner.plan_path(s, i, a, n);
  if (s.data.empty()) return false;
  int num = s.data.size() / 3;
  state_refs = Eigen::Map<const Eigen::Matrix<float, Eigen::Dynamic, 3, Eigen::RowMajor>>(s.data.data(), num, 3).cast<double>();
  state_attributes = Eigen::Map<const Eigen::VectorXf>(a.data.data(), num).cast<double>();
  state_refs_original = state_refs;
  target_waypoint_index = 0; last_waypoint_index = 0;
  return true;
}

inline int find_next_waypoint(int& output_target, const Eigen::Vector3d& x_curr) {
  int lookahead = 2;
  int start = std::max(last_waypoint_index - 2, 0);
  int end = std::min(last_waypoint_index + 40, (int)state_refs.rows() - 1);
  double min_sq = 1e9; int best = last_waypoint_index;
  for (int i = start; i <= end; ++i) {
      double d = pow(state_refs(i,0)-x_curr[0],2) + pow(state_refs(i,1)-x_curr[1],2);
      if (d < min_sq) { min_sq = d; best = i; }
  }
  last_waypoint_index = best;
  output_target = std::min(best + lookahead, (int)state_refs.rows() - 1);
  return 1;

}

inline int find_closest_waypoint2(const Eigen::Vector2d& pos, double radius) {
  if (state_refs_original.rows() == 0) return -1;
  double min_dist_sq = radius * radius;
  int best_idx = -1;
  for (int i = 0; i < state_refs_original.rows(); ++i) {
      double dx = state_refs_original(i, 0) - pos[0];
      double dy = state_refs_original(i, 1) - pos[1];
      double dist_sq = dx * dx + dy * dy;
      if (dist_sq < min_dist_sq) {
          min_dist_sq = dist_sq;
          best_idx = i;
      }
  }
  return best_idx;
}

inline bool attribute_cmp(int index, ATTRIBUTE attr) {
  if (index < 0 || index >= state_attributes.size()) return false;
  return std::abs(state_attributes(index) - static_cast<double>(attr)) < 1e-3;
}

} // namespace PathManager
