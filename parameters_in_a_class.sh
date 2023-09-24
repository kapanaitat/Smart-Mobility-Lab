#! /bin/sh.

## creating a package
ros2 pkg create --build-type ament_cmake cpp_parameters --dependencies rclcpp


## updating package.xml
<description>C++ parameter tutorial</description>
<maintainer email="you@email.com">Your Name</maintainer>
<license>Apache License 2.0</license>


## inside the directory make a cpp file
#include <chrono>
#include <functional>
#include <string>

#include <rclcpp/rclcpp.hpp>

using namespace std::chrono_literals;

class MinimalParam : public rclcpp::Node
{
public:
  MinimalParam()
  : Node("minimal_param_node")
  {
    this->declare_parameter("my_parameter", "world");

    timer_ = this->create_wall_timer(
      1000ms, std::bind(&MinimalParam::timer_callback, this));
  }

  void timer_callback()
  {
    std::string my_param = this->get_parameter("my_parameter").as_string();

    RCLCPP_INFO(this->get_logger(), "Hello %s!", my_param.c_str());

    std::vector<rclcpp::Parameter> all_new_parameters{rclcpp::Parameter("my_parameter", "world")};
    this->set_parameters(all_new_parameters);
  }

private:
  rclcpp::TimerBase::SharedPtr timer_;
};

int main(int argc, char ** argv)
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<MinimalParam>());
  rclcpp::shutdown();
  return 0;
}

## adding parameter discriptor
// ...

class MinimalParam : public rclcpp::Node
{
public:
  MinimalParam()
  : Node("minimal_param_node")
  {
    auto param_desc = rcl_interfaces::msg::ParameterDescriptor{};
    param_desc.description = "This parameter is mine!";

    this->declare_parameter("my_parameter", "world", param_desc);

    timer_ = this->create_wall_timer(
      1000ms, std::bind(&MinimalParam::timer_callback, this));
  }


  ## addingeexecuatbe

  add_executable(minimal_param_node src/cpp_parameters_node.cpp)
ament_target_dependencies(minimal_param_node rclcpp)

install(TARGETS
    minimal_param_node
  DESTINATION lib/${PROJECT_NAME}
)


## builsing and running
rosdep install -i --from-path src --rosdistro humble -y
colcon build --packages-select cpp_parameters

# in a new terminal
source install/setup.bash
ros2 run cpp_parameters minimal_param_node



## change through a console
ros2 run cpp_parameters minimal_param_node
# in another terminal
ros2 param list
ros2 param set /minimal_param_node my_parameter earth
