# FILE VẼ BIỂU ĐỒ ONLINE TRÊN WEB


#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
REAL-TIME VEHICLE TRAJECTORY PLOTTER (RUNS ON MAC/WINDOWS/LINUX WITHOUT ROS INSTALLED)
-------------------------------------------------------------------------------------
Yêu cầu thư viện:
    pip install websocket-client matplotlib
Hướng dẫn chạy trên VS Code của MacBook:
    1. Đảm bảo trên xe (máy tính nhúng) đã chạy:
       roslaunch rosbridge_server rosbridge_websocket.launch
    2. Thay đổi địa chỉ IP của xe ở biến CAR_IP phía dưới.
    3. Nhấn nút Run (nút Play màu tam giác góc phải VS Code) để chạy.
"""
import json
import threading
import time
import websocket
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
# === CẤU HÌNH ĐỊA CHỈ IP CỦA XE ===
CAR_IP = "20.3.18.73"  # Thay bằng IP thực tế của xe 
PORT = "9090"
# ==================================
class RealtimeRosPlotter:
    def __init__(self, ip, port):
        self.ws_url = f"ws://{ip}:{port}"
        self.ref_x = []
        self.ref_y = []
        self.car_x = []
        self.car_y = []
        
        self.lock = threading.Lock()
        self.ws = None
        self.connected = False
        
        # Khởi tạo đồ thị Matplotlib
        self.fig, self.ax = plt.subplots(figsize=(10, 6))
        self.fig.canvas.manager.set_window_title('Antigravity Vehicle Trajectory Monitor')
        
        self.ax.set_title("Real-Time Trajectory (Subscribed via WebSocket)", fontsize=13, fontweight='bold')
        self.ax.set_xlabel("X (m)", fontsize=11)
        self.ax.set_ylabel("Y (m)", fontsize=11)
        self.ax.grid(True, linestyle='--', alpha=0.5)
        
        # Thiết kế style cho các đường vẽ
        self.line_ref, = self.ax.plot([], [], 'b--', label='Planned Path (Reference)', alpha=0.8)
        self.line_car, = self.ax.plot([], [], 'r-', linewidth=2.5, label='Vehicle Trajectory')
        self.current_pos, = self.ax.plot([], [], 'ro', markersize=8, label='Current Position')
        
        self.ax.legend(loc='upper right')
        self.axis_set = False
        # Khởi chạy luồng WebSocket chạy ngầm để nhận dữ liệu từ xe
        self.ws_thread = threading.Thread(target=self.connect_websocket, daemon=True)
        self.ws_thread.start()
    def connect_websocket(self):
        print(f"[Connecting] Đang kết nối tới xe qua: {self.ws_url}...")
        
        # Cấu hình các hàm callback của WebSocket
        def on_message(ws, message):
            data = json.loads(message)
            topic = data.get("topic")
            msg = data.get("msg")
            
            if not msg:
                return
                
            # 1. Nhận dữ liệu đường đi mẫu /planned_path
            if topic == "/planned_path":
                poses = msg.get("poses", [])
                temp_x = []
                temp_y = []
                for p in poses:
                    pos = p["pose"]["position"]
                    temp_x.append(pos["x"])
                    temp_y.append(pos["y"])
                with self.lock:
                    self.ref_x = temp_x
                    self.ref_y = temp_y
            # 2. Nhận dữ liệu định vị thực tế /odometry/filtered
            elif topic == "/odometry/filtered":
                pos = msg["pose"]["pose"]["position"]
                with self.lock:
                    self.car_x.append(pos["x"])
                    self.car_y.append(pos["y"])
        def on_error(ws, error):
            print(f"[Error] Lỗi kết nối: {error}")
        def on_close(ws, close_status_code, close_msg):
            print("[Closed] Đã ngắt kết nối với xe.")
            self.connected = False
        def on_open(ws):
            print("[Connected] Đã kết nối thành công tới xe!")
            self.connected = True
            
            # Gửi yêu cầu đăng ký lắng nghe (Subscribe) các topic từ ROS
            subscribe_path = {
                "op": "subscribe",
                "topic": "/planned_path",
                "type": "nav_msgs/Path"
            }
            subscribe_odom = {
                "op": "subscribe",
                "topic": "/odometry/filtered",
                "type": "nav_msgs/Odometry"
            }
            ws.send(json.dumps(subscribe_path))
            ws.send(json.dumps(subscribe_odom))
            print("[Subscribed] Đang nhận dữ liệu /planned_path & /odometry/filtered...")
        self.ws = websocket.WebSocketApp(
            self.ws_url,
            on_open=on_open,
            on_message=on_message,
            on_error=on_error,
            on_close=on_close
        )
        self.ws.run_forever()
    def update_plot(self, frame):
        with self.lock:
            # 1. Cập nhật đường tham chiếu
            if self.ref_x and self.ref_y:
                self.line_ref.set_data(self.ref_x, self.ref_y)
                
                # Tự động co dãn trục tọa độ vừa khít với map
                if not self.axis_set:
                    min_x, max_x = min(self.ref_x), max(self.ref_x)
                    min_y, max_y = min(self.ref_y), max(self.ref_y)
                    padding = 0.5
                    self.ax.set_xlim(min_x - padding, max_x + padding)
                    self.ax.set_ylim(min_y - padding, max_y + padding)
                    self.ax.set_aspect('equal', 'box') # Đảm bảo tỉ lệ 1:1 thực tế
                    self.axis_set = True
            
            # 2. Cập nhật quỹ đạo xe chạy thực tế
            if self.car_x and self.car_y:
                self.line_car.set_data(self.car_x, self.car_y)
                self.current_pos.set_data([self.car_x[-1]], [self.car_y[-1]])
                
        return self.line_ref, self.line_car, self.current_pos
def main():
    plotter = RealtimeRosPlotter(CAR_IP, PORT)
    
    # Chạy animation cập nhật đồ thị mỗi 100ms
    ani = FuncAnimation(plotter.fig, plotter.update_plot, interval=100, blit=True, cache_frame_data=False)
    plt.show()
if __name__ == '__main__':
    main()
