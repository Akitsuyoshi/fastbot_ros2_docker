#!/bin/bash
set -e
export ROS_DOMAIN_ID=1
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=/var/lib/theconstruct.rrl/cyclonedds_husarnet.xml
# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
# source "~/ros2_ws/install/setup.bash"
exec "$@"
