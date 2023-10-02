#! /bin/sh.



## Installing the demo
sudo apt-get install ros-humble-turtle-tf2-py ros-humble-tf2-tools ros-humble-tf-transformations
## running
ros2 launch turtle_tf2_py turtle_tf2_demo.launch.py
ros2 run turtlesim turtle_teleop_key


## view_frames
ros2 run tf2_tools view_frames
ros2 run tf2_ros tf2_echo [source_frame] [target_frame]ros2 run tf2_ros tf2_echo turtle2 turtle1
ros2 run tf2_ros tf2_echo turtle2 turtle1
ros2 run rviz2 rviz2 -d $(ros2 pkg prefix --share turtle_tf2_py)/rviz/turtle_rviz.rviz





## static broadcaster in python


## package\
ros2 pkg create --build-type ament_python learning_tf2_py

## node
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_py/turtle_tf2_py/static_turtle_tf2_broadcaster.py

##entry point
'static_turtle_tf2_broadcaster = learning_tf2_py.static_turtle_tf2_broadcaster:main',

## build
rosdep install -i --from-path src --rosdistro humble -y

colcon build --packages-select learning_tf2_py

# new terminal
. install/setup.bash


##running
ros2 run learning_tf2_py static_turtle_tf2_broadcaster mystaticturtle 0 0 1 0 0 0





## broadcaster in python
# broadcaster node
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_py/turtle_tf2_py/turtle_tf2_broadcaster.py
# entry point
'turtle_tf2_broadcaster = learning_tf2_py.turtle_tf2_broadcaster:main',
# launch file
from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='turtlesim',
            executable='turtlesim_node',
            name='sim'
        ),
        Node(
            package='learning_tf2_py',
            executable='turtle_tf2_broadcaster',
            name='broadcaster1',
            parameters=[
                {'turtlename': 'turtle1'}
            ]
        ),
    ])


# dependencies
<exec_depend>launch</exec_depend>
<exec_depend>launch_ros</exec_depend>

# setup.py
data_files=[
    ...
    (os.path.join('share', package_name, 'launch'), glob(os.path.join('launch', '*launch.[pxy][yma]*'))),
],

import os
from glob import glob


# BUILDING
rosdep install -i --from-path src --rosdistro humble -y
colcon build --packages-select learning_tf2_py
. install/setup.bash
# running
ros2 launch learning_tf2_py turtle_tf2_demo.launch.py
ros2 run turtlesim turtle_teleop_key
ros2 run tf2_ros tf2_echo world turtle1






## listener in Python
# node
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_py/turtle_tf2_py/turtle_tf2_listener.py

# entry 
'turtle_tf2_listener = learning_tf2_py.turtle_tf2_listener:main',

# launch file
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration

from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        Node(
            package='turtlesim',
            executable='turtlesim_node',
            name='sim'
        ),
        Node(
            package='learning_tf2_py',
            executable='turtle_tf2_broadcaster',
            name='broadcaster1',
            parameters=[
                {'turtlename': 'turtle1'}
            ]
        ),
        DeclareLaunchArgument(
            'target_frame', default_value='turtle1',
            description='Target frame name.'
        ),
        Node(
            package='learning_tf2_py',
            executable='turtle_tf2_broadcaster',
            name='broadcaster2',
            parameters=[
                {'turtlename': 'turtle2'}
            ]
        ),
        Node(
            package='learning_tf2_py',
            executable='turtle_tf2_listener',
            name='listener',
            parameters=[
                {'target_frame': LaunchConfiguration('target_frame')}
            ]
        ),
    ])

# building
rosdep install -i --from-path src --rosdistro humble -y

colcon build --packages-select learning_tf2_py
# in a new terminal
. install/setup.bash

# running
ros2 launch learning_tf2_py turtle_tf2_demo.launch.py
# in a new terminal
ros2 run turtlesim turtle_teleop_key




## adding a frame in Python
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_py/turtle_tf2_py/fixed_frame_tf2_broadcaster.py

# entry point
'fixed_frame_tf2_broadcaster = learning_tf2_py.fixed_frame_tf2_broadcaster:main',

# launch file
import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource

from launch_ros.actions import Node


def generate_launch_description():
    demo_nodes = IncludeLaunchDescription(
        PythonLaunchDescriptionSource([os.path.join(
            get_package_share_directory('learning_tf2_py'), 'launch'),
            '/turtle_tf2_demo.launch.py']),
        )

    return LaunchDescription([
        demo_nodes,
        Node(
            package='learning_tf2_py',
            executable='fixed_frame_tf2_broadcaster',
            name='fixed_broadcaster',
        ),
    ])


# building
rosdep install -i --from-path src --rosdistro humble -y
colcon build --packages-select learning_tf2_py
# in a new termial
. install/setup.bash

# running
ros2 launch learning_tf2_py turtle_tf2_fixed_frame_demo.launch.py

# dynamic frame broadcaster
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_py/turtle_tf2_py/dynamic_frame_tf2_broadcaster.py
# entry point
'dynamic_frame_tf2_broadcaster = learning_tf2_py.dynamic_frame_tf2_broadcaster:main',
# launch
import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource

from launch_ros.actions import Node


