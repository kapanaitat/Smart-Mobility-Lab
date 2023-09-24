#! /bin/sh.

## ros2 run to run turtlesim
ros2 run turtlesim turtlesim_node

## ros2 node list
ros2 node list

# teleop node in a new terminal
ros2 run turtlesim turtle_teleop_key

## remapping to reassign default node properties
ros2 run turtlesim turtlesim_node --ros-args --remap __node:=my_turtle

## ros2 node info
ros2 node info /my_turtle

