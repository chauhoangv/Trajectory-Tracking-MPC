cmake_minimum_required(VERSION 3.0.2)
project(path_planning)

add_compile_options(-std=c++17)

# 1. Tách yaml-cpp ra khỏi find_package(catkin)
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  sensor_msgs
  nav_msgs
  tf2
  tf2_geometry_msgs
  utils
  communication
  alglib_pkg
  serial
  robot_localization
)

# 2. Sử dụng PkgConfig để tìm yaml-cpp từ hệ thống Ubuntu
find_package(PkgConfig REQUIRED)
pkg_check_modules(YAML_CPP REQUIRED yaml-cpp)

find_package(Eigen3 REQUIRED)
find_package(Boost REQUIRED COMPONENTS graph system thread)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES alglib_pkg
)

# Install Python scripts
catkin_install_python(PROGRAMS
  src/persistence/planner.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

# 3. Thêm đường dẫn include của YAML_CPP vào đây
include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
  ${EIGEN3_INCLUDE_DIRS}
  ${YAML_CPP_INCLUDE_DIRS}
)

add_library(track
  src/map/Track.cpp
  src/utils/PathUtils.cpp
  src/utils/SplineUtils.cpp
  src/utils/Utility.cpp
  src/utils/TrafficClient.cpp  
)

add_library(path_planner
  src/planning/PathPlanner.cpp
)

target_link_libraries(track
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
  communication
)

target_link_libraries(path_planner
  track
)

add_executable(path_manager_node
  src/path_manager_node.cpp
)
add_executable(sensing_node 
  src/utils/sensing_node.cpp
)

target_link_libraries(sensing_node
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
  pthread
)

target_link_libraries(path_manager_node
  path_planner
  ${catkin_LIBRARIES}
  ${YAML_CPP_LIBRARIES}
)