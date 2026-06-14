#!/bin/bash
set -e

# Start Nginx web server in the background
echo "Starting Nginx web server on port 7000..."
service nginx start

# Source the ROS 2 environment
echo "Sourcing ROS 2 Environments..."
source /opt/ros/humble/setup.bash
source /ros2_ws/install/setup.bash

echo "Launching Rosbridge WebSocket Server on port 9090..."
ros2 launch rosbridge_server rosbridge_websocket_launch.xml &

echo "Launching Web Video Server on port 11315..."
ros2 run web_video_server web_video_server --ros-args -p port:=11315 &

echo "Launching TF2 Web Republisher..."
ros2 run tf2_web_republisher_py tf2_web_republisher