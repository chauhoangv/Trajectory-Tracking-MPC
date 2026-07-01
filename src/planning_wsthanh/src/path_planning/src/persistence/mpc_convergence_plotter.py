# FILE VẼ BIỂU ĐỒ HỘI TỤ GÓC LÁI & HÀM CHI PHÍ

import matplotlib
matplotlib.use('Agg')
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os

CSV_PATH = "/tmp/planning_dump.csv"

def plot_mpc_convergence():
    if not os.path.exists(CSV_PATH):
        print(f"Error: {CSV_PATH} not found.")
        return
    df = pd.read_csv(CSV_PATH)
    
    # 1. Lọc PLANNING cho chu kỳ mới nhất
    planning_all = df[df['type'] == 'PLANNING'].copy()
    if planning_all.empty:
        print("No PLANNING data found in CSV.")
        return
        
    latest_cid = planning_all['cycle_id'].max()
    df_plan = planning_all[planning_all['cycle_id'] == latest_cid].copy()
    
    # 2. Lấy danh sách lần lặp
    available_iters = sorted(df_plan['iter'].unique())
    if len(available_iters) >= 3:
        # Lấy mốc: Đầu, Giữa, Cuối
        selected_iters = [available_iters[0], available_iters[len(available_iters)//2], available_iters[-1]]
    else:
        selected_iters = available_iters
    
    # Thứ tự màu: Green (Initial), Blue (Midway), Magenta (Final)
    colors = {
        0: '#2ca02c',  # Green cho Initial
        1: '#1f77b4',  # Blue cho Midway
        2: '#FF00FF'   # Magenta cho Final/Optimized
    }
    
    fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(10, 12), sharex=True)
    plt.subplots_adjust(hspace=0.2)

    # VẼ CÁC ĐƯỜNG
    for i, it in enumerate(selected_iters):
        # Xác định vai trò (Đầu, Giữa, Cuối) để gán màu và zorder
        role_idx = 0 if i == 0 else (2 if i == len(selected_iters)-1 else 1)
        color = colors[role_idx]
        
        # ÉP MÀU HỒNG LUÔN Ở TRÊN CÙNG (zorder cao nhất)
        z = 50 if role_idx == 2 else (20 if role_idx == 1 else 10)
        
        cycle_data = df_plan[df_plan['iter'] == it].sort_values('step')
        steps = cycle_data['step'].values
        
        # Data
        steer_deg = np.degrees(cycle_data['steer'].values)
        # Thêm offset cực nhỏ cho Steer để phân tách các đường nếu chúng trùng khít
        if role_idx == 1: steer_deg += 0.002
        elif role_idx == 0: steer_deg -= 0.002
            
        e_lat = cycle_data['e_lat'].values
        e_yaw = np.degrees(cycle_data['e_yaw'].values)
        
        label = f"Iter {it} (Initial)" if role_idx == 0 else (f"Iter {it} (Optimized)" if role_idx == 2 else f"Iter {it} (Midway)")

        # Phân tách Exec và Pred
        exec_mask = steps <= 2
        pred_mask = steps >= 2
        
        # Plot Subplots
        for ax, data in zip([ax1, ax2, ax3], [steer_deg, e_lat, e_yaw]):
            ax.plot(steps[exec_mask], data[exec_mask], color=color, linewidth=5 if role_idx==2 else 3, label=label if ax==ax1 else None, zorder=z)
            ax.plot(steps[pred_mask], data[pred_mask], color=color, linestyle='--', linewidth=1.5, zorder=z)
            ax.scatter(steps[exec_mask], data[exec_mask], color=color, s=40, zorder=z+1)

    # Styling
    ax1.set_ylabel("Steer Angle (deg)", fontweight='bold')
    ax1.grid(True, linestyle=':', alpha=0.6)
    ax1.legend(loc='lower left', fontsize='small', framealpha=0.9)
    ax1.set_title(f"Optimizer Convergence (Cycle {latest_cid})", fontsize=12, fontweight='bold')
    ax1.set_ylim(-25, 25) 
    
    ax2.set_ylabel("Lat Error (m)", fontweight='bold')
    ax2.grid(True, linestyle=':', alpha=0.6)
    
    ax3.set_ylabel("Heading Error (deg)", fontweight='bold')
    ax3.set_xlabel("Prediction Step (0.1s per step)", fontweight='bold')
    ax3.grid(True, linestyle=':', alpha=0.6)
    
    fig.text(0.5, 0.02, "Thick: Executed | Dashed: Prediction | PINK is Final Optimized (Always Top)", 
             ha='center', fontsize=10, style='italic', bbox=dict(facecolor='white', alpha=0.8))

    output_path = "mpc_convergence_chart.png"
    plt.savefig(output_path, dpi=300, bbox_inches='tight')
    plt.close()
    print(f"--- SUCCESS: Convergence chart saved as {output_path} ---")

if __name__ == "__main__":
    plot_mpc_convergence()
