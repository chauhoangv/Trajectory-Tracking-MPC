# FILE LƯU DỮ LIỆU THÀNH .CSV

import pandas as pd
import sys
import os

def csv_to_excel(csv_path, excel_path):
    if not os.path.exists(csv_path):
        print(f"Lỗi: Không tìm thấy file log {csv_path}.")
        print("Hãy đảm bảo bạn đã chạy mô phỏng và xe đã di chuyển.")
        return
    
    print(f"Đang đọc dữ liệu từ {csv_path}...")
    df = pd.read_csv(csv_path)
    
    # Lọc dữ liệu đường tham chiếu và dữ liệu chạy thực tế
    ref_df = df[df['type'] == 'REFERENCE'][['x', 'y', 'psi']]
    hist_df = df[df['type'] == 'HISTORY'][['timestamp', 'x', 'y', 'psi', 'e_lat', 'steer']]
    
    # Ghi vào Excel với 2 sheet riêng biệt
    with pd.ExcelWriter(excel_path, engine='openpyxl') as writer:
        ref_df.to_excel(writer, sheet_name='Reference', index=False)
        hist_df.to_excel(writer, sheet_name='History', index=False)
        
    print(f"Đã lưu dữ liệu thành công vào: {excel_path}\n")

if __name__ == "__main__":
    csv_path = "/tmp/planning_dump.csv"
    
    if len(sys.argv) < 2:
        print("Cách sử dụng: python save_run_data.py <tên_file_excel_đầu_ra.xlsx>")
        print("Ví dụ: python save_run_data.py radius_0.25.xlsx")
        sys.exit(1)
        
    excel_path = sys.argv[1]
    csv_to_excel(csv_path, excel_path)