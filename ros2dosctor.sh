#! /bin/sh.


## checking the setup
ros2 doctor

## checking a  system
ros2 run turtlesim turtlesim_node
# in a new terminal
ros2 run turtlesim turtle_teleop_key

## in two new terminals
ros2 topic echo /turtle1/color_sensor
ros2 topic echo /turtle1/pose


## getting a full report
ros2 doctor --report
