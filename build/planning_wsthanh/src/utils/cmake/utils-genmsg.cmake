# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "utils: 11 messages, 5 services")

set(MSG_I_FLAGS "-Iutils:/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(utils_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" ""
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" ""
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" ""
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" "std_msgs/Float32MultiArray:std_msgs/MultiArrayLayout:std_msgs/MultiArrayDimension"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" "std_msgs/Float32MultiArray:std_msgs/MultiArrayLayout:std_msgs/MultiArrayDimension"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" "std_msgs/Float32MultiArray:std_msgs/MultiArrayLayout:utils/Point2D:std_msgs/MultiArrayDimension"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" "std_msgs/Float32MultiArray:std_msgs/MultiArrayLayout:std_msgs/MultiArrayDimension"
)

get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" NAME_WE)
add_custom_target(_utils_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "utils" "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_msg_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)

### Generating Services
_generate_srv_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_srv_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_srv_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_srv_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)
_generate_srv_cpp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
)

### Generating Module File
_generate_module_cpp(utils
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(utils_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(utils_generate_messages utils_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" NAME_WE)
add_dependencies(utils_generate_messages_cpp _utils_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(utils_gencpp)
add_dependencies(utils_gencpp utils_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS utils_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_msg_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)

### Generating Services
_generate_srv_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_srv_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_srv_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_srv_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)
_generate_srv_eus(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
)

### Generating Module File
_generate_module_eus(utils
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(utils_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(utils_generate_messages utils_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" NAME_WE)
add_dependencies(utils_generate_messages_eus _utils_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(utils_geneus)
add_dependencies(utils_geneus utils_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS utils_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_msg_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)

### Generating Services
_generate_srv_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_srv_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_srv_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_srv_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)
_generate_srv_lisp(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
)

### Generating Module File
_generate_module_lisp(utils
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(utils_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(utils_generate_messages utils_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" NAME_WE)
add_dependencies(utils_generate_messages_lisp _utils_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(utils_genlisp)
add_dependencies(utils_genlisp utils_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS utils_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_msg_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)

### Generating Services
_generate_srv_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_srv_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_srv_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_srv_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)
_generate_srv_nodejs(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
)

### Generating Module File
_generate_module_nodejs(utils
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(utils_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(utils_generate_messages utils_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" NAME_WE)
add_dependencies(utils_generate_messages_nodejs _utils_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(utils_gennodejs)
add_dependencies(utils_gennodejs utils_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS utils_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_msg_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)

### Generating Services
_generate_srv_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_srv_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_srv_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_srv_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)
_generate_srv_py(utils
  "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
)

### Generating Module File
_generate_module_py(utils
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(utils_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(utils_generate_messages utils_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv" NAME_WE)
add_dependencies(utils_generate_messages_py _utils_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(utils_genpy)
add_dependencies(utils_genpy utils_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS utils_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/utils
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(utils_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/utils
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(utils_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/utils
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(utils_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/utils
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(utils_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/utils
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(utils_generate_messages_py std_msgs_generate_messages_py)
endif()
