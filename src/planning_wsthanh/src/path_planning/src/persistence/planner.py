# FILE PLAN ĐƯỜNG TỪ TỪ ĐẦU VÀO LÀ CÁC NODES BẤT KỲ (NHẬP Ở DÒNG 97 blue_nodes)

import networkx as nx
import yaml
import os
import math
import rospy
from nav_msgs.msg import Odometry
from std_msgs.msg import String

# 1. Định nghĩa đường dẫn file
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
GRAPH_FILE = os.path.join(BASE_DIR, "track.graphml")
YAML_FILE = os.path.join(BASE_DIR, "runs.yaml")

# 2. Định nghĩa các hàm phụ trợ
def get_initial_state_from_config():
    # Tìm đường dẫn đến file localization.yaml
    config_path = os.path.join(BASE_DIR, "..", "..", "..", "localization", "config", "localization.yaml")
    try:
        with open(config_path, 'r') as f:
            # Sử dụng safe_load để đọc file yaml
            config = yaml.safe_load(f)
            # initial_state: [x, y, z, roll, pitch, yaw, ...]
            # Ta lấy x (index 0) và y (index 1)
            state = config.get('initial_state', [16.26, 9.87])
            return float(state[0]), float(state[1])
    except Exception as e:
        print(f"Lỗi khi đọc localization.yaml: {e}")
        return 16.26, 9.87

# 3. Nạp bản đồ vào biến toàn cục
G = nx.read_graphml(GRAPH_FILE)

# Biến toàn cục để lưu vị trí xe
current_x, current_y = None, None

def odom_callback(msg):
    global current_x, current_y
    current_x = msg.pose.pose.position.x
    current_y = msg.pose.pose.position.y

def find_nearest_node(G, x, y):
    nearest_node = None
    min_dist = float('inf')
    for node, data in G.nodes(data=True):
        n_x = float(data.get('x', 0))
        n_y = float(data.get('y', 0))
        dist = math.sqrt((n_x - x)**2 + (n_y - y)**2)
        if dist < min_dist:
            min_dist = dist
            nearest_node = str(node) 

    if nearest_node and not nearest_node.startswith('n'):
        nearest_node = 'n' + nearest_node
    return nearest_node

def get_optimized_order(nodes, start_node):
    unvisited = nodes.copy()
    if start_node in unvisited:
        unvisited.remove(start_node)
    current_node = start_node
    optimized_path = [current_node]

    while unvisited:
        next_node = min(unvisited, key=lambda node: nx.shortest_path_length(G, current_node, node, weight='length'))
        optimized_path.append(next_node)
        unvisited.remove(next_node)
        current_node = next_node
    return optimized_path

def find_full_path(targets):
    full_node_list = []
    for i in range(len(targets) - 1):
        try:
            path = nx.shortest_path(G, source=targets[i], target=targets[i+1], weight='length')
            full_node_list.extend(path if i == 0 else path[1:])
        except nx.NetworkXNoPath:
            print(f"Lỗi: Không tìm thấy đường từ {targets[i]} đến {targets[i+1]}")
            return None
    return full_node_list

def run_planner():
    global current_x, current_y
    rospy.init_node('global_planner_script', anonymous=True)
    
    try:
        with open(YAML_FILE, 'w') as f:
            f.write('') # Xóa sạch ruột file
        print(f"Đã xóa trắng file {YAML_FILE} để bắt C++ Node đợi.")
    except Exception as e:
        print(f"Không thể xóa trắng file: {e}")
        
    rospy.Subscriber('/odometry/filtered', Odometry, odom_callback)

    default_x, default_y = get_initial_state_from_config()
    blue_nodes = ['n269', 'n252', 'n257', 'n372', 'n396', 'n330'] 

    # blue_nodes = ['n382'] 
    # blue_nodes = ['n254']
    
    print("Đang đợi dữ liệu vị trí từ EKF (Topic: /odometry/filtered)...")
    wait_count = 0
    while current_x is None and not rospy.is_shutdown() and wait_count < 15: # Chờ tối đa 1.5 giây
        rospy.sleep(0.1)
        wait_count += 1

    if current_x is None:
        print(f"WARN: Không nhận được EKF kịp lúc. Sử dụng tọa độ từ Config: x={default_x}, y={default_y}")
        current_x, current_y = default_x, default_y
    else:
        print(f"Đã nhận vị trí EKF: x={current_x:.2f}, y={current_y:.2f}")

    rospy.sleep(0.5)
    
    start_node = find_nearest_node(G, current_x, current_y)
    print(f"Xe bắt đầu tại node: {start_node}")

    
    print("Đang tối ưu hóa thứ tự các điểm...")
    optimized_blue_nodes = get_optimized_order(blue_nodes, start_node)
    print(f"Thứ tự tối ưu: {optimized_blue_nodes}")

    path_result = find_full_path(optimized_blue_nodes)

    if path_result:
        clean_path = [int(node.replace('n', '')) for node in path_result]
        d2_list = [int(G.nodes[node].get('d2', 0)) for node in path_result]
      
        try:
            with open(YAML_FILE, 'r') as f:
                current_data = yaml.safe_load(f) or {}
        except FileNotFoundError:
            current_data = {}

        current_data['runGreedyPath'] = clean_path
        current_data['runGreedyPath_d2'] = d2_list

        with open(YAML_FILE, 'w') as f:
            yaml.dump(current_data, f, default_flow_style=False)
      
        print(f"Thành công! Đã cập nhật {len(clean_path)} node vào {YAML_FILE}")
        
        # BÁO CHO C++ BIẾT FILE YAML ĐÃ SẴN SÀNG
        pub_ready = rospy.Publisher('/path_ready', String, queue_size=1)
        rospy.sleep(0.5) 
        pub_ready.publish("ready")
        print("Đã phát tín hiệu /path_ready cho Stanley Controller!")
        rospy.sleep(0.5)

if __name__ == '__main__':
    try:
        run_planner()
    except rospy.ROSInterruptException:
        pass