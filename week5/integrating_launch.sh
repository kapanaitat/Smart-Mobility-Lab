#! /bin/sh.

## creating a package
mkdir -p launch_ws/src
cd launch_ws/src

ros2 pkg create py_launch_example --build-type ament_python


##inside setup.py
import os
from glob import glob
from setuptools import setup

package_name = 'py_launch_example'

setup(
    # Other parameters ...
    data_files=[
        # ... Other data files
        # Include all launch files.
        (os.path.join('share', package_name, 'launch'), glob(os.path.join('launch', '*launch.[pxy][yma]*')))
    ]
)


## inside launch creating _launch.py
import launch
import launch_ros.actions

def generate_launch_description():
    return launch.LaunchDescription([
        launch_ros.actions.Node(
            package='demo_nodes_cpp',
            executable='talker',
            name='talker'),
  ])



## building and running the launch file
colcon build
ros2 launch py_launch_example my_script_launch.py
