# FILE VẼ BIỂU ĐỒ ẢNH HƯỞNG CỦA CÁC BÁN KÍNH NHÌN TRƯỚC TỚI HÀNH VI CỦA XE

import pandas as pd
import numpy as np
import matplotlib
# Cấu hình matplotlib sử dụng backend Agg để chạy được trên hệ thống không có giao diện (headless/SSH)
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

# Cấu hình danh sách file đầu vào, nhãn đồ thị và màu sắc tương ứng
experiments = {
    'radius_0.3.xlsx': {'label': 'Bán kính 0.3m', 'color': 'green'},
    'radius_0.4.2.xlsx': {'label': 'Bán kính 0.40m', 'color': 'blue'},
    'radius_0.5.xlsx': {'label': 'Bán kính 0.5m', 'color': 'red'}
}

# Kiểm tra các file Excel có tồn tại đủ không
missing_files = [f for f in experiments.keys() if not os.path.exists(f)]
if missing_files:
    print(f"Lỗi: Thiếu các file dữ liệu sau: {missing_files}")
    print("Vui lòng chạy mô phỏng và lưu đủ 3 file Excel trước khi vẽ.")
    exit(1)

# ==========================================
# BIỂU ĐỒ 1: SO SÁNH QUỸ ĐẠO CHUYỂN ĐỘNG (Y vs X)
# ==========================================
plt.figure(figsize=(10, 6))

# Đọc và vẽ quỹ đạo tham chiếu (từ file đầu tiên, sử dụng engine openpyxl)
try:
    first_file = list(experiments.keys())[0]
    ref_df = pd.read_excel(first_file, sheet_name='Reference', engine='openpyxl')
    plt.plot(ref_df['x'], ref_df['y'], 'k:', label='Quỹ đạo tham chiếu', linewidth=1.8)
    
    # Vẽ thêm 2 đường hành lang sai số cho phép 40cm (±20cm trên mỗi bên đường tham chiếu)
    if 'psi' in ref_df.columns:
        width = 0.20  # 20cm lệch mỗi bên (tổng cộng 40cm)
        nx, ny = -np.sin(ref_df['psi']), np.cos(ref_df['psi'])
        lx, ly = ref_df['x'] + width * nx, ref_df['y'] + width * ny
        rx, ry = ref_df['x'] - width * nx, ref_df['y'] - width * ny
        plt.plot(lx, ly, 'k-', linewidth=1, alpha=0.4, label='Hành lang cho phép (40cm)', zorder=2)
        plt.plot(rx, ry, 'k-', linewidth=1, alpha=0.4, zorder=2)
except Exception as e:
    print(f"Cảnh báo: Không vẽ được đường tham chiếu: {e}")

# Vẽ quỹ đạo thực tế của từng lần chạy
for file_name, config in experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        plt.plot(df['x'], df['y'], color=config['color'], label=config['label'], linewidth=2)
    except Exception as e:
        print(f"Lỗi đọc file {file_name}: {e}")

plt.title('Quỹ đạo chuyển động của xe ứng với các bán kính nhìn trước', fontsize=14, fontweight='bold', pad=15)
plt.xlabel('Tọa độ X (m)', fontsize=12)
plt.ylabel('Tọa độ Y (m)', fontsize=12)
plt.grid(False)
plt.legend(loc='best', fontsize=10)
plt.axis('equal')  # Giữ tỉ lệ trục X và Y bằng nhau để đường cong không bị méo hình học
plt.tight_layout()
plt.savefig('trajectory_comparison_radius.png', dpi=300)
print("Đã lưu biểu đồ quỹ đạo vào file: trajectory_comparison_radius.png")

# ==========================================
# BIỂU ĐỒ 2: SO SÁNH SAI SỐ LỆCH LÀN (e_lat vs X)
# ==========================================
plt.figure(figsize=(10, 6))

# Kẻ 2 đường ngang làm ranh giới ngưỡng sai số cho phép (+/- 0.05m)
plt.axhline(y=0.05, color='black', linestyle='--', linewidth=1.5, label='Ngưỡng sai số $\pm 0.05$ m')
plt.axhline(y=-0.05, color='black', linestyle='--', linewidth=1.5)

for file_name, config in experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        # Cột 'e_lat' chứa sai số khoảng cách ngang so với đường mẫu
        plt.plot(df['x'], df['e_lat'], color=config['color'], label=config['label'], linewidth=2)
    except Exception as e:
        print(f"Lỗi đọc file {file_name} để vẽ sai số: {e}")

plt.title('Sai số ngang (theo tọa độ X)', fontsize=14, fontweight='bold', pad=15)
plt.xlabel('Tọa độ X (m)', fontsize=12)
plt.ylabel('Sai số ngang e_lat (m)', fontsize=12)
plt.ylim(-0.2, 0.2)  # Cấu hình scale trục tung từ -0.2 đến 0.2
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend(loc='best', fontsize=10)
plt.tight_layout()
plt.savefig('error_comparison_radius.png', dpi=300)
print("Đã lưu biểu đồ sai số vào file: error_comparison_radius.png")

# ==========================================
# BIỂU ĐỒ 3: SO SÁNH GÓC LÁI (steer vs Thời gian)
# ==========================================
plt.figure(figsize=(10, 6))

for file_name, config in experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        if 'steer' in df.columns:
            # Tính thời gian tương đối bắt đầu từ 0
            if 'timestamp' in df.columns and len(df) > 0:
                time_sec = df['timestamp'] - df['timestamp'].iloc[0]
            else:
                time_sec = np.arange(len(df)) * 0.1
                
            # Đổi góc lái từ Radian sang Độ để trực quan hơn
            steer_deg = df['steer'] * 180.0 / np.pi
            plt.plot(time_sec, steer_deg, color=config['color'], label=config['label'], linewidth=1.5)
    except Exception as e:
        print(f"Lỗi đọc file {file_name} để vẽ góc lái: {e}")

plt.title('Góc lái thực tế của xe ứng với các bán kính nhìn trước', fontsize=14, fontweight='bold', pad=15)
plt.xlabel('Thời gian (s)', fontsize=12)
plt.ylabel('Góc lái (độ)', fontsize=12)
plt.ylim(-25, 25)  # Scale góc lái từ -25 đến 25 độ
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend(loc='best', fontsize=10)
plt.tight_layout()
plt.savefig('steering_comparison_radius.png', dpi=300)
print("Đã lưu biểu đồ góc lái vào file: steering_comparison_radius.png")

# Không dùng plt.show() ở chế độ không màn hình (headless) để tránh lỗi kết nối server
