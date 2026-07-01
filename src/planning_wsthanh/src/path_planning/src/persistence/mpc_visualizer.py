# FILE VẼ BIỂU ĐỒ MÔ PHỎNG XE (MÔ HÌNH XE ĐẠP & QUỸ ĐẠO TƯƠNG ỨNG CÁC GÓC LÁI)
import matplotlib
matplotlib.use('Agg') 
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np
import os
import glob

def plot_car(ax, x, y, psi, color='green', scale=0.05, alpha=1.0, label=None):
    length, width = scale, scale * 0.7
    pts = np.array([[0, 0], [-length, width/2], [-length, -width/2]])
    R = np.array([[np.cos(psi), -np.sin(psi)], [np.sin(psi), np.cos(psi)]])
    pts = pts @ R.T + [x, y]
    tri = patches.Polygon(pts, closed=True, color=color, alpha=alpha, zorder=20, label=label)
    ax.add_patch(tri)

def calculate_corridors(ref_x, ref_y, ref_psi, width):
    nx, ny = -np.sin(ref_psi), np.cos(ref_psi)
    return (ref_x + width*nx, ref_y + width*ny), (ref_x - width*nx, ref_y - width*ny)

def visualize_academic_proof():
    # Tự động tìm file CSV mới nhất được sinh ra bởi C++ node
    list_of_files = glob.glob('/tmp/mit_study_*.csv')
    if not list_of_files:
        list_of_files = glob.glob('/tmp/planning_dump.csv') # fallback
        
    if not list_of_files:
        print("Lỗi: Không tìm thấy file CSV nào trong /tmp/")
        return
        
    CSV_PATH = max(list_of_files, key=os.path.getctime)
    print(f"Đang vẽ biểu đồ từ file mới nhất: {CSV_PATH}")
    df = pd.read_csv(CSV_PATH)
    if df.empty: return
    # 1. Xác định Chu kỳ đích (Latest Cycle)
    plan_exists = df[df['type'] == 'FINAL_PLAN']
    if plan_exists.empty: return
    target_cycle = plan_exists['cycle_id'].max()
    
    # 2. Lấy trạng thái xe tại chu kỳ này
    history_all = df[df['type'] == 'HISTORY']
    car_state = history_all[history_all['cycle_id'] == target_cycle]
    if car_state.empty: car_now = history_all.iloc[-1]
    else: car_now = car_state.iloc[-1]
    cx, cy = car_now['x'], car_now['y']
    # 3. Lọc lịch sử
    history_upto_now = history_all[history_all['cycle_id'] <= target_cycle]
    
    # 4. Lấy Planning và Target Node
    plan_full = df[(df['type'] == 'PLANNING') & (df['cycle_id'] == target_cycle)]
    final_full = df[(df['type'] == 'FINAL_PLAN') & (df['cycle_id'] == target_cycle)]
    target_node_df = df[(df['type'] == 'TARGET_NODE') & (df['cycle_id'] == target_cycle)]
    radius = 1.0

    def clip(data): return data[np.sqrt((data['x'] - cx)**2 + (data['y'] - cy)**2) <= radius]
    ref_local = clip(df[df['type'] == 'REFERENCE'])
    hist_local = clip(history_upto_now)
    plt.figure(figsize=(10, 6))
    ax = plt.gca()
    # --- VẼ THAM CHIẾU ---
    # plt.plot(ref_local['x'], ref_local['y'], 'k-', linewidth=0.8, alpha=1.0, zorder=1)
    #plt.scatter(ref_local['x'], ref_local['y'], color='k', s=5, zorder=2)
    plt.plot(ref_local['x'], ref_local['y'], 'k--', linewidth=1.2, zorder=2, label='Quỹ đạo tham chiếu')

    # --- VẼ NODE ĐÍCH (ĐỎ) ---
    if not target_node_df.empty:
        node = target_node_df.iloc[0]
        plt.scatter(node['x'], node['y'], color='red', s=120, edgecolors='black', label='Điểm đích mục tiêu', zorder=30)
    # --- VẼ HÀNH LANG (ĐẬM) ---
    if not ref_local.empty:
        for w, c, lbl in [(0.20, 'purple', 'Hành lang sai số cho phép (40cm)'), (0.05, 'grey', 'Hành lang giữ góc lái cũ (10cm)')]:
            (lx, ly), (rx, ry) = calculate_corridors(ref_local['x'], ref_local['y'], ref_local['psi'], w)
            plt.plot(lx, ly, color=c, linestyle='-', linewidth=1.5, alpha=1.0, label=lbl) # Đã thêm label=lbl ở đây
            plt.plot(rx, ry, color=c, linestyle='-', linewidth=1.5, alpha=1.0)
    # --- VẼ LỊCH SỬ ---
    plt.plot(hist_local['x'], hist_local['y'], 'g-', linewidth=1.9, label='Quỹ đạo thực tế', zorder=5)
    
    # --- VẼ PLANNING NODES (Tất cả quỹ đạo của mọi góc lái thử nghiệm) ---
    iters = sorted(plan_full['iter'].unique())
    for i, it in enumerate(iters):
        p = plan_full[plan_full['iter'] == it]
        # Thêm chú thích cho đường góc lái thử nghiệm (chỉ thêm ở lần lặp đầu để tránh trùng lặp Legend)
        lbl = 'Quỹ đạo dự báo (Góc lái thử nghiệm)' if i == 0 else None
        plt.plot(p['x'], p['y'], color='blue', linewidth=1.2, alpha=1.0, zorder=11, label=lbl)

    # --- VẼ ĐƯỜNG MÀU HỒNG VÀ PHÂN TÁCH 3 BƯỚC ---
    if not final_full.empty:
        # Đã loại bỏ nốt chấm quy hoạch hình tròn màu hồng theo yêu cầu
        
        # Vẽ toàn bộ quỹ đạo bằng đường màu hồng mảnh bắt đầu từ bước 0 (xe ma) để nối liền hoàn hảo
        plt.plot(final_full['x'], final_full['y'], color='magenta', linewidth=2.0, alpha=1.0, label='Quỹ đạo dự báo (Góc lái tối ưu)', zorder=14)
        
        # XE MA (GHOST): ĐẶT MŨI NHỌN TẠI NỐT 0
        ghost_pos = final_full.iloc[0] 
        psi_ghost = ghost_pos['psi']
        if len(final_full) > 1:
            next_p = final_full.iloc[1]
            psi_ghost = np.arctan2(next_p['y'] - ghost_pos['y'], next_p['x'] - ghost_pos['x'])
        
        plot_car(ax, ghost_pos['x'], ghost_pos['y'], psi_ghost, color='green', alpha=0.4, scale=0.15, label='Xe ảo')
    # --- VẼ XE THẬT ---
    # plot_car(ax, cx, cy, car_now['psi'], color='green', label='Xe thật')
    plot_car(ax, cx, cy, car_now['psi'], color='green', scale=0.15, label='Xe thật')
    ax.set_xlim(cx - radius, cx + radius)
    ax.set_ylim(cy - radius, cy + radius)
    plt.axis('equal')
    plt.legend(loc='lower right', fontsize='xx-small', framealpha=1.0)
    plt.grid(True, linestyle=':', alpha=0.3)
    plt.title("Quỹ đạo dự báo (Luật MIT & Mô hình xe đạp)", fontsize=10, fontweight='bold')
    
    output_name = "mpc_academic_proof.png"
    plt.savefig(output_name, dpi=300)
    print(f"--- HOÀN TẤT: Đã xuất file {output_name} ---")
if __name__ == "__main__":
    visualize_academic_proof()