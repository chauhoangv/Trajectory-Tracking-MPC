# FILE LƯU DỮ LIỆU THÀNH .CSV

import pandas as pd
import sys
import os
import glob

def csv_to_excel(csv_path, excel_path):
    if not os.path.exists(csv_path):
        print(f"Lỗi: Không tìm thấy file log {csv_path}.")
        print("Hãy đảm bảo bạn đã chạy mô phỏng và xe đã di chuyển.")
        return False
    
    print(f"Đang đọc dữ liệu từ {csv_path}...")
    try:
        df = pd.read_csv(csv_path)
    except Exception as e:
        print(f"Lỗi khi đọc file CSV: {e}")
        return False
    
    # Lọc dữ liệu đường tham chiếu
    # Giữ thêm cột 'step' vì nó chứa chỉ mục của tham chiếu (waypoint index)
    ref_cols = ['step', 'x', 'y', 'psi']
    existing_ref_cols = [col for col in ref_cols if col in df.columns]
    ref_df = df[df['type'] == 'REFERENCE'][existing_ref_cols]
    
    # Lọc dữ liệu chạy thực tế (History) bao gồm tọa độ, góc hướng, các loại sai số, góc lái và giá trị chi phí tổng
    columns_to_keep = ['timestamp', 'x', 'y', 'psi', 'e_lat', 'e_yaw', 'steer', 'e_total', 'w_lat', 'w_head']
    
    # Đảm bảo chỉ lấy các cột thực tế có mặt trong file CSV để tránh lỗi
    existing_columns = [col for col in columns_to_keep if col in df.columns]
    hist_df = df[df['type'] == 'HISTORY'][existing_columns]
    
    # Ghi vào Excel với 2 sheet riêng biệt
    try:
        with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
            ref_df.to_excel(writer, sheet_name='Reference', index=False)
            hist_df.to_excel(writer, sheet_name='History', index=False)
        print(f"Đã lưu dữ liệu thành công vào: {excel_path}\n")
        return True
    except Exception as e:
        print(f"Lỗi khi ghi file Excel: {e}")
        return False

if __name__ == "__main__":
    # Tự động tìm file CSV mới nhất được tạo ra trong /tmp
    list_of_files = glob.glob('/tmp/mit_study_*.csv')
    if not list_of_files:
        list_of_files = glob.glob('/tmp/planning_dump.csv') # fallback
        
    if list_of_files:
        csv_path = max(list_of_files, key=os.path.getctime)
        print(f"Tự động chọn file CSV log mới nhất: {csv_path}")
    else:
        csv_path = "/tmp/planning_dump.csv"
        
    if len(sys.argv) < 2:
        print("Cách sử dụng: python3 save_gamma_data.py <tên_file_excel_đầu_ra.xlsx>")
        print("Ví dụ: python3 save_gamma_data.py gamma_0.15.xlsx")
        sys.exit(1)
        
    excel_path = sys.argv[1]
    csv_to_excel(csv_path, excel_path)
