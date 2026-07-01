# FILE VẼ BIỂU ĐỒ ẢNH HƯỞNG CỦA CÁC HÀM MỤC TIÊU TỚI HÀNH VI CỦA XE

import pandas as pd
import numpy as np
import matplotlib
# Cấu hình backend Agg cho hệ thống không có GUI (headless)
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import os

# Cấu hình danh sách các file excel tương ứng với các cấu hình Ablation Study
experiments = {
    '2head_lat_steer_second.xlsx': {
        'label': 'Cấu hình đầy đủ (30% Ngang, 50% Hướng, 20% Góc lái)', 
        'color': '#d62728',  # Crimson Red
        'linestyle': '-', 
        'linewidth': 2.2,
        'zorder': 10
    },
    '2head_lat.xlsx': {
        'label': 'Phạt Hướng + Ngang (50% / 50%)', 
        'color': 'blue',   # Dark Blue
        'linestyle': '-', 
        'linewidth': 1.6,
        'zorder': 8
    },
    '2head_steer_second.xlsx': {
        'label': 'Phạt Hướng + Góc lái (80% / 20%)', 
        'color': 'magenta',  # Magenta/Pink
        'linestyle': '-', 
        'linewidth': 2.0,
        'zorder': 6
    },
    '2only_head_third.xlsx': {
        'label': 'Chỉ phạt Sai số hướng', 
        'color': 'green',  # Orange
        'linestyle': '-', 
        'linewidth': 2.0,
        'zorder': 5
    }
}

# Lọc các file thực tế đang tồn tại để vẽ (tránh lỗi nếu thiếu file)
available_experiments = {}
for file_name, config in experiments.items():
    if os.path.exists(file_name):
        available_experiments[file_name] = config
    else:
        print(f"Cảnh báo: Không tìm thấy file {file_name}, bỏ qua cấu hình này.")

if not available_experiments:
    print("Lỗi: Không tìm thấy bất kỳ file Excel nào trong thư mục hiện tại.")
    print("Vui lòng đảm bảo các file Excel sau đã được sinh ra:")
    for f in experiments.keys():
        print(f" - {f}")
    exit(1)

# Đọc đường tham chiếu chung từ file đầu tiên tìm thấy
ref_df = None
for file_name in available_experiments.keys():
    try:
        ref_df = pd.read_excel(file_name, sheet_name='Reference', engine='openpyxl')
        print(f"Đang đọc đường tham chiếu từ file: {file_name}")
        break
    except Exception as e:
        continue

# ==============================================================================
# BIỂU ĐỒ 1: SO SÁNH QUỸ ĐẠO CHUYỂN ĐỘNG (Y vs X)
# ==============================================================================
plt.figure(figsize=(10, 6))
if ref_df is not None:
    plt.plot(ref_df['x'], ref_df['y'], 'k:', label='Quỹ đạo cần bám', linewidth=2.0, zorder=1)
    
    # Vẽ thêm 2 đường hành lang sai số cho phép 40cm (±20cm trên mỗi bên đường tham chiếu)
    if 'psi' in ref_df.columns:
        width = 0.20  # 20cm lệch mỗi bên
        nx, ny = -np.sin(ref_df['psi']), np.cos(ref_df['psi'])
        lx, ly = ref_df['x'] + width * nx, ref_df['y'] + width * ny
        rx, ry = ref_df['x'] - width * nx, ref_df['y'] - width * ny
        plt.plot(lx, ly, 'k-', linewidth=1.2, alpha=0.5, label='Hành lang cho phép (±20cm)', zorder=2)
        plt.plot(rx, ry, 'k-', linewidth=1.2, alpha=0.5, zorder=2)

