#! /bin/sh.

## Accessing ROS2 commands
source /opt/ros/humble/setup.bash


## Adding sourcing to the shell script
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

## Checking environment variables
printenv | grep -i ROS



## ROS_DOMAIN_ID variable, my id was 100
export ROS_DOMAIN_ID=100
echo "export ROS_DOMAIN_ID=100" >> ~/.bashrc

## ROS_LOCAL_HOST_ONLY variable
export ROS_LOCALHOST_ONLY=1
echo "export ROS_LOCALHOST_ONLY=1" >> ~/.bashrc
