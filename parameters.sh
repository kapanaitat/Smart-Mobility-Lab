#! /bin/sh.

## setup
# in a new terminal
ros2 run turtlesim turtlesim_node
# in a new terminal
ros2 run turtlesim turtle_teleop_key


## ros2 param list in a new terminal
ros2 param list

## param get, ros2 param get <node_name> <parameter_name>
ros2 param get /turtlesim background_g


## param set, ros2 param set <node_name> <parameter_name> <value>
ros2 param set /turtlesim background_r 150

## param dumb, ros2 param dump <node_name>
ros2 param dump /turtlesim > turtlesim.yaml

## param laod, ros2 run <package_name> <executable_name> --ros-args --params-file <file_name>
ros2 run turtlesim turtlesim_node --ros-args --params-file turtlesim.yaml