for file_name, config in available_experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        plt.plot(df['x'], df['y'], color=config['color'], label=config['label'], 
                 linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
    except Exception as e:
        print(f"Lỗi vẽ Quỹ đạo cho {file_name}: {e}")

plt.title('So sánh quỹ đạo di chuyển thực tế', fontsize=13, fontweight='bold', pad=12)
plt.xlabel('Tọa độ X (m)', fontsize=11)
plt.ylabel('Tọa độ Y (m)', fontsize=11)
plt.grid(False)  # Bỏ lưới (grid) theo yêu cầu đối với biểu đồ quỹ đạo
plt.legend(loc='best', fontsize=9, framealpha=0.9)
plt.axis('scaled')  # Đảm bảo tỉ lệ hình học 1:1 không bị méo lệch
# Điều chỉnh giới hạn X & Y để khớp với tỷ lệ hình 10x6, tránh bị khoảng trắng thừa hai bên
plt.xlim(16.1, 21.5)
plt.ylim(10, 13.2)
plt.savefig('ablation_trajectory_comparison.png', dpi=300, bbox_inches='tight')
print("-> Đã xuất: ablation_trajectory_comparison.png")

# ==============================================================================
# BIỂU ĐỒ 2: SO SÁNH SAI SỐ LỆCH NGANG (e_lat vs Thời gian)
# ==============================================================================
plt.figure(figsize=(10, 6))
# Kẻ 2 đường ranh giới giới hạn sai số cho phép (+/- 20cm)
plt.axhline(y=0.2, color='gray', linestyle='--', linewidth=1.2, alpha=0.8, label='Giới hạn sai số cho phép (±20cm)')
plt.axhline(y=-0.2, color='gray', linestyle='--', linewidth=1.2, alpha=0.8)

for file_name, config in available_experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        time_sec = df['timestamp'] - df['timestamp'].iloc[0] if 'timestamp' in df.columns and len(df) > 0 else np.arange(len(df)) * 0.1
        # Quy đổi ngược từ sai số chuẩn hóa (E_norm) về mét bằng cách nhân với 0.20m
        physical_e_lat = df['e_lat'] * 0.20
        plt.plot(time_sec, physical_e_lat, color=config['color'], label=config['label'],
                 linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
    except Exception as e:
        print(f"Lỗi vẽ Sai số ngang cho {file_name}: {e}")

plt.title('Biểu đồ so sánh sai số lệch ngang (e_lat)', fontsize=13, fontweight='bold', pad=12)
plt.xlabel('Thời gian (s)', fontsize=11)
plt.ylabel('Sai số lệch ngang e_lat (m)', fontsize=11)
plt.ylim(-0.4, 0.4)  # Giới hạn scale để hiển thị rõ dao động của các thuật toán bám đường
plt.grid(True, linestyle=':', alpha=0.5)
plt.legend(loc='best', fontsize=9, framealpha=0.9)
plt.savefig('ablation_lateral_error_comparison.png', dpi=300, bbox_inches='tight')
print("-> Đã xuất: ablation_lateral_error_comparison.png")

# ==============================================================================
# BIỂU ĐỒ 3: SO SÁNH GÓC LÁI VÀ ĐỘ MƯỢT (Góc lái vs Thời gian)
# ==============================================================================
plt.figure(figsize=(10, 6))
for file_name, config in available_experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        time_sec = df['timestamp'] - df['timestamp'].iloc[0] if 'timestamp' in df.columns and len(df) > 0 else np.arange(len(df)) * 0.1
        if 'steer' in df.columns:
            # Đổi góc lái từ radian sang độ để trực quan hơn
            steer_deg = df['steer'] * 180.0 / np.pi
            plt.plot(time_sec, steer_deg, color=config['color'], label=config['label'],
                     linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
    except Exception as e:
        print(f"Lỗi vẽ Góc lái cho {file_name}: {e}")

plt.title('Biểu đồ so sánh góc lái thực tế (Độ)', fontsize=13, fontweight='bold', pad=12)
plt.xlabel('Thời gian (s)', fontsize=11)
plt.ylabel('Góc lái (độ)', fontsize=11)
plt.ylim(-25, 25) 
plt.grid(True, linestyle=':', alpha=0.5)
plt.legend(loc='best', fontsize=9, framealpha=0.9)
plt.savefig('ablation_steering_comparison.png', dpi=300, bbox_inches='tight')
print("-> Đã xuất: ablation_steering_comparison.png")

# ==============================================================================
# BIỂU ĐỒ 4: SO SÁNH SAI SỐ GÓC HƯỚNG (e_yaw vs Thời gian)
# ==============================================================================
plt.figure(figsize=(10, 6))
for file_name, config in available_experiments.items():
    try:
        df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
        time_sec = df['timestamp'] - df['timestamp'].iloc[0] if 'timestamp' in df.columns and len(df) > 0 else np.arange(len(df)) * 0.1
        
        # Tự động tính toán lại sai số hướng e_yaw nếu trong file log bị ghi giá trị 0.0 cố định
        if 'e_yaw' not in df.columns or df['e_yaw'].abs().max() < 1e-5:
            if ref_df is not None:
                e_yaw_calculated = []
                for _, row in df.iterrows():
                    # Tìm điểm tham chiếu gần nhất trên đường tham chiếu
                    dists = (ref_df['x'] - row['x'])**2 + (ref_df['y'] - row['y'])**2
                    nearest_idx = dists.idxmin()
                    psi_ref = ref_df.loc[nearest_idx, 'psi']
                    # Tính độ lệch góc hướng và quy chuẩn về khoảng [-pi, pi]
                    diff = row['psi'] - psi_ref
                    diff_norm = np.arctan2(np.sin(diff), np.cos(diff))
                    e_yaw_calculated.append(diff_norm)
                df['e_yaw'] = e_yaw_calculated
                
        if 'e_yaw' in df.columns:
            # Đổi sai số hướng sang độ để trực quan
            e_yaw_deg = df['e_yaw'] * 180.0 / np.pi
            plt.plot(time_sec, e_yaw_deg, color=config['color'], label=config['label'],
                     linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
    except Exception as e:
        print(f"Lỗi vẽ Sai số góc hướng cho {file_name}: {e}")

plt.title('Biểu đồ so sánh sai số góc hướng (e_yaw)', fontsize=13, fontweight='bold', pad=12)
plt.xlabel('Thời gian (s)', fontsize=11)
plt.ylabel('Sai số góc hướng (độ)', fontsize=11)
plt.ylim(-45, 45) 
plt.grid(True, linestyle=':', alpha=0.5)
plt.legend(loc='best', fontsize=9, framealpha=0.9)
plt.savefig('ablation_heading_error_comparison.png', dpi=300, bbox_inches='tight')
print("-> Đã xuất: ablation_heading_error_comparison.png")

print("\n=== HOÀN TẤT: Đã tạo xong 4 biểu đồ Ablation Study với kích thước 10x6 và căn chỉnh sát viền! ===")

# import pandas as pd
# import numpy as np
# import matplotlib
# # Cấu hình backend Agg cho hệ thống không có GUI (headless)
# matplotlib.use('Agg')
# import matplotlib.pyplot as plt
# import os

# # Cấu hình danh sách các file excel tương ứng với các cấu hình Ablation Study
# experiments = {
#     '2head_lat_steer_second.xlsx': {
#         'label': 'Cấu hình đầy đủ (30% Ngang, 50% Hướng, 20% Góc lái)', 
#         'color': '#d62728',  # Crimson Red
#         'linestyle': '-', 
#         'linewidth': 2.2,
#         'zorder': 10
#     },
#     '2head_lat.xlsx': {
#         'label': 'Phạt Hướng + Ngang (50% / 50%)', 
#         'color': 'blue',   # Dark Blue
#         'linestyle': '-', 
#         'linewidth': 1.6,
#         'zorder': 8
#     },
#     '2head_steer_second.xlsx': {
#         'label': 'Phạt Hướng + Góc lái (80% / 20%)', 
#         'color': 'magenta',  # Magenta/Pink
#         'linestyle': '-', 
#         'linewidth': 2.0,
#         'zorder': 6
#     },
#     '2only_head_third.xlsx': {
#         'label': 'Chỉ phạt Sai số hướng', 
#         'color': 'green',  # Orange
#         'linestyle': '-', 
#         'linewidth': 2.0,
#         'zorder': 5
#     }
# }

# # Lọc các file thực tế đang tồn tại để vẽ (tránh lỗi nếu thiếu file)
# available_experiments = {}
# for file_name, config in experiments.items():
#     if os.path.exists(file_name):
#         available_experiments[file_name] = config
#     else:
#         print(f"Cảnh báo: Không tìm thấy file {file_name}, bỏ qua cấu hình này.")

# if not available_experiments:
#     print("Lỗi: Không tìm thấy bất kỳ file Excel nào trong thư mục hiện tại.")
#     print("Vui lòng đảm bảo các file Excel sau đã được sinh ra:")
#     for f in experiments.keys():
#         print(f" - {f}")
#     exit(1)

# # Đọc đường tham chiếu chung từ file đầu tiên tìm thấy
# ref_df = None
# for file_name in available_experiments.keys():
#     try:
#         ref_df = pd.read_excel(file_name, sheet_name='Reference', engine='openpyxl')
#         print(f"Đang đọc đường tham chiếu từ file: {file_name}")
#         break
#     except Exception as e:
#         continue

# # ==============================================================================
# # BIỂU ĐỒ 1: SO SÁNH QUỸ ĐẠO CHUYỂN ĐỘNG (Y vs X)
# # ==============================================================================
# plt.figure(figsize=(10, 6))
# if ref_df is not None:
#     plt.plot(ref_df['x'], ref_df['y'], 'k:', label='Quỹ đạo cần bám', linewidth=2.0, zorder=1)
    
#     # Vẽ thêm 2 đường hành lang sai số cho phép 40cm (±20cm trên mỗi bên đường tham chiếu)
#     if 'psi' in ref_df.columns:
#         width = 0.20  # 20cm lệch mỗi bên
#         nx, ny = -np.sin(ref_df['psi']), np.cos(ref_df['psi'])
#         lx, ly = ref_df['x'] + width * nx, ref_df['y'] + width * ny
#         rx, ry = ref_df['x'] - width * nx, ref_df['y'] - width * ny
#         plt.plot(lx, ly, 'k-', linewidth=1.2, alpha=0.5, label='Hành lang cho phép (40cm)', zorder=2)
#         plt.plot(rx, ry, 'k-', linewidth=1.2, alpha=0.5, zorder=2)

# for file_name, config in available_experiments.items():
#     try:
#         df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
#         plt.plot(df['x'], df['y'], color=config['color'], label=config['label'], 
#                  linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
#     except Exception as e:
#         print(f"Lỗi vẽ Quỹ đạo cho {file_name}: {e}")

# plt.title('So sánh quỹ đạo di chuyển thực tế', fontsize=13, fontweight='bold', pad=12)
# plt.xlabel('Tọa độ X (m)', fontsize=11)
# plt.ylabel('Tọa độ Y (m)', fontsize=11)
# plt.grid(False)  # Bỏ lưới (grid) theo yêu cầu đối với biểu đồ quỹ đạo
# plt.legend(loc='best', fontsize=9, framealpha=0.9)
# plt.axis('scaled')  # Đảm bảo tỉ lệ hình học 1:1 không bị méo lệch
# plt.xlim(15, 24)
# plt.savefig('ablation_trajectory_comparison.png', dpi=300, bbox_inches='tight')
# print("-> Đã xuất: ablation_trajectory_comparison.png")

# # ==============================================================================
# # BIỂU ĐỒ 2: SO SÁNH SAI SỐ LỆCH NGANG (e_lat vs Thời gian)
# # ==============================================================================
# plt.figure(figsize=(10, 6))
# # Kẻ 2 đường ranh giới giới hạn sai số cho phép (+/- 20cm)
# plt.axhline(y=0.2, color='gray', linestyle='--', linewidth=1.2, alpha=0.8, label='Giới hạn sai số cho phép (±20cm)')
# plt.axhline(y=-0.2, color='gray', linestyle='--', linewidth=1.2, alpha=0.8)

# for file_name, config in available_experiments.items():
#     try:
#         df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
#         time_sec = df['timestamp'] - df['timestamp'].iloc[0] if 'timestamp' in df.columns and len(df) > 0 else np.arange(len(df)) * 0.1
#         # Quy đổi ngược từ sai số chuẩn hóa (E_norm) về mét bằng cách nhân với 0.20m
#         physical_e_lat = df['e_lat'] * 0.20
#         plt.plot(time_sec, physical_e_lat, color=config['color'], label=config['label'],
#                  linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
#     except Exception as e:
#         print(f"Lỗi vẽ Sai số ngang cho {file_name}: {e}")

# plt.title('Biểu đồ so sánh sai số lệch ngang (e_lat)', fontsize=13, fontweight='bold', pad=12)
# plt.xlabel('Thời gian (s)', fontsize=11)
# plt.ylabel('Sai số lệch ngang e_lat (m)', fontsize=11)
# plt.ylim(-0.4, 0.4)  # Giới hạn scale để hiển thị rõ dao động của các thuật toán bám đường
# plt.grid(True, linestyle=':', alpha=0.5)
# plt.legend(loc='best', fontsize=9, framealpha=0.9)
# plt.savefig('ablation_lateral_error_comparison.png', dpi=300, bbox_inches='tight')
# print("-> Đã xuất: ablation_lateral_error_comparison.png")

# # ==============================================================================
# # BIỂU ĐỒ 3: SO SÁNH GÓC LÁI VÀ ĐỘ MƯỢT (Góc lái vs Thời gian)
# # ==============================================================================
# plt.figure(figsize=(10, 6))
# for file_name, config in available_experiments.items():
#     try:
#         df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
#         time_sec = df['timestamp'] - df['timestamp'].iloc[0] if 'timestamp' in df.columns and len(df) > 0 else np.arange(len(df)) * 0.1
#         if 'steer' in df.columns:
#             # Đổi góc lái từ radian sang độ để trực quan hơn
#             steer_deg = df['steer'] * 180.0 / np.pi
#             plt.plot(time_sec, steer_deg, color=config['color'], label=config['label'],
#                      linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
#     except Exception as e:
#         print(f"Lỗi vẽ Góc lái cho {file_name}: {e}")

# plt.title('Biểu đồ so sánh góc lái thực tế (Độ)', fontsize=13, fontweight='bold', pad=12)
# plt.xlabel('Thời gian (s)', fontsize=11)
# plt.ylabel('Góc lái (độ)', fontsize=11)
# plt.ylim(-25, 25) 
# plt.grid(True, linestyle=':', alpha=0.5)
# plt.legend(loc='best', fontsize=9, framealpha=0.9)
# plt.savefig('ablation_steering_comparison.png', dpi=300, bbox_inches='tight')
# print("-> Đã xuất: ablation_steering_comparison.png")

# # ==============================================================================
# # BIỂU ĐỒ 4: SO SÁNH SAI SỐ GÓC HƯỚNG (e_yaw vs Thời gian)
# # ==============================================================================
# plt.figure(figsize=(10, 6))
# for file_name, config in available_experiments.items():
#     try:
#         df = pd.read_excel(file_name, sheet_name='History', engine='openpyxl')
#         time_sec = df['timestamp'] - df['timestamp'].iloc[0] if 'timestamp' in df.columns and len(df) > 0 else np.arange(len(df)) * 0.1
        
#         # Tự động tính toán lại sai số hướng e_yaw nếu trong file log bị ghi giá trị 0.0 cố định
#         if 'e_yaw' not in df.columns or df['e_yaw'].abs().max() < 1e-5:
#             if ref_df is not None:
#                 e_yaw_calculated = []
#                 for _, row in df.iterrows():
#                     # Tìm điểm tham chiếu gần nhất trên đường tham chiếu
#                     dists = (ref_df['x'] - row['x'])**2 + (ref_df['y'] - row['y'])**2
#                     nearest_idx = dists.idxmin()
#                     psi_ref = ref_df.loc[nearest_idx, 'psi']
#                     # Tính độ lệch góc hướng và quy chuẩn về khoảng [-pi, pi]
#                     diff = row['psi'] - psi_ref
#                     diff_norm = np.arctan2(np.sin(diff), np.cos(diff))
#                     e_yaw_calculated.append(diff_norm)
#                 df['e_yaw'] = e_yaw_calculated
                
#         if 'e_yaw' in df.columns:
#             # Đổi sai số hướng sang độ để trực quan
#             e_yaw_deg = df['e_yaw'] * 180.0 / np.pi
#             plt.plot(time_sec, e_yaw_deg, color=config['color'], label=config['label'],
#                      linestyle=config['linestyle'], linewidth=config['linewidth'], zorder=config['zorder'])
#     except Exception as e:
#         print(f"Lỗi vẽ Sai số góc hướng cho {file_name}: {e}")

# plt.title('Biểu đồ so sánh sai số góc hướng (e_yaw)', fontsize=13, fontweight='bold', pad=12)
# plt.xlabel('Thời gian (s)', fontsize=11)
# plt.ylabel('Sai số góc hướng (độ)', fontsize=11)
# plt.ylim(-45, 45) 
# plt.grid(True, linestyle=':', alpha=0.5)
# plt.legend(loc='best', fontsize=9, framealpha=0.9)
# plt.savefig('ablation_heading_error_comparison.png', dpi=300, bbox_inches='tight')
# print("-> Đã xuất: ablation_heading_error_comparison.png")

# print("\n=== HOÀN TẤT: Đã tạo xong 4 biểu đồ Ablation Study với kích thước 10x6 và căn chỉnh sát viền! ===")

