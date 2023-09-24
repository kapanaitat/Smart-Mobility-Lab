#! /bin/sh.

## sourcing ROS2 environment
source /opt/ros/humble/setup.bash

## creating a new directory
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src

## cloning a sample repo
git clone https://github.com/ros/ros_tutorials.git -b humble

## resolving dependencies
# cd if you're still in the ``src`` directory with the ``ros_tutorials`` clone
cd ..
rosdep install -i --from-path src --rosdistro humble -y


## building the  workspace with colcon
colcon build

build  install  log  src

## sourcing the overlay
source /opt/ros/humble/setup.bash
cd ~/ros2_ws
source install/local_setup.bash
ros2 run turtlesim turtlesim_node

## modifying the overlay
ros2 run turtlesim turtlesim_node
# in a new terminal
ros2 run turtlesim turtlesim_node




## creating a package
cd ~/ros2_ws/src
ros2 pkg create --build-type ament_cmake <package_name>
ros2 pkg create --build-type ament_cmake --node-name my_node my_package


## building a package
cd ~/ros2_ws
colcon build
colcon build --packages-select my_package

## sourcing the setup file
source install/local_setup.bash

## using the package
ros2 run my_package my_node


