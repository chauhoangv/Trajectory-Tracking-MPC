# FILE VẼ BIỂU ĐỒ GAMMA

import pandas as pd
import numpy as np
import matplotlib
# Config Agg backend for headless environments
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse
import os
import glob
import re
import xml.etree.ElementTree as ET

# 1. Load nodes from track.graphml to map coordinates to node IDs
def load_nodes_from_graphml(graphml_path):
    if not os.path.exists(graphml_path):
        print(f"Cảnh báo: Không tìm thấy file bản đồ tại {graphml_path}")
        return {}
    
    print(f"Đang đọc cấu trúc bản đồ từ: {graphml_path}...")
    try:
        tree = ET.parse(graphml_path)
        root = tree.getroot()
        ns = {'ns': 'http://graphml.graphdrawing.org/xmlns'}
        
        nodes = {}
        for node_elem in root.findall('.//ns:node', ns):
            node_id_str = node_elem.get('id')
            try:
                node_id = int(node_id_str.replace('n', ''))
            except ValueError:
                continue
                
            x, y = None, None
            for data in node_elem.findall('ns:data', ns):
                key = data.get('key')
                if key == 'd0':    # x attribute key
                    x = float(data.text)
                elif key == 'd1':  # y attribute key
                    y = float(data.text)
            if x is not None and y is not None:
                nodes[node_id] = (x, y)
        print(f"Đã tải {len(nodes)} nodes từ bản đồ.")
        return nodes
    except Exception as e:
        print(f"Lỗi khi đọc file graphml: {e}")
        return {}

