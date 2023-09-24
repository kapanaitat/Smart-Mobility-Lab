#! /bin/sh.

## installing turtlesim
sudo apt update
sudo apt install ros-humble-turtlesim

#checking the installation of the package
ros2 pkg executables turtlesim

#starting turtlesim
ros2 run turtlesim turtlesim_node ## a simulation window with a turtle should open

## using tustlesim
# node to control the turtle, in a new terminal
ros2 run turtlesim turtle_teleop_key


## installing rqt in a neww terminal
sudo apt update
sudo apt install ~nros-humble-rqt*

#running rqt
rqt

## using rqt
# selecting plugins -> services -> service caller
# trying the sprawn service to make a second turtle
# trying the set_pen sercice for turtle1


## remapping to switch controls between turtles
ros2 run turtlesim turtle_teleop_key --ros-args --remap turtle1/cmd_vel:=turtle2/cmd_vel
