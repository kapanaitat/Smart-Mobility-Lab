#! /bin/sh.


## setup
# in a new window
ros2 run turtlesim turtlesim_node
# in a new window
ros2 run turtlesim turtle_teleop_key

## node info in a new terminal
ros2 node info /turtlesim

## action list 
ros2 action list

## checking action list with types
ros2 action list -t

## action info
ros2 action info /turtle1/rotate_absolute

## interface show
ros2 interface show turtlesim/action/RotateAbsolute

## action send goal, ros2 action send_goal <action_name> <action_type> <values>
ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: 1.57}"

## checking feedback of the goal
ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: -1.57}" --feedback
