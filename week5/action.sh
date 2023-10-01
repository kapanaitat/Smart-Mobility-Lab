## creating worrkspace and creating a new package
mkdir -p ros2_ws/src #you can reuse existing workspace with this naming convention
cd ros2_ws/src
ros2 pkg create action_tutorials_interfaces

## creating an action directory
cd action_tutorials_interfaces
mkdir action

## creating Fibonacci.action file with
int32 order
---
int32[] sequence
---
int32[] partial_sequence


## building an action, addin the lines to CMakeLists.txt
find_package(rosidl_default_generators REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "action/Fibonacci.action"
)
# adding dependencies to package.xml
<buildtool_depend>rosidl_default_generators</buildtool_depend>

<depend>action_msgs</depend>

<member_of_group>rosidl_interface_packages</member_of_group>
## building the package
# Change to the root of the workspace
cd ~/ros2_ws
# Build
colcon build


## checking the action
# Source our workspace
# On Windows: call install/setup.bat
. install/setup.bash
# Check that our action definition exists
ros2 interface show action_tutorials_interfaces/action/Fibonacci
