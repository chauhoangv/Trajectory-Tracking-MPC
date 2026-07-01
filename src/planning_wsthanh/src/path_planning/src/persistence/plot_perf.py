# FILE LƯU DỮ LIỆU THÀNH .CSV

import matplotlib
matplotlib.use('Agg') # Chế độ headless cho server
import pandas as pd
import matplotlib.pyplot as plt
import os

CSV_PATH = "/tmp/planning_dump.csv"
OUTPUT_IMAGE = "planning_performance.png"

def plot_performance():
    if not os.path.exists(CSV_PATH):
        print(f"Lỗi: Không tìm thấy file {CSV_PATH}. Hãy chạy xe để tạo dữ liệu trước.")
        return
    # Đọc dữ liệu CSV
    try:
        df = pd.read_csv(CSV_PATH)
    except Exception as e:
        print(f"Lỗi khi đọc file CSV: {e}")
        return
    # Lọc dữ liệu loại PERFORMANCE (PERF)
    perf_df = df[df['type'] == 'PERF'].copy()
    if perf_df.empty:
        print("Không tìm thấy dữ liệu 'PERF' trong CSV. Kiểm tra lại code C++.")
        return

    # --- CHỌN KHOẢNG CHU KỲ ĐỂ PHÂN TÍCH VÀ IN THỐNG KÊ ---
    start_c, end_c = 0, 100  # <<< THAY ĐỔI KHOẢNG CHU KỲ TẠI ĐÂY
    mask = (perf_df['cycle_id'] >= start_c) & (perf_df['cycle_id'] <= end_c)
    filtered_df = perf_df[mask]
    # ---------------------------------------------------

    # Trích xuất dữ liệu từ khoảng đã chọn
    cycles = filtered_df['cycle_id'].values
    durations = filtered_df['e_lat'].values
    iterations = filtered_df['iter'].values

    if len(cycles) == 0:
        print(f"Cảnh báo: Không có dữ liệu trong khoảng từ {start_c} đến {end_c}.")
        return

    # Vẽ biểu đồ
    fig, ax1 = plt.subplots(figsize=(12, 6))
    # Trục 1: Thời gian lập kế hoạch (ms)
    color1 = 'tab:blue'
    ax1.set_xlabel('Cycle ID (Chu kỳ điều khiển)')
    ax1.set_ylabel('Thời gian lập kế hoạch (ms)', color=color1, fontweight='bold')
    ax1.plot(cycles, durations, color=color1, linestyle='-', linewidth=1.5, label='Duration (ms)')
    ax1.tick_params(axis='y', labelcolor=color1)
    ax1.grid(True, linestyle='-', alpha=0.6)
    # Trục 2: Số vòng lặp tối ưu
    ax2 = ax1.twinx()
    color2 = 'tab:red'
    ax2.set_ylabel('Số vòng lặp', color=color2, fontweight='bold')
    ax2.step(cycles, iterations, color=color2, where='post', alpha=0.5, linestyle='-', label='Iterations')
    ax2.tick_params(axis='y', labelcolor=color2)
    # Tiêu đề và chú thích
    plt.title('Hiệu suất lập kế hoạch MIT', fontsize=14, fontweight='bold')
    fig.tight_layout()
    
    # Lưu file ảnh
    plt.savefig(OUTPUT_IMAGE, dpi=300)
    plt.close()
    
    print(f"--- THÀNH CÔNG: Biểu đồ hiệu năng đã được lưu tại {OUTPUT_IMAGE} ---")
    print(f"Thống kê (tính trong khoảng Cycle {start_c} đến {end_c}):")
    print(f" - Tổng số chu kỳ: {len(cycles)}")
    print(f" - Thời gian trung bình: {durations.mean():.3f} ms")
    print(f" - Thời gian lớn nhất: {durations.max():.3f} ms")
if __name__ == "__main__":
    plot_performance()
