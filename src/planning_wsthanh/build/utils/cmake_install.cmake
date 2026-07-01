# Install script for directory: /home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/utils/msg" TYPE FILE FILES
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/IMU.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/localisation.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sign.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane2.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Lane3.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/encoder.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/ImgInfo.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Sensors.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/odometry.msg"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/msg/Point2D.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/utils/srv" TYPE FILE FILES
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/waypoints.srv"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to.srv"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/go_to_multiple.srv"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/goto_command.srv"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/srv/set_states.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/utils/cmake" TYPE FILE FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/build/utils/catkin_generated/installspace/utils-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/devel/include/utils")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/devel/share/roseus/ros/utils")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/devel/share/common-lisp/ros/utils")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/devel/share/gennodejs/ros/utils")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/devel/lib/python3/dist-packages/utils")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/devel/lib/python3/dist-packages/utils")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/build/utils/catkin_generated/installspace/utils.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/utils/cmake" TYPE FILE FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/build/utils/catkin_generated/installspace/utils-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/utils/cmake" TYPE FILE FILES
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/build/utils/catkin_generated/installspace/utilsConfig.cmake"
    "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/build/utils/catkin_generated/installspace/utilsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/utils" TYPE FILE FILES "/home/thenewbies/Chau_Workspace/src/planning_wsthanh/src/utils/package.xml")
endif()

