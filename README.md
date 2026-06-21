# FastBot ROS2 Docker

## Overview

Docker environment for running the FastBot robot in simulation and on the real robot.

Simulation containers:

- `fastbot-ros2-gazebo` — Gazebo simulation
- `fastbot-ros2-slam` — SLAM and localization
- `fastbot-ros2-webapp` — Web control interface

Real robot containers:

- `fastbot-ros2-real` — Robot drivers and ROS2 system
- `fastbot-ros2-real-slam` — SLAM and localization

> **Note:** Simulation uses **Linux AMD64 (x86_64)**, while the real FastBot robot uses **Linux ARM64 (aarch64)**.


## Prerequisites

Simulation:

- Docker and Docker Compose
- Graphical environment for Gazebo

Real robot:

Refer to the FastBot setup instructions:

https://github.com/Akitsuyoshi/fastbot

## Running the Simulation

Navigate to the simulation directory in `CP22 rosject`:

```bash
cd ~/ros2_ws/src/fastbot_ros2_docker/simulation
```

Start all required containers:

```bash
docker-compose up
```

Check the containers are running:

```bash
docker ps --format "{{.Image}}"
```

Expected output should include:

```text
akitsuyoshi/akitsuyoshi-cp22:fastbot-ros2-webapp
akitsuyoshi/akitsuyoshi-cp22:fastbot-ros2-slam
akitsuyoshi/akitsuyoshi-cp22:fastbot-ros2-gazebo
```

Stop the containers:

```bash
docker-compose down
```

## Running real Fastbot robot

Connect to the robot:

```bash
ssh fastbot@fastbot.local
```

Clone the repository:

```bash
cd
mkdir docker
cd docker
git clone https://github.com/Akitsuyoshi/fastbot_ros2_docker.git
cd fastbot_ros2_docker/real
```

Start all required containers:

```bash
docker-compose up
```

Check that all required containers are running:

```bash
docker ps --format "{{.Image}}"
```

Expected output should include:

```text
akitsuyoshi/akitsuyoshi-cp22:fastbot-ros2-real
akitsuyoshi/akitsuyoshi-cp22:fastbot-ros2-slam-real
```

Check ros2 topics:

```bash
source ~/docker/fastbot_ros2_docker/real/ros_entrypoint.sh
ros2 topic list
```

Expected output will be:

```text
/fastbot/cmd_vel
/fastbot/encoder_vals
/fastbot/joint_states
/fastbot/motor_vels
/fastbot/odom
/fastbot/scan
/fastbot_camera/camera_info
/fastbot_camera/image_raw
/tf
/tf_static
...
```

Move the robot via teleop:

```
source ~/docker/fastbot_ros2_docker/real/ros_entrypoint.sh
ros2 run teleop_twist_keyboard teleop_twist_keyboard --ros-args --remap cmd_vel:=/fastbot/cmd_vel
```

Stop the containers:

```bash
docker-compose down
```

## Validating the robot systems in rosject

From the rosject environment, check ros2 topics:

```bash
source ~/docker/fastbot_ros2_docker/real/ros_entrypoint.sh
ros2 topic list
```

Run rviz2 to visualize the generated map:

```bash
source ~/docker/fastbot_ros2_docker/real/ros_entrypoint.sh
rviz2 -d ~/docker/fastbot_ros2_docker/real/mapping.rviz
```

## Automatic Startup

To automatically start Docker containers after robot power-on, install the systemd service:

```bash
sudo cp ~/docker/fastbot_ros2_docker/real/fastbot_compose.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable fastbot_compose.service
sudo systemctl start fastbot_compose.service
```

Check status:

```bash
systemctl status fastbot_compose.service
```