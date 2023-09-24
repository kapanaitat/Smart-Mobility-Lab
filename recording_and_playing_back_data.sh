#! /bin/sh.

## setup
# in a new terminal
ros2 run turtlesim turtlesim_node
# in a new terminal
ros2 run turtlesim turtle_teleop_key
# making new directory to store the recordings
mkdir bag_files
cd bag_files

## choosing a topic

# checking the topic list
ros2 topic list
ros2 topic echo /turtle1/cmd_vel

## ros2 bag recording, ros2 bag record <topic_name>
ros2 bag record /turtle1/cmd_vel


## recording multiple topics
ros2 bag record -o subset /turtle1/cmd_vel /turtle1/pose


## ros2 bag info, ros2 bag info <bag_file_name>
ros2 bag info subset

## ros2 bag play
ros2 bag play subset


## to see how the data is saved
ros2 topic hz /turtle1/pose

##
