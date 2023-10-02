#! /bin/sh.

## discovering available components
ros2 component types

## starting the component container
ros2 run rclcpp_components component_container
ros2 component list

# loading the talker component
ros2 component load /ComponentManager composition composition::Talker

# loading the listener component
ros2 component load /ComponentManager composition composition::Listener

## inspecting the container state
ros2 component list

## server client
ros2 run rclcpp_components component_container
ros2 component load /ComponentManager composition composition::Server
ros2 component load /ComponentManager composition composition::Client
ros2 run composition manual_composition


## dlopen
ros2 run composition dlopen_composition `ros2 pkg prefix composition`/lib/libtalker_component.so `ros2 pkg prefix composition`/lib/liblistener_component.so

## launch actions
ros2 launch composition composition_demo.launch.py

## unloading components
ros2 run rclcpp_components component_container
ros2 component list
ros2 component load /ComponentManager composition composition::Talker
ros2 component load /ComponentManager composition composition::Listener
ros2 component unload /ComponentManager 1 2


## remapping container name and namespace
ros2 run rclcpp_components component_container --ros-args -r __node:=MyContainer -r __ns:=/ns
ros2 component load /ns/MyContainer composition composition::Listener

## remapping component names and namespace
ros2 run rclcpp_components component_container
ros2 component load /ComponentManager composition composition::Talker --node-name talker2
ros2 component load /ComponentManager composition composition::Talker --node-namespace /ns
ros2 component load /ComponentManager composition composition::Talker --node-name talker3 --node-namespace /ns2
ros2 component list


## passing parameter values and additional arguments
ros2 component load /ComponentManager image_tools image_tools::Cam2Image -p burger_mode:=true
ros2 component load /ComponentManager composition composition::Talker -e use_intra_process_comms:=true

##unloading components
