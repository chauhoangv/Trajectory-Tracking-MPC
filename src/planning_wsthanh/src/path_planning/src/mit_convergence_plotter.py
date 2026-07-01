# FILE VẼ BIỂU ĐỒ 

import matplotlib
matplotlib.use('Agg')
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
import glob

def get_latest_csv():
    # Prioritize /tmp/planning_dump.csv, otherwise fallback to mit_study_*.csv
    dump_file = '/tmp/planning_dump.csv'
    if os.path.exists(dump_file) and os.path.getsize(dump_file) > 0:
        return dump_file
    
    list_of_files = glob.glob('/tmp/mit_study_*.csv')
    if not list_of_files:
        return None
    latest_file = max(list_of_files, key=os.path.getctime)
    return latest_file

def plot_mit_convergence():
    CSV_PATH = get_latest_csv()
    if not CSV_PATH:
        print("Error: Không tìm thấy file log nào tại /tmp/planning_dump.csv hoặc /tmp/mit_study_*.csv")
        return
        
    print(f"Đang vẽ biểu đồ từ file log: {CSV_PATH}")
    df = pd.read_csv(CSV_PATH)
    
    # Lọc các cycle_id có dữ liệu PLANNING
    planning_cycles = df[df['type'] == 'PLANNING']['cycle_id'].unique()
    if len(planning_cycles) == 0:
        print("Không tìm thấy dữ liệu PLANNING trong CSV.")
        return
    latest_cid = max(planning_cycles)
    
    # 1. Trích xuất Góc Lái Hiện Tại từ log HISTORY để làm mốc k-1
    history_latest = df[(df['type'] == 'HISTORY') & (df['cycle_id'] == latest_cid)]
    steer_k_1 = 0.0
    if not history_latest.empty:
        steer_k_1 = history_latest['steer'].values[0] # đơn vị radian
    
    # 2. Lọc dữ liệu PLANNING cho chu kỳ (cycle) mới nhất
    df_plan = df[(df['type'] == 'PLANNING') & (df['cycle_id'] == latest_cid)].copy()
    if df_plan.empty:
        print("Dữ liệu PLANNING của chu kỳ mới nhất trống.")
        return
        
    # 3. Lấy danh sách tất cả các lần lặp (Iterations)
    available_iters = sorted(df_plan['iter'].unique())
    
    iters = []
    cost_lat_list = []
    cost_head_list = []
    cost_energy_list = []
    steer_deg_list = []
    
    # 4. Tính toán các thành phần hàm chi phí cho từng vòng lặp
    for it in available_iters:
        df_it = df_plan[df_plan['iter'] == it].sort_values('step')
        steps = df_it['step'].values
        
        # Lấy giá trị góc lái (đơn vị radian) tại vòng lặp này
        steer_m = df_it['steer'].values[0]
        steer_deg = np.degrees(steer_m)
        
        # Trích xuất trọng số động (nếu có, không thì lấy mặc định)
        w_lat_val = df_it['w_lat'].values[0] if 'w_lat' in df_it.columns else 3.0
        w_head_val = df_it['w_head'].values[0] if 'w_head' in df_it.columns else 1.0
        w_energy = 20.0
        
        # Tính toán hàm chi phí có trọng số thời gian (quadratic time-based weighting)
        sum_weights = 0.0
        weighted_lat_sum = 0.0
        weighted_head_sum = 0.0
        
        for idx, s in enumerate(steps):
            weight = (s + 1.0) * (s + 1.0)
            e_lat = df_it['e_lat'].values[idx]
            e_yaw = df_it['e_yaw'].values[idx]
            
            # Sử dụng trị tuyệt đối hoặc bình phương theo hàm chi phí thực tế
            weighted_lat_sum += weight * w_lat_val * (e_lat ** 2)
            weighted_head_sum += weight * w_head_val * (e_yaw ** 2)
            sum_weights += weight
            
        cost_lat = weighted_lat_sum / sum_weights if sum_weights > 0 else 0.0
        cost_head = weighted_head_sum / sum_weights if sum_weights > 0 else 0.0
        cost_energy = 0.5 * w_energy * ((steer_m - steer_k_1) ** 2)
        
        iters.append(it + 1) # Chuyển sang 1-indexed để vẽ trục hoành
        cost_lat_list.append(cost_lat)
        cost_head_list.append(cost_head)
        cost_energy_list.append(cost_energy)
        steer_deg_list.append(steer_deg)

    # 5. Vẽ biểu đồ học thuật chất lượng cao (Dual Y-Axis)
    plt.rcParams['font.family'] = 'sans-serif'
    plt.rcParams['font.sans-serif'] = ['DejaVu Sans', 'Arial', 'Liberation Sans']
    
    fig, ax1 = plt.subplots(figsize=(10, 6), dpi=300)
    ax2 = ax1.twinx() # Tạo trục Y thứ hai bên phải
    
    # Định màu phong cách hiện đại học thuật (Gam màu lạnh hài hòa)
    color_lat = '#AF7AC5'    # Soft Blue (Lạnh)
    color_head = '#2E86C1'   #
    color_energy = '#C0392B' # Soft Mint/Teal (Lạnh)
    color_steer = '#1C2833'  # Professional Crimson Red
    
    # Vẽ cột chồng (Stacked Bars) trên trục bên trái ax1
    bars_lat = ax1.bar(iters, cost_lat_list, label='Sai số ngang ($J_{lat}$)', color=color_lat, alpha=0.95, width=0.6)
    bars_head = ax1.bar(iters, cost_head_list, bottom=cost_lat_list, label='Sai số hướng ($J_{head}$)', color=color_head, alpha=0.95, width=0.6)
    
    # Vẽ trực tiếp năng lượng lái thực tế không scale (scale_energy = 1.0)
    scale_energy = 1.0
    cost_energy_scaled = [c * scale_energy for c in cost_energy_list]
    
    # Tính bottom cho cột energy
    bottom_energy = np.array(cost_lat_list) + np.array(cost_head_list)
    bars_energy = ax1.bar(iters, cost_energy_scaled, bottom=bottom_energy, 
                          label='Biến thiên góc lái ($J_{\delta}$)', 
                          color=color_energy, alpha=0.95, width=0.6)
    
    # Vẽ đường biến thiên góc lái trên trục bên phải ax2 (làm nét hơn cho máy chiếu)
    line_steer = ax2.plot(iters, steer_deg_list, color=color_steer, marker='o', markersize=7, 
                          linewidth=2.5, linestyle='-', label='Góc lái $\delta$ (Độ)', zorder=10)
    
    # Cấu hình trục bên trái ax1 (Hàm chi phí)
    ax1.set_xlabel('Số vòng lặp tối ưu hóa MIT ($m$)', fontweight='bold', fontsize=11, labelpad=10)
    ax1.set_ylabel('Giá trị các thành phần của Hàm chi phí $J(\delta)$', fontweight='bold', fontsize=11, labelpad=10)
    ax1.tick_params(axis='y', labelsize=10)
    ax1.tick_params(axis='x', labelsize=10)
    ax1.grid(True, linestyle=':', alpha=0.5, axis='y')
    
    # Cấu hình trục bên phải ax2 (Góc lái)
    ax2.set_ylabel('Góc lái $\delta^{(m)}$ (Độ)', color=color_steer, fontweight='bold', fontsize=11, labelpad=10)
    ax2.tick_params(axis='y', labelcolor=color_steer, labelsize=10)
    
    # Cài đặt giới hạn trục hoành gọn gàng
    ax1.set_xlim(0.5, len(iters) + 0.5)
    ax1.set_xticks(iters)
    
    # Tự động tính toán giới hạn trục Y với 20% khoảng trống phía trên (headroom)
    max_stacked = max(np.array(cost_lat_list) + np.array(cost_head_list) + np.array(cost_energy_scaled))
    ax1.set_ylim(0, max_stacked * 1.2)
    

    # Gộp legend từ cả 2 trục
    lines, labels = ax1.get_legend_handles_labels()
    lines2, labels2 = ax2.get_legend_handles_labels()
    ax1.legend(lines + lines2, labels + labels2, loc='upper right', framealpha=0.9, facecolor='white', edgecolor='#EAECEE')
    
    # Tiêu đề biểu đồ chuyên nghiệp y chang hình yêu cầu
    plt.title('Đặc tính hội tụ của hàm chi phí và góc lái tối ưu qua các vòng lặp MIT', fontsize=13, fontweight='bold', pad=15)
    
    # 6. Tính toán và in thông tin hội tụ ra Terminal
    final_diff = np.abs(np.radians(steer_deg_list[-1]) - np.radians(steer_deg_list[-2])) if len(steer_deg_list) > 1 else 0.0
    
    print("\n" + "="*45)
    print("           THÔNG TIN HỘI TỤ MIT")
    print("="*45)
    print(f" - Tổng số vòng lặp: {len(iters)}")
    print(f" - Góc lái tối ưu: {steer_deg_list[-1]:.2f}°")
    print(f" - Độ lệch cuối cùng: {final_diff:.6f} rad")
    print(" - Điều kiện dừng: |delta^(m+1) - delta^m| <= 10^-4 rad")
    print("="*45 + "\n")
            
    # Lưu hình ảnh chất lượng cao ngay tại thư mục người dùng
    output_path = os.path.expanduser('~/mpc_convergence_plotter.png')
    plt.savefig(output_path, dpi=300, bbox_inches='tight')
    plt.close()
    
    print(f"--- THÀNH CÔNG: Biểu đồ hội tụ học thuật đã được lưu tại {output_path} ---")

if __name__ == "__main__":
    plot_mit_convergence()