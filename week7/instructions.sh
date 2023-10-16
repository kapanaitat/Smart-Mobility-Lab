#! /bin/sh


## creating a ROS2 workspace
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
colcon build


## creating a package
ros2 pkg create turtlebot_navigation

## creating action directory
mkdir -p ~/ros2_ws/src/turtlebot_navigation/turtlebot_navigation/action


## creating the action message file
touch ~/ros2_ws/src/turtlebot_navigation/action/MoveToGoal.action

## edit MoveToGoal.action
# geometry_msgs/Point goal
# ---
# geometry_msgs/Twist result
# ---
# int32 feedback



## creatingg action server node
touch ~/ros2_ws/src/turtlebot_navigation/move_to_goal_server.py

## edit the server file


## creating action client node
touch ~/ros2_ws/src/turtlebot_navigation/move_to_goal_client.py

## edit the client file


## building the package
colcon build

## sourcing the workspace
source ~/ros2_ws/install/setup.bash


## running in different terminals
ros2 run turtlebot_navigation move_to_goal_server.py

ros2 run turtlebot_navigation move_to_goal_client.py
