import rclpy
from rclpy.action import ActionClient
from turtlebot_navigation.action import MoveToGoal
from geometry_msgs.msg import Point

class MoveToGoalClient:
    def __init__(self):
        self.client = ActionClient(self.node, MoveToGoal, 'move_to_goal')
    
    async def send_goal(self, x, y, theta):
        goal_msg = MoveToGoal.Goal()
        goal_msg.goal = Point(x=x, y=y, z=theta)
        return await self.client.send_goal_async(goal_msg)

def main(args=None):
    rclpy.init(args=args)
    node = rclpy.create_node('move_to_goal_client')
    client = MoveToGoalClient(node)
    
    future = client.send_goal(2.0, 2.0, 0.0)  # Example goal (x=2.0, y=2.0, theta=0.0)
    
    rclpy.spin_until_future_complete(node, future)
    
    if future.result() is not None:
        print('Goal achieved!')
    else:
        print('Goal failed!')

    rclpy.shutdown()

if __name__ == '__main__':
    main()
