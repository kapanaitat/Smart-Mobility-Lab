#! /bin/sh

## creating a package
ros2 pkg create --build-type ament_cmake --license Apache-2.0 bag_reading_cpp --dependencies rclcpp rosbag2_cpp turtlesim



## updating package.xml
<description>C++ bag reading tutorial</description>
<maintainer email="you@email.com">Your Name</maintainer>
<license>Apache-2.0</license>


## cpp reader in scr directory
#include <chrono>
#include <functional>
#include <iostream>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"
#include "rclcpp/serialization.hpp"
#include "rosbag2_cpp/reader.hpp"
#include "turtlesim/msg/pose.hpp"

using namespace std::chrono_literals;

class PlaybackNode : public rclcpp::Node
{
  public:
    PlaybackNode(const std::string & bag_filename)
    : Node("playback_node")
    {
      publisher_ = this->create_publisher<turtlesim::msg::Pose>("/turtle1/pose", 10);
      timer_ = this->create_wall_timer(
          100ms, std::bind(&PlaybackNode::timer_callback, this));

      reader_.open(bag_filename);
    }

  private:
    void timer_callback()
    {
      while (reader_.has_next()) {
        rosbag2_storage::SerializedBagMessageSharedPtr msg = reader_.read_next();

        if (msg->topic_name != "/turtle1/pose") {
          continue;
        }

        rclcpp::SerializedMessage serialized_msg(*msg->serialized_data);
        turtlesim::msg::Pose::SharedPtr ros_msg = std::make_shared<turtlesim::msg::Pose>();

        serialization_.deserialize_message(&serialized_msg, ros_msg.get());

        publisher_->publish(*ros_msg);
        std::cout << '(' << ros_msg->x << ", " << ros_msg->y << ")\n";

        break;
      }
    }

    rclcpp::TimerBase::SharedPtr timer_;
    rclcpp::Publisher<turtlesim::msg::Pose>::SharedPtr publisher_;

    rclcpp::Serialization<turtlesim::msg::Pose> serialization_;
    rosbag2_cpp::Reader reader_;
};

int main(int argc, char ** argv)
{
  if (argc != 2) {
    std::cerr << "Usage: " << argv[0] << " <bag>" << std::endl;
    return 1;
  }

  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<PlaybackNode>(argv[1]));
  rclcpp::shutdown();

  return 0;
}




## adding executable in CMakeLists.txt
add_executable(simple_bag_reader src/simple_bag_reader.cpp)
ament_target_dependencies(simple_bag_reader rclcpp rosbag2_cpp turtlesim)

install(TARGETS
  simple_bag_reader
  DESTINATION lib/${PROJECT_NAME}
)



## building and running
colcon build --packages-select bag_reading_cpp
source install/setup.bash
ros2 run bag_reading_cpp simple_bag_reader /path/to/setup



