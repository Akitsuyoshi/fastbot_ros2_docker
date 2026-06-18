# FastBot ROS2 Docker

## Overview

This project provides a Docker-based environment for the FastBot robot in both simulation and real robot.

The simulation consists of three Docker containers:

* `fastbot-ros2-gazebo` – Gazebo simulation environment
* `fastbot-ros2-slam` – SLAM and robot localization
* `fastbot-ros2-webapp` – Web-based robot control and visualization

The real consists of two Docker containers:

* `fastbot-ros2-real` – Real robot environment
* `fastbot-ros2-real-slam` – SLAM and robot localization

**Note:** The `simulation` environment targets **Linux AMD64 (x86_64)** platforms, while the `real` FastBot robot environment targets **Linux ARM64 (aarch64)** platforms.

## Prerequisites

Before starting the `simulation`, ensure that:

* Docker and Docker Compose are installed
* The graphical environment is available for Gazebo visualization

Before deploying to the `real FastBot robot`, please refer to the prerequisites and hardware setup instructions in the FastBot repository:

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

Check that all required containers are running:

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

Connect to Fastbot robot from `host`:

```bash
ssh fastbot@fastbot.local
```

Make a working directory for docker:

```bash
cd
mkdir docker
cd docker
```

Clone the repository into the working directory:

```bash
git clone https://github.com/Akitsuyoshi/fastbot_ros2_docker.git
```

Navigate to the real directory:

```bash
cd fastbot_ros2_docker/real/
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

Check the ros2 topics:

```bash
cd
source docker/fastbot_ros2_docker/real/ros_entrypoint.sh
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

Stop the containers:

```bash
docker-compose down
```

## Validating the robot systems in rosject

Check rosject is conneted to physical robot, fastbot.

Connect to Fastbot robot from `rosject`:

```bash
ssh fastbot@fastbot.local
```

Check all the robot systems have been started properly:

```bash
cd
source docker/fastbot_ros2_docker/real/ros_entrypoint.sh
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

Run rviz2 to show generated map:

```bash
cd
source docker/fastbot_ros2_docker/real/ros_entrypoint.sh
rviz2 -d docker/fastbot_ros2_docker/real/mapping.rviz
```
