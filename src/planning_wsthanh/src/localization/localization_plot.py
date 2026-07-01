#!/usr/bin/env python3

import rospy
import numpy as np
import matplotlib
matplotlib.use('Agg') 
import matplotlib.pyplot as plt
import os
import tf
import csv
from nav_msgs.msg import Odometry, Path
from std_srvs.srv import Trigger, TriggerResponse
from std_msgs.msg import Float64MultiArray

class EKFPlotter:
    def __init__(self):
        rospy.init_node('localization_plot', anonymous=True)
        
        # Latest data buffers (Snapshot source)
        self.curr_x, self.curr_y = 0.0, 0.0
        self.curr_yaw = 0.0
        self.curr_vel = 0.0
        self.curr_steer = 0.0
        self.curr_pos_error = 0.0
        self.curr_ang_error_msg = 0.0
        self.curr_ctrl_vel = 0.0
        
        # Path data
        self.path_points = []  # list of (x, y, yaw)
        
        # Synchronized Data Container
        self.data_log = [] 
        
        self.start_time = None
        self.recording_active = True

        # Subscribers only update the 'current' values
        self.ekf_sub = rospy.Subscriber("/odometry/filtered", Odometry, self.ekf_callback)
        self.odom_raw_sub = rospy.Subscriber("/car1/odometry", Odometry, self.odom_raw_callback)
        self.path_sub = rospy.Subscriber("/planned_path", Path, self.path_callback)
        self.error_sub = rospy.Subscriber("/stanley/errors", Float64MultiArray, self.error_callback)
        
        # TIMER: This is the secret. It takes a snapshot of all values 30 times a second.
        self.sample_rate = 30.0
        self.timer = rospy.Timer(rospy.Duration(1.0 / self.sample_rate), self.take_snapshot)
        
        rospy.on_shutdown(self.generate_results)
        self.save_service = rospy.Service('save_ekf_results', Trigger, self.handle_save)

        rospy.loginfo("SYNCHRONIZED LOGGING ACTIVE. Recording at 30Hz...")

    def ekf_callback(self, msg):
        self.curr_x = msg.pose.pose.position.x
        self.curr_y = msg.pose.pose.position.y
        q = (msg.pose.pose.orientation.x,
             msg.pose.pose.orientation.y,
             msg.pose.pose.orientation.z,
             msg.pose.pose.orientation.w)
        euler = tf.transformations.euler_from_quaternion(q)
        self.curr_yaw = np.degrees(euler[2])

    def odom_raw_callback(self, msg):
        # Calculate speed magnitude
        vx = msg.twist.twist.linear.x
        vy = msg.twist.twist.linear.y
        self.curr_vel = np.sqrt(vx**2 + vy**2)

    def path_callback(self, msg):
        self.path_points = []
        for pose in msg.poses:
            x = pose.pose.position.x
            y = pose.pose.position.y
            q = (pose.pose.orientation.x, pose.pose.orientation.y, pose.pose.orientation.z, pose.pose.orientation.w)
            euler = tf.transformations.euler_from_quaternion(q)
            yaw = np.degrees(euler[2])
            self.path_points.append((x, y, yaw))
        rospy.loginfo(f"Received path with {len(self.path_points)} points")

    def error_callback(self, msg):
        if len(msg.data) >= 3:
            self.curr_pos_error = msg.data[0]
            self.curr_ang_error_msg = msg.data[1]
            self.curr_steer = msg.data[2]  # steerDeg
        if len(msg.data) >= 4:
            self.curr_ctrl_vel = msg.data[3]

    def take_snapshot(self, event):
        """Captures all current sensor values into a single time-aligned row."""
        if not self.recording_active:
            return

        now = rospy.get_time()
        if self.start_time is None:
            self.start_time = now
            rospy.loginfo("Recording started!")

        # Every entry in data_log will have the exact same length and alignment
        self.data_log.append({
            't': now - self.start_time,
            'x': self.curr_x,
            'y': self.curr_y,
            'yaw': self.curr_yaw,
            'vel': self.curr_vel,
            'pos_error_msg': self.curr_pos_error,
            'ang_error_msg': self.curr_ang_error_msg,
            'steer_deg': self.curr_steer,
            'ctrl_vel': self.curr_ctrl_vel
        })

    def handle_save(self, req):
        success = self.generate_results()
        if success:
            return TriggerResponse(success=True, message="Files saved successfully.")
        return TriggerResponse(success=False, message="Failed to save data.")

    def generate_results(self):
        if not self.data_log or len(self.data_log) < 10:
            rospy.logwarn("Insufficient data points in log.")
            return False

        self.recording_active = False
        data_len = len(self.data_log)
        rospy.loginfo("Processing %d synchronized points...", data_len)

        # Convert list of dictionaries to numpy arrays for plotting
        t = np.array([d['t'] for d in self.data_log])
        x = np.array([d['x'] for d in self.data_log])
        y = np.array([d['y'] for d in self.data_log])
        yaw = np.array([d['yaw'] for d in self.data_log])
        vel = np.array([d['vel'] for d in self.data_log])
        pos_error_msg = np.array([d['pos_error_msg'] for d in self.data_log])
        ang_error_msg = np.array([d['ang_error_msg'] for d in self.data_log])
        steer_deg = np.array([d['steer_deg'] for d in self.data_log])
        ctrl_vel = np.array([d['ctrl_vel'] for d in self.data_log])

        # 1. SAVE CSV
        log_path = os.path.expanduser("~/ekf_log_data.csv")
        with open(log_path, mode='w') as file:
            writer = csv.writer(file)
            writer.writerow(['time', 'x', 'y', 'yaw', 'vel', 'pos_error_msg', 'ang_error_msg', 'steer_deg', 'ctrl_vel'])
            for i in range(data_len):
                writer.writerow([t[i], x[i], y[i], yaw[i], vel[i], pos_error_msg[i], ang_error_msg[i], steer_deg[i], ctrl_vel[i]])

        # Analysis
        pos_mean = np.mean(pos_error_msg)
        pos_max = np.max(pos_error_msg)
        pos_min = np.min(pos_error_msg)
        pos_std = np.std(pos_error_msg)
        
        ang_mean = np.mean(ang_error_msg)
        ang_max = np.max(ang_error_msg)
        ang_min = np.min(ang_error_msg)
        ang_std = np.std(ang_error_msg)
        
        rospy.loginfo("Position Error Analysis:")
        rospy.loginfo(f"  Mean: {pos_mean:.4f} m")
        rospy.loginfo(f"  Max: {pos_max:.4f} m")
        rospy.loginfo(f"  Min: {pos_min:.4f} m")
        rospy.loginfo(f"  Std: {pos_std:.4f} m")
        
        rospy.loginfo("Angle Error Analysis:")
        rospy.loginfo(f"  Mean: {ang_mean:.4f} deg")
        rospy.loginfo(f"  Max: {ang_max:.4f} deg")
        rospy.loginfo(f"  Min: {ang_min:.4f} deg")
        rospy.loginfo(f"  Std: {ang_std:.4f} deg")

        # 2. SAVE PNG
        try:
            plt.clf() 
            fig, axs = plt.subplots(5, 2, figsize=(15, 25))
            
            # Row 1: X and Y
            axs[0,0].plot(t, x, color='blue'); axs[0,0].set_title("X Position (m)"); axs[0,0].grid(True)
            axs[0,1].plot(t, y, color='green'); axs[0,1].set_title("Y Position (m)"); axs[0,1].grid(True)
            
            # Row 2: Velocity and Yaw
            axs[1,0].plot(t, vel, color='purple'); axs[1,0].set_title("Velocity (m/s)"); axs[1,0].grid(True)
            axs[1,1].plot(t, yaw, color='orange'); axs[1,1].set_title("Yaw (Degrees)"); axs[1,1].grid(True)

            # Row 3: Position Error and Angle Error
            axs[2,0].plot(t, pos_error_msg, color='red'); axs[2,0].set_title("Position Error (m)"); axs[2,0].grid(True)
            axs[2,1].plot(t, ang_error_msg, color='cyan'); axs[2,1].set_title("Angle Error (Degrees)"); axs[2,1].grid(True)

            # Row 4: Controller outputs
            axs[3,0].plot(t, steer_deg, color='magenta'); axs[3,0].set_title("Steer Angle (Degrees)"); axs[3,0].grid(True)
            axs[3,1].plot(t, ctrl_vel, color='brown'); axs[3,1].set_title("Controller Velocity (m/s)"); axs[3,1].grid(True)

            # Row 5: Trajectory
            for ax in axs[4, :]: ax.remove()
            ax_big = fig.add_subplot(5, 1, 5) 
            ax_big.plot(x, y, color='red', linewidth=2)
            # Plot path if available
            if self.path_points:
                path_x = [p[0] for p in self.path_points]
                path_y = [p[1] for p in self.path_points]
                ax_big.plot(path_x, path_y, color='blue', linestyle='--', linewidth=1, label='Planned Path')
            ax_big.set_title("Vehicle Trajectory vs Planned Path")
            ax_big.set_xlabel("X (m)"); ax_big.set_ylabel("Y (m)")
            ax_big.axis('equal'); ax_big.grid(True)
            ax_big.legend()

            plt.tight_layout()
            plot_path = os.path.expanduser("~/ekf_diagnostic_result.png")
            plt.savefig(plot_path, bbox_inches='tight', dpi=100)
            plt.close(fig) 
            
            rospy.loginfo("SUCCESS: Synchronized files saved.")
            return True
        except Exception as e:
            rospy.logerr("Plotting failed: %s", str(e))
            return False

if __name__ == '__main__':
    try:
        plotter = EKFPlotter()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass