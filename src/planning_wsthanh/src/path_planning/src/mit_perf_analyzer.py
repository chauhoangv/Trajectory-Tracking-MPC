# FILE VẼ BIỂU ĐỒ SỐ VÒNG LẶP & THỜI GIAN CÁC VÒNG LẶP MIT RULE

import matplotlib
matplotlib.use('Agg')
import pandas as pd
import matplotlib.pyplot as plt
import os
import numpy as np

CSV_PATH = "/tmp/planning_dump.csv"

FIG_SIZE = (10, 6)
DPI = 300

def plot_performance():
    if not os.path.exists(CSV_PATH):
        print(f"Lỗi: Không tìm thấy file {CSV_PATH}. Hãy chạy xe để tạo dữ liệu trước.")
        return
    
    try:
        df = pd.read_csv(CSV_PATH)
    except Exception as e:
        print(f"Lỗi khi đọc file CSV: {e}")
        return
    
    perf_df = df[df['type'] == 'PERF'].copy()
    if perf_df.empty:
        print("Không tìm thấy dữ liệu 'PERF' trong CSV.")
        return
    
    perf_df = perf_df.rename(columns={'e_lat': 'duration_ms', 'iter': 'iterations'})
    durations = perf_df['duration_ms']
    iterations = perf_df['iterations']

    # 1. Biểu đồ Phân phối Thời gian (Planning Duration Distribution)
    plt.figure(figsize=FIG_SIZE)
    plt.hist(durations, bins=25, color='skyblue', edgecolor='black', alpha=0.7)
    plt.axvline(durations.mean(), color='red', linestyle='dashed', linewidth=2, label=f'Mean: {durations.mean():.3f} ms')
    plt.xlabel('Planning Duration (ms)', fontweight='bold')
    plt.ylabel('Frequency (Count)', fontweight='bold')
    plt.title('MIT Planning Duration Distribution (Variance Analysis)', fontsize=14, fontweight='bold')
    plt.legend()
    plt.grid(axis='y', linestyle='--', alpha=0.5)
    plt.tight_layout()
    plt.savefig('mit_duration_dist.png', dpi=DPI)
    plt.close()

    # 2. Biểu đồ Phân phối Số vòng lặp (Iterations Distribution)
    plt.figure(figsize=FIG_SIZE)
    plt.hist(iterations, bins=range(int(min(iterations)), int(max(iterations)) + 2), color='salmon', edgecolor='black', alpha=0.7, align='left')
    plt.axvline(iterations.mean(), color='blue', linestyle='dashed', linewidth=2, label=f'Mean: {iterations.mean():.1f}')
    plt.xlabel('Number of Iterations', fontweight='bold')
    plt.ylabel('Frequency (Count)', fontweight='bold')
    plt.title('MIT Optimization Iterations Distribution (Variance Analysis)', fontsize=14, fontweight='bold')
    plt.legend()
    plt.grid(axis='y', linestyle='--', alpha=0.5)
    plt.tight_layout()
    plt.savefig('mit_iterations_dist.png', dpi=DPI)
    plt.close()

    # 3. Xuất file dữ liệu
    try:
        # Xuất Excel (Cần openpyxl)
        perf_df[['cycle_id', 'duration_ms', 'iterations']].to_excel('mit_performance_report.xlsx', index=False)
        print(f"--- THÀNH CÔNG: Đã tạo 2 biểu đồ (10x6) và file Excel 'mit_performance_report.xlsx' ---")
    except Exception as e:
        print(f"Lỗi khi xuất Excel: {e}. Đang xuất CSV dự phòng...")
        # Fallback sang CSV (Excel vẫn mở được bình thường)
        perf_df[['cycle_id', 'duration_ms', 'iterations']].to_csv('mit_performance_report.csv', index=False)
        print("--- Đã xuất file CSV dự phòng: 'mit_performance_report.csv' ---")

if __name__ == "__main__":
    plot_performance()