# 2. Main plotting process
def main():
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Tìm file track.graphml ở các vị trí khả dĩ
    graphml_path = os.path.join(script_dir, "track.graphml")
    if not os.path.exists(graphml_path):
        # Fallbacks
        fallback_paths = [
            os.path.join(script_dir, "..", "persistence", "track.graphml"),
            "/Users/vothihoangchau/Documents/Chau_Workspace/src/planning_wsthanh/src/path_planning/src/persistence/track.graphml"
        ]
        for p in fallback_paths:
            if os.path.exists(p):
                graphml_path = p
                break
                
    nodes_coords = load_nodes_from_graphml(graphml_path)
    
    # Danh sách các file Excel đích được chỉ định trực tiếp
    target_filenames = ["gamma_0.05_colech_second.xlsx", "gamma_0.1_colech.xlsx", "gamma_0.2_colech.xlsx"]
    
    experiments = []
    for fname in target_filenames:
        resolved_path = None
        # Kiểm tra ở CWD (Thư mục chạy hiện tại)
        cwd_path = os.path.join(os.getcwd(), fname)
        # Kiểm tra ở script_dir (Thư mục chứa script)
        script_path = os.path.join(script_dir, fname)
        
        if os.path.exists(cwd_path):
            resolved_path = cwd_path
        elif os.path.exists(script_path):
            resolved_path = script_path
            
        if resolved_path:
            # Parse giá trị gamma từ tên file
            match = re.search(r'gamma_([0-9]+(?:\.[0-9]+)?)', fname)
            gamma_val = float(match.group(1)) if match else 0.0
            label = f"Gamma = {match.group(1)}" if match else fname.replace(".xlsx", "")
            
            experiments.append({
                'file': resolved_path,
                'gamma': gamma_val,
                'label': label
            })
            print(f"Đã tìm thấy file: {fname} tại {os.path.dirname(resolved_path)}")
        else:
            print(f"Cảnh báo: Không tìm thấy file {fname} ở cả {os.getcwd()} và {script_dir}")
            
    if not experiments:
        print("Lỗi: Không tìm thấy bất kỳ file Excel nào trong số các file sau:")
        for fname in target_filenames:
            print(f" - {fname}")
        return
        
    # Sắp xếp các thí nghiệm theo giá trị gamma tăng dần
    experiments = sorted(experiments, key=lambda x: x['gamma'])
    
    # Bảng màu hiện đại và tinh tế
    premium_colors = ['blue', '#2ca02c', '#d62728', '#9467bd', '#ff7f0e', '#17becf', '#e377c2']
    for idx, exp in enumerate(experiments):
        exp['color'] = premium_colors[idx % len(premium_colors)]
        
    # Đọc đường tham chiếu từ file đầu tiên
    ref_df = None
    for exp in experiments:
        try:
            ref_df = pd.read_excel(exp['file'], sheet_name='Reference', engine='openpyxl')
            print(f"Đọc thành công đường tham chiếu từ: {os.path.basename(exp['file'])}")
            break
        except Exception as e:
            continue
            
    if ref_df is None or len(ref_df) == 0:
        print("Lỗi: Không thể tải đường tham chiếu từ các file Excel.")
        return

    # Tính toán ánh xạ từ waypoint index sang Node ID của bản đồ
    ref_node_ids = []
    if nodes_coords:
        ref_x = ref_df['x'].values
        ref_y = ref_df['y'].values
        for rx, ry in zip(ref_x, ref_y):
            # Tìm node gần nhất trong track.graphml
            min_d = float('inf')
            best_node = -1
            for nid, (nx, ny) in nodes_coords.items():
                d = (rx - nx)**2 + (ry - ny)**2
                if d < min_d:
                    min_d = d
                    best_node = nid
            ref_node_ids.append(best_node)
    else:
        # Fallback nếu không có graphml
        # Giả lập ánh xạ dựa trên kích thước tuyến tính của reference
        print("Cảnh báo: Không thể tải bản đồ, tự động phân phối giả lập node IDs...")
        total_wps = len(ref_df)
        # Giả sử đường băng có 500 waypoints và phân bố tuyến tính từ node 330 đến 400
        ref_node_ids = [int(333 + (i / total_wps) * (382 - 333)) for i in range(total_wps)]

    # Thiết lập layout tổng thể (15x8 inch, 2 cột: Cột 1 Quỹ đạo xe, Cột 2 gồm 2 biểu đồ góc lái)
    fig = plt.figure(figsize=(16, 9))
    gs = fig.add_gridspec(2, 2, width_ratios=[1.2, 1.0], wspace=0.22, hspace=0.28)
    
    ax_traj = fig.add_subplot(gs[:, 0])
    ax_steer_straight = fig.add_subplot(gs[0, 1])
    ax_steer_curved = fig.add_subplot(gs[1, 1])

    # ==============================================================================
    # BIỂU ĐỒ TRÁI: QUỸ ĐẠO DI CHUYỂN VÀ CÁC PHÂN ĐOẠN KHẢO SÁT
    # ==============================================================================
    # Vẽ đường tham chiếu gốc
    ax_traj.plot(ref_df['x'], ref_df['y'], 'k:', label='Quỹ đạo gốc', linewidth=2.0, zorder=1)
    
    # Vẽ ranh giới hành lang sai số cho phép 40cm (±20cm mỗi bên)
    if 'psi' in ref_df.columns:
        width = 0.20  # 20cm lệch mỗi bên
        nx, ny = -np.sin(ref_df['psi']), np.cos(ref_df['psi'])
        lx, ly = ref_df['x'] + width * nx, ref_df['y'] + width * ny
        rx, ry = ref_df['x'] - width * nx, ref_df['y'] - width * ny
        
        ax_traj.plot(lx, ly, 'k-', linewidth=0.8, alpha=0.4, label='Hành lang cho phép (±20cm)', zorder=3)
        ax_traj.plot(rx, ry, 'k-', linewidth=0.8, alpha=0.4, zorder=3)

    # Đọc và vẽ quỹ đạo thực tế của từng thí nghiệm Gamma
    for exp in experiments:
        try:
            df = pd.read_excel(exp['file'], sheet_name='History', engine='openpyxl')
            ax_traj.plot(df['x'], df['y'], color=exp['color'], label=exp['label'],
                         linestyle='-', linewidth=2.0, zorder=4)
        except Exception as e:
            print(f"Lỗi khi vẽ quỹ đạo cho file {os.path.basename(exp['file'])}: {e}")

    # Tính toán vị trí tâm và kích thước để khoanh tròn các phân đoạn khảo sát
    if nodes_coords:
        # Đoạn thẳng: Các node thực tế trên đường thẳng: 333, 368, 369, 370, 371, 372, 373
        straight_nodes_list = [333, 368, 369, 370, 371, 372, 373]
        s_nodes = [nodes_coords[i] for i in straight_nodes_list if i in nodes_coords]
        if s_nodes:
            s_x = [pt[0] for pt in s_nodes]
            s_y = [pt[1] for pt in s_nodes]
            s_xcenter = (min(s_x) + max(s_x)) / 2.0
            s_ycenter = (min(s_y) + max(s_y)) / 2.0
            s_w = (max(s_x) - min(s_x)) + 0.6
            s_h = 1.0 # Chiều rộng vùng chọn bao phủ sai lệch ban đầu 30cm
        else:
            s_xcenter, s_ycenter, s_w, s_h = 17.95, 10.43, 2.9, 1.0
            
        # Đoạn cong: Các node thực tế trên cua: 374, 375, 376, 377, 378, 379, 380, 381, 382
        curved_nodes_list = [374, 375, 376, 377, 378, 379, 380, 381, 382]
        c_nodes = [nodes_coords[i] for i in curved_nodes_list if i in nodes_coords]
        if c_nodes:
            c_x = [pt[0] for pt in c_nodes]
            c_y = [pt[1] for pt in c_nodes]
            c_xcenter = (min(c_x) + max(c_x)) / 2.0
            c_ycenter = (min(c_y) + max(c_y)) / 2.0
            c_w = (max(c_x) - min(c_x)) + 0.8
            c_h = (max(c_y) - min(c_y)) + 0.8
        else:
            c_xcenter, c_ycenter, c_w, c_h = 19.72, 11.7, 2.08, 3.35
    else:
        # Giá trị mặc định
        s_xcenter, s_ycenter, s_w, s_h = 17.9, 10.43, 2.6, 1.0
        c_xcenter, c_ycenter, c_w, c_h = 19.6, 11.7, 1.8, 3.2

    # Vẽ vòng khoanh tròn (Ellipse đứt nét) cho Đoạn thẳng (thêm nhãn vào legend)
    ellipse_s = Ellipse(xy=(s_xcenter, s_ycenter), width=s_w, height=s_h,
                        edgecolor='#ff7f0e', facecolor='none', linestyle='--', linewidth=1.8, zorder=5, alpha =0.5,
                        label='Đoạn thẳng')
    ax_traj.add_patch(ellipse_s)

    # Vẽ vòng khoanh tròn (Ellipse đứt nét) cho Đoạn cong (thêm nhãn vào legend)
    ellipse_c = Ellipse(xy=(c_xcenter, c_ycenter), width=c_w, height=c_h,
                        edgecolor='#9467bd', facecolor='none', linestyle='--', linewidth=1.8, zorder=5, alpha =0.5,
                        label='Đoạn cong')
    ax_traj.add_patch(ellipse_c)

    # Định dạng biểu đồ quỹ đạo
    ax_traj.set_title("Quỹ đạo di chuyển của xe với các giá trị Gamma\n(Sai số lệch làn ban đầu 30cm)", fontsize=13, fontweight='bold', pad=12)
    ax_traj.set_xlabel("Tọa độ X (m)", fontsize=11)
    ax_traj.set_ylabel("Tọa độ Y (m)", fontsize=11)
    ax_traj.grid(False) # Bỏ grid hoàn toàn theo yêu cầu
    ax_traj.legend(loc='upper left', fontsize=9, framealpha=0.9)
    ax_traj.set_aspect('equal', 'box')
    
    # Thiết lập giới hạn trục X và Y để tập trung vào vùng khảo sát
    ax_traj.set_xlim(16.0, 21.2)
    ax_traj.set_ylim(9.5, 14.2)

    # ==============================================================================
    # BIỂU ĐỒ PHẢI: TRÍCH XUẤT GÓC LÁI TƯƠNG ỨNG ĐOẠN THẲNG VÀ ĐOẠN CONG
    # ==============================================================================
    ref_x_arr = ref_df['x'].values
    ref_y_arr = ref_df['y'].values
    
    for exp in experiments:
        try:
            df = pd.read_excel(exp['file'], sheet_name='History', engine='openpyxl')
            if 'steer' not in df.columns or len(df) == 0:
                continue
                
            # Đổi góc lái từ Radian sang Độ
            df['steer_deg'] = df['steer'] * 180.0 / np.pi
            
            # Tính thời gian tương đối
            if 'timestamp' in df.columns:
                df['time_sec'] = df['timestamp'] - df['timestamp'].iloc[0]
            else:
                df['time_sec'] = np.arange(len(df)) * 0.1
                
            # Tìm chỉ mục reference gần nhất cho từng điểm history
            hist_x = df['x'].values
            hist_y = df['y'].values
            
            # Tính khoảng cách Euclidean nhanh bằng numpy (ma trận N x M chứa bình phương khoảng cách)
            dists = (hist_x[:, np.newaxis] - ref_x_arr[np.newaxis, :])**2 + \
                    (hist_y[:, np.newaxis] - ref_y_arr[np.newaxis, :])**2
            nearest_idx = np.argmin(dists, axis=1)
            
            # Gán node ID tương ứng cho từng điểm history
            df['node_id'] = [ref_node_ids[idx] for idx in nearest_idx]
            
            # 1. Trích xuất dữ liệu Đoạn thẳng (chứa các node thực tế thuộc đoạn thẳng)
            straight_node_ids = {333, 368, 369, 370, 371, 372, 373}
            df_straight = df[df['node_id'].isin(straight_node_ids)]
            if len(df_straight) > 0:
                # Đồng bộ thời gian bắt đầu từ 0 của riêng phân đoạn để dễ so sánh đáp ứng quá độ
                t_straight = df_straight['time_sec'].values - df_straight['time_sec'].values[0]
                ax_steer_straight.plot(t_straight, df_straight['steer_deg'].values,
                                       color=exp['color'], label=exp['label'], linewidth=1.8)
                
            # 2. Trích xuất dữ liệu Đoạn cong (chứa các node thực tế thuộc đường cong cua rẽ)
            curved_node_ids = {374, 375, 376, 377, 378, 379, 380, 381, 382}
            df_curved = df[df['node_id'].isin(curved_node_ids)]
            if len(df_curved) > 0:
                # Đồng bộ thời gian bắt đầu từ 0 của riêng phân đoạn cong
                t_curved = df_curved['time_sec'].values - df_curved['time_sec'].values[0]
                ax_steer_curved.plot(t_curved, df_curved['steer_deg'].values,
                                     color=exp['color'], label=exp['label'], linewidth=1.8)
                                     
        except Exception as e:
            print(f"Lỗi phân tích góc lái cho file {os.path.basename(exp['file'])}: {e}")

    # Cấu hình biểu đồ góc lái đoạn thẳng (Top-Right)
    ax_steer_straight.set_title("Góc lái trong đoạn quỹ đạo thẳng", fontsize=11, fontweight='bold', pad=8)
    ax_steer_straight.set_xlabel("Thời gian trong phân đoạn (s)", fontsize=9.5)
    ax_steer_straight.set_ylabel("Góc lái (độ)", fontsize=9.5)
    ax_steer_straight.grid(True, linestyle=':', alpha=0.5) # Bật lưới mảnh cho biểu đồ góc lái
    ax_steer_straight.set_ylim(-25, 25)
    ax_steer_straight.legend(loc='best', fontsize=8, framealpha=0.8)

    # Cấu hình biểu đồ góc lái đoạn cong (Bottom-Right)
    ax_steer_curved.set_title("Góc lái trong đoạn quỹ đạo cong", fontsize=11, fontweight='bold', pad=8)
    ax_steer_curved.set_xlabel("Thời gian trong phân đoạn (s)", fontsize=9.5)
    ax_steer_curved.set_ylabel("Góc lái (độ)", fontsize=9.5)
    ax_steer_curved.grid(True, linestyle=':', alpha=0.5) # Bật lưới mảnh cho biểu đồ góc lái
    ax_steer_curved.set_ylim(-23, 23)
    ax_steer_curved.legend(loc='best', fontsize=8, framealpha=0.8)

    # Lưu và xuất hình ảnh chất lượng cao (Combined Plot)
    output_filename = "gamma_study_comparison.png"
    plt.savefig(os.path.join(script_dir, output_filename), dpi=300, bbox_inches='tight')
    plt.close() # Giải phóng bộ nhớ
    print(f"=== ĐÃ XUẤT THÀNH CÔNG BIỂU ĐỒ GHÉP: {output_filename} ===")

    # ==============================================================================
    # XUẤT 3 BIỂU ĐỒ RIÊNG BIỆT (MỖI HÌNH SIZE 10x6)
    # ==============================================================================
    print("\n=== ĐANG XUẤT 3 BIỂU ĐỒ RIÊNG BIỆT (SIZE 10x6) ===")

    # ------------------------------------------------------------------------------
    # HÌNH 1: QUỸ ĐẠO DI CHUYỂN
    # ------------------------------------------------------------------------------
    fig_traj = plt.figure(figsize=(10, 6))
    ax_t = fig_traj.add_subplot(1, 1, 1)
    
    # Vẽ đường tham chiếu gốc
    ax_t.plot(ref_df['x'], ref_df['y'], 'k:', label='Quỹ đạo gốc', linewidth=2.0, zorder=1)
    
    # Vẽ ranh giới hành lang sai số
    if 'psi' in ref_df.columns:
        width = 0.20
        nx, ny = -np.sin(ref_df['psi']), np.cos(ref_df['psi'])
        lx_single = ref_df['x'] + width * nx
        ly_single = ref_df['y'] + width * ny
        rx_single = ref_df['x'] - width * nx
        ry_single = ref_df['y'] - width * ny
        
        ax_t.plot(lx_single, ly_single, 'k-', linewidth=0.8, alpha=0.4, label='Hành lang cho phép (±20cm)', zorder=3)
        ax_t.plot(rx_single, ry_single, 'k-', linewidth=0.8, alpha=0.4, zorder=3)

    # Vẽ quỹ đạo xe thực tế của các cấu hình
    for exp in experiments:
        try:
            df = pd.read_excel(exp['file'], sheet_name='History', engine='openpyxl')
            ax_t.plot(df['x'], df['y'], color=exp['color'], label=exp['label'],
                      linestyle='-', linewidth=2.0, zorder=4)
        except Exception as e:
            pass

    # Vẽ vòng tròn khoanh vùng cho Đoạn thẳng (thêm nhãn vào legend)
    ellipse_s_single = Ellipse(xy=(s_xcenter, s_ycenter), width=s_w, height=s_h,
                               edgecolor='#ff7f0e', facecolor='none', linestyle='--', linewidth=1.5, zorder=5, alpha = 0.5,
                               label='Đoạn thẳng')
    ax_t.add_patch(ellipse_s_single)

    # Vẽ vòng tròn khoanh vùng cho Đoạn cong (thêm nhãn vào legend)
    ellipse_c_single = Ellipse(xy=(c_xcenter, c_ycenter), width=c_w, height=c_h,
                               edgecolor='#9467bd', facecolor='none', linestyle='--', linewidth=1.5, zorder=5, alpha =0.5, 
                               label='Đoạn cong')
    ax_t.add_patch(ellipse_c_single)

    ax_t.set_title("Quỹ đạo di chuyển của xe với các giá trị Gamma\n(Sai số lệch làn ban đầu 30cm)", fontsize=12, fontweight='bold', pad=12)
    ax_t.set_xlabel("Tọa độ X (m)", fontsize=11)
    ax_t.set_ylabel("Tọa độ Y (m)", fontsize=11)
    ax_t.grid(False) # Tắt lưới
    ax_t.legend(loc='upper left', fontsize=9, framealpha=0.9)
    # Mở rộng giới hạn X để khớp với tỷ lệ hình 10x6 rộng, tránh bị khoảng trắng thừa hai bên khi dùng equal aspect ratio
    ax_t.set_aspect('equal', 'box')
    ax_t.set_xlim(16.1, 21.5)
    ax_t.set_ylim(9.8, 13.0)
    
    traj_filename = "gamma_trajectory_comparison.png"
    plt.savefig(os.path.join(script_dir, traj_filename), dpi=300, bbox_inches='tight')
    plt.close()
    print(f"-> Đã xuất file quỹ đạo: {traj_filename}")

    # ------------------------------------------------------------------------------
    # HÌNH 2: GÓC LÁI ĐOẠN THẲNG
    # ------------------------------------------------------------------------------
    fig_steer_s = plt.figure(figsize=(10, 6))
    ax_ss = fig_steer_s.add_subplot(1, 1, 1)
    
    for exp in experiments:
        try:
            df = pd.read_excel(exp['file'], sheet_name='History', engine='openpyxl')
            if 'steer' not in df.columns or len(df) == 0:
                continue
            df['steer_deg'] = df['steer'] * 180.0 / np.pi
            
            if 'timestamp' in df.columns:
                df['time_sec'] = df['timestamp'] - df['timestamp'].iloc[0]
            else:
                df['time_sec'] = np.arange(len(df)) * 0.1
                
            hist_x = df['x'].values
            hist_y = df['y'].values
            dists = (hist_x[:, np.newaxis] - ref_x_arr[np.newaxis, :])**2 + \
                    (hist_y[:, np.newaxis] - ref_y_arr[np.newaxis, :])**2
            nearest_idx = np.argmin(dists, axis=1)
            df['node_id'] = [ref_node_ids[idx] for idx in nearest_idx]
            
            straight_node_ids = {333, 368, 369, 370, 371, 372, 373}
            df_straight = df[df['node_id'].isin(straight_node_ids)]
            if len(df_straight) > 0:
                t_straight = df_straight['time_sec'].values - df_straight['time_sec'].values[0]
                ax_ss.plot(t_straight, df_straight['steer_deg'].values,
                           color=exp['color'], label=exp['label'], linewidth=1.8)
        except Exception as e:
            pass

    ax_ss.set_title("Góc lái trong đoạn quỹ đạo thẳng", fontsize=12, fontweight='bold', pad=12)
    ax_ss.set_xlabel("Thời gian trong phân đoạn (s)", fontsize=11)
    ax_ss.set_ylabel("Góc lái (độ)", fontsize=11)
    ax_ss.grid(True, linestyle=':', alpha=0.5) # Bật lưới
    ax_ss.set_ylim(-23, 23)
    ax_ss.legend(loc='best', fontsize=9, framealpha=0.8)
    
    steer_s_filename = "gamma_steering_straight.png"
    plt.savefig(os.path.join(script_dir, steer_s_filename), dpi=300, bbox_inches='tight')
    plt.close()
    print(f"-> Đã xuất file góc lái đoạn thẳng: {steer_s_filename}")

    # ------------------------------------------------------------------------------
    # HÌNH 3: GÓC LÁI ĐOẠN CONG
    # ------------------------------------------------------------------------------
    fig_steer_c = plt.figure(figsize=(10, 6))
    ax_sc = fig_steer_c.add_subplot(1, 1, 1)
    
    for exp in experiments:
        try:
            df = pd.read_excel(exp['file'], sheet_name='History', engine='openpyxl')
            if 'steer' not in df.columns or len(df) == 0:
                continue
            df['steer_deg'] = df['steer'] * 180.0 / np.pi
            
            if 'timestamp' in df.columns:
                df['time_sec'] = df['timestamp'] - df['timestamp'].iloc[0]
            else:
                df['time_sec'] = np.arange(len(df)) * 0.1
                
            hist_x = df['x'].values
            hist_y = df['y'].values
            dists = (hist_x[:, np.newaxis] - ref_x_arr[np.newaxis, :])**2 + \
                    (hist_y[:, np.newaxis] - ref_y_arr[np.newaxis, :])**2
            nearest_idx = np.argmin(dists, axis=1)
            df['node_id'] = [ref_node_ids[idx] for idx in nearest_idx]
            
            curved_node_ids = {374, 375, 376, 377, 378, 379, 380, 381, 382}
            df_curved = df[df['node_id'].isin(curved_node_ids)]
            if len(df_curved) > 0:
                t_curved = df_curved['time_sec'].values - df_curved['time_sec'].values[0]
                ax_sc.plot(t_curved, df_curved['steer_deg'].values,
                           color=exp['color'], label=exp['label'], linewidth=1.8)
        except Exception as e:
            pass

    ax_sc.set_title("Góc lái trong đoạn quỹ đạo cong ", fontsize=12, fontweight='bold', pad=12)
    ax_sc.set_xlabel("Thời gian trong phân đoạn (s)", fontsize=11)
    ax_sc.set_ylabel("Góc lái (độ)", fontsize=11)
    ax_sc.grid(True, linestyle=':', alpha=0.5) # Bật lưới
    ax_sc.set_ylim(-25, 25)
    ax_sc.legend(loc='best', fontsize=9, framealpha=0.8)
    
    steer_c_filename = "gamma_steering_curved.png"
    plt.savefig(os.path.join(script_dir, steer_c_filename), dpi=300, bbox_inches='tight')
    plt.close()
    print(f"-> Đã xuất file góc lái đoạn cong: {steer_c_filename}")

    print("\n=== HOÀN TẤT: ĐÃ XUẤT ĐỦ 3 BIỂU ĐỒ RIÊNG BIỆT 10x6 VÀ 1 BIỂU ĐỒ GHÉP! ===")

if __name__ == '__main__':
    main()
