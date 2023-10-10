#! /bin/sh


## after navigating to ros2_ws/src/cpp_pubsub/src 
wget -O member_function_with_topic_statistics.cpp https://raw.githubusercontent.com/ros2/examples/humble/rclcpp/topics/minimal_subscriber/member_function_with_topic_statistics.cpp


## in CMakeLists.txt adding the executable listener_with_topic_statistics
add_executable(listener_with_topic_statistics src/member_function_with_topic_statistics.cpp)
ament_target_dependencies(listener_with_topic_statistics rclcpp std_msgs)

install(TARGETS
  talker
  listener
  listener_with_topic_statistics
  DESTINATION lib/${PROJECT_NAME})



## building and running
ros2 run cpp_pubsub listener_with_topic_statistics
ros2 run cpp_pubsub talker


## observing published static data
ros2 topic list
ros2 topic echo /statistics
