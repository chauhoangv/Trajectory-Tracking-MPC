with open("src/planning_wsthanh/src/path_planning/src/path_manager_node.cpp", "r") as f:
    code = f.read()

import re

# We will replace the block inside the iter loop that calculates the gradient and updates.
old_block = r"""                double E_total = E \+ 0\.5 \* yaw_err; \n\n                if \(s == 0\) \{\n                    last_E = E;\n                    last_pred_x = xp\[s\];\n                    last_pred_y = yp\[s\];\n                \}\n\n                double discount_factor = 1\.0 / \(s \+ 1\.0\); \n                grad_for_delta0 \+= discount_factor \* \(E_total \* 1\.5\);\n\n                // Dùng E_total để sửa lỗi luôn góc s nếu bạn muốn các góc delta linh hoạt tự lượn\n                if \(s > 0\) \{\n                    delta_plan\[s\] -= gamma \* E_total \* 1\.5; \n                    delta_plan\[s\] = std::max\(-steer_limit, std::min\(steer_limit, delta_plan\[s\]\)\);\n                \}\n            \}\n\n            // GÓC CHÍNH BÉO delta_plan\[0\] CẦN HỨNG TẤT CẢ TRÁCH NHIỆM\n            delta_plan\[0\] -= gamma \* grad_for_delta0;\n            delta_plan\[0\] = std::max\(-steer_limit, std::min\(steer_limit, delta_plan\[0\]\)\);"""

new_block = """                double E_total = E + 0.5 * yaw_err; 

                if (s == 0) {
                    last_E = E;
                    last_pred_x = xp[s];
                    last_pred_y = yp[s];
                }

                // AI THỰC TẾ: Cập nhật độc lập từng góc lái s để sửa lỗi tại nhịp s đó
                delta_plan[s] -= gamma * E_total * 1.5; 
                delta_plan[s] = std::max(-steer_limit, std::min(steer_limit, delta_plan[s]));

                // KIỂM SOÁT ĐỘ GIẬT (Steering Rate Limit)
                // Ép góc s không được văng quá 3.0 độ so với góc trước đó!
                // Chính ràng buộc này ép thuật toán tạo ra một chuỗi "Cầu thang" vặn lái cực kỳ mượt mà.
                double prev_angle = (s == 0) ? last_steer : delta_plan[s-1];
                double max_jerk = 3.0 * M_PI / 180.0;
                
                if (delta_plan[s] > prev_angle + max_jerk) delta_plan[s] = prev_angle + max_jerk;
                if (delta_plan[s] < prev_angle - max_jerk) delta_plan[s] = prev_angle - max_jerk;
            }"""

code = re.sub(old_block, new_block, code, flags=re.MULTILINE)

# Also remove grad_for_delta0 safely
code = code.replace("double grad_for_delta0 = 0.0;", "// double grad_for_delta0 = 0.0; // Da bo")

with open("src/planning_wsthanh/src/path_planning/src/path_manager_node.cpp", "w") as f:
    f.write(code)
