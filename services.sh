#! /bin/sh.



## setup
# in a new terminal
ros2 run turtlesim turtlesim_node

# in a new terminal
ros2 run turtlesim turtle_teleop_key



## ros2 service list
ros2 service list

## ros2 service type, ros2 service type <service_name>
ros2 service type /clear

## ros2 service list -t to see the types of all active services
ros2 service list -t

## ros2 service find, ros2 service find <type_name>
ros2 service find std_srvs/srv/Empty

## ros2 interface show, ros2 interface show <type_name>
ros2 interface show std_srvs/srv/Empty


# seeing requests and response arguments of the /spawn service
ros2 interface show turtlesim/srv/Spawn

## ros2 service call, ros2 service call <service_name> <service_type> <arguments>
ros2 service call /clear std_srvs/srv/Empty

# spawning a new turtle and setting arguments
ros2 service call /spawn turtlesim/srv/Spawn "{x: 2, y: 2, theta: 0.2, name: ''}"


