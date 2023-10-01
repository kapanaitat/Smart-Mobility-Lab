#! /bin/sh.

## installing rosdep 
apt-get install python3-rosdep
#or pip install rosdep

## initializing rosdep
sudo rosdep init
rosdep update

## installing dependencies
rosdep install --from-paths src -y --ignore-src
