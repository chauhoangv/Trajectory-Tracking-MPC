cmake_minimum_required(VERSION 3.0.2)
project(localization)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  sensor_msgs
  nav_msgs
  tf2
  tf2_geometry_msgs
  robot_localization
  geometry_msgs
)

catkin_package(
  INCLUDE_DIRS
  LIBRARIES
  CATKIN_DEPENDS roscpp rospy std_msgs sensor_msgs nav_msgs tf2 tf2_geometry_msgs robot_localization geometry_msgs
  DEPENDS
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
