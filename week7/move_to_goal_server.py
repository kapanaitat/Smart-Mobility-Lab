import rclpy
from rclpy.action import ActionServer
from turtlebot_navigation.action import MoveToGoal
from geometry_msgs.msg import Point, Twist

class MoveToGoalServer:
    def __init__(self):
        self.server = ActionServer(
            self.node,
            MoveToGoal,
            'move_to_goal',
            execute_callback=self.execute_callback
        )
    
    def execute_callback(self, goal_handle):
        feedback_msg = MoveToGoal.Feedback()
        result_msg = MoveToGoal.Result()

        # Get the goal coordinates
        goal = goal_handle.request.goal

        # Your navigation logic here to move the TurtleBot to the goal
        # For simplicity, we just set the result as a Twist message.
        result_msg.result = Twist()
        
        goal_handle.succeed(result_msg)

def main(args=None):
    rclpy.init(args=args)
    node = rclpy.create_node('move_to_goal_server')
    server = MoveToGoalServer(node)
    rclpy.spin(server)
    rclpy.shutdown()

if __name__ == '__main__':
    main()