def generate_launch_description():
    demo_nodes = IncludeLaunchDescription(
        PythonLaunchDescriptionSource([os.path.join(
            get_package_share_directory('learning_tf2_py'), 'launch'),
            '/turtle_tf2_demo.launch.py']),
       launch_arguments={'target_frame': 'carrot1'}.items(),
       )

    return LaunchDescription([
        demo_nodes,
        Node(
            package='learning_tf2_py',
            executable='dynamic_frame_tf2_broadcaster',
            name='dynamic_broadcaster',
        ),
    ])

# building
rosdep install -i --from-path src --rosdistro humble -y
colcon build --packages-select learning_tf2_py
#in a new terminal
. install/setup.bash
# running
ros2 launch learning_tf2_py turtle_tf2_dynamic_frame_demo.launch.py



# using time in Python
# updating the listener node
trans = self._tf_buffer.lookup_transform(
   to_frame_rel,
   from_frame_rel,
   now)

# fixing the listener node
trans = self._tf_buffer.lookup_transform(
   to_frame_rel,
   from_frame_rel,
   now,
   timeout=rclpy.duration.Duration(seconds=1.0))

# running the launch file
ros2 launch learning_tf2_py turtle_tf2_demo.launch.py



## travelling in time in Python

# editing lookup_transform()
when = self.get_clock().now() - rclpy.time.Duration(seconds=5.0)
trans = self.tf_buffer.lookup_transform(
    to_frame_rel,
    from_frame_rel,
    when,
    timeout=rclpy.duration.Duration(seconds=0.05))



# running
ros2 launch learning_tf2_py turtle_tf2_fixed_frame_demo.launch.py

# API
when = self.get_clock().now() - rclpy.time.Duration(seconds=5.0)
trans = self.tf_buffer.lookup_transform_full(
        target_frame=to_frame_rel,
        target_time=rclpy.time.Time(),
        source_frame=from_frame_rel,
        source_time=when,
        fixed_frame='world',
        timeout=rclpy.duration.Duration(seconds=0.05))


# checking the results
ros2 launch learning_tf2_py turtle_tf2_fixed_frame_demo.launch.py



## debugging
# in line 67 change to
std::string toFrameRel = "turtle3";
# in line 75 change to
try {
   transformStamped = tf_buffer_->lookupTransform(
     toFrameRel,
     fromFrameRel,
     this->now());
} catch (tf2::TransformException & ex) {


# finding tf2 request
# checkingthe franes
ros2 run tf2_ros tf2_echo turtle3 turtle1
ros2 run tf2_tools view_frames
ros2 launch turtle_tf2 start_debug_demo.launch.py

# timestamps
ros2 run tf2_ros tf2_monitor turtle2 turtle1





## quaternian fundamentals
q_orig = quaternion_from_euler(0, 0, 0)
# Rotate the previous pose by 180* about X
q_rot = quaternion_from_euler(3.14159, 0, 0)
q_new = quaternion_multiply(q_rot, q_orig)

# inverting
q[3] = -q[3]
# relative rotation
q_2 = q_r * q_1

q_r = q_2 * q_1_inverse


## stamped datatypes
# downloading the sensor message broadcaster
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_py/turtle_tf2_py/turtle_tf2_message_broadcaster.py


# writing the launching file
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch_ros.actions import Node


def generate_launch_description():
    return LaunchDescription([
        DeclareLaunchArgument(
            'target_frame', default_value='turtle1',
            description='Target frame name.'
        ),
        Node(
            package='turtlesim',
            executable='turtlesim_node',
            name='sim',
            output='screen'
        ),
        Node(
            package='turtle_tf2_py',
            executable='turtle_tf2_broadcaster',
            name='broadcaster1',
            parameters=[
                {'turtlename': 'turtle1'}
            ]
        ),
        Node(
            package='turtle_tf2_py',
            executable='turtle_tf2_broadcaster',
            name='broadcaster2',
            parameters=[
                {'turtlename': 'turtle3'}
            ]
        ),
        Node(
            package='turtle_tf2_py',
            executable='turtle_tf2_message_broadcaster',
            name='message_broadcaster',
        ),
    ])


# entry point
'turtle_tf2_message_broadcaster = learning_tf2_py.turtle_tf2_message_broadcaster:main',
# building
rosdep install -i --from-path src --rosdistro humble -y
colcon build --packages-select learning_tf2_py

# filter/listener  node
wget https://raw.githubusercontent.com/ros/geometry_tutorials/ros2/turtle_tf2_cpp/src/turtle_tf2_message_filter.cpp
# adding dependencies
<depend>message_filters</depend>
<depend>tf2_geometry_msgs</depend>

#CMakeLists.txt
find_package(message_filters REQUIRED)
find_package(tf2_geometry_msgs REQUIRED)

# building
rosdep install -i --from-path src --rosdistro humble -y
colcon build --packages-select learning_tf2_cpp
. install/setup.bash

# running
ros2 launch learning_tf2_py turtle_tf2_sensor_message.launch.py
ros2 run turtlesim turtle_teleop_key
ros2 topic echo /turtle3/turtle_point_stamped
ros2 run learning_tf2_cpp turtle_tf2_message_filter
