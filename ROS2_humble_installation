# Installing ROS2 Humble on Ubuntu 22.04

## Setting locale which supports OTF-8

locale

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale # to verify settings


## Adding the ROS 2 apt repository

sudo apt install software-properties-common
sudo add-apt-repository universe

## Adding the ROS 2 GPG key with apt
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
## Adding repository to the source list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null



## Instelling common packages for development and ROS tools

sudo apt update && sudo apt install -y \
  python3-flake8-docstrings \
  python3-pip \
  python3-pytest-cov \
  ros-dev-tools


## Creating cloning repositories

mkdir -p ~/ros2_humble/src
cd ~/ros2_humble
vcs import --input https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos src


## Installing dependencies

sudo apt upgrade

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"


## Setting the environment

. ~/ros2_humble/install/local_setup.bash



## Checking the installation through the example

. ~/ros2_humble/install/local_setup.bash
ros2 run demo_nodes_cpp talker #talker in C++
. ~/ros2_humble/install/local_setup.bash
ros2 run demo_nodes_py listener #listener in Python
