#! /bin/sh.

## building packages with colcon

## installing colcon
sudo apt install python3-colcon-common-extensions




## creating workspace
# creating a directory
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
# adding sources
git clone https://github.com/ros2/examples src/examples -b humble
colcon build --symlink-install

## running tests
colcon test

## sourcing the environment
source install/setup.bash

## trying out a demo
ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function
ros2 run examples_rclcpp_minimal_publisher publisher_member_function

## creating my own package
# setting up colcon_cd
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=/opt/ros/humble/" >> ~/.bashrc


# setting up colcon tab completion
echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc

