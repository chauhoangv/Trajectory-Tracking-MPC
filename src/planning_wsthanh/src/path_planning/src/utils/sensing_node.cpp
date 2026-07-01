#include <ros/ros.h>
#include "path_planning/utils/SerialBridge.h"

int main(int argc, char** argv) {
    ros::init(argc, argv, "sensing_node");
    ros::NodeHandle nh;

    Sensing::SerialBridge bridge(nh);

    ROS_INFO("Serial Driver Node Started");
    ros::spin(); // Background thread handles serial, main thread waits for Ctrl+C
    return 0;
}