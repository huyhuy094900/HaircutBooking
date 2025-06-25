# DELETE USER GUIDE - Hướng dẫn xóa user

## 🎯 Mục tiêu
Xóa user có ID=6 (user "hue") khỏi database.

## 🚀 Cách xóa user

### Cách 1: Sử dụng DeleteUserController (Khuyến nghị)

#### Bước 1: Truy cập trang xóa user
```
http://localhost:8080/BookingService/delete-user?userID=6
```

#### Bước 2: Xác nhận xóa
- Trang sẽ hiển thị thông tin user "hue"
- Click "Yes, Delete User" để xác nhận
- Hoặc click "Cancel" để hủy

### Cách 2: Xóa trực tiếp trong MySQL

#### Bước 1: Kết nối MySQL
```bash
mysql -u root -p
USE HaircutBooking;
```

#### Bước 2: Kiểm tra user trước khi xóa
```sql
-- Xem thông tin user ID=6
SELECT user_id, user_name, full_name, email, is_Admin 
FROM Users 
WHERE user_id = 6;
```

#### Bước 3: Xóa user
```sql
-- Xóa user ID=6 (chỉ xóa user thường, không xóa admin)
DELETE FROM Users 
WHERE user_id = 6 AND is_Admin = FALSE;
```

#### Bước 4: Kiểm tra kết quả
```sql
-- Kiểm tra user đã bị xóa
SELECT * FROM Users WHERE user_id = 6;

-- Đếm tổng số users
SELECT COUNT(*) as total_users FROM Users;
```

### Cách 3: Sử dụng Database Test Page

#### Bước 1: Kiểm tra user hiện tại
```
http://localhost:8080/BookingService/database-test
```

#### Bước 2: Xem danh sách users
- Tìm user "hue" trong bảng
- Ghi nhớ User ID

#### Bước 3: Xóa bằng MySQL
Sử dụng cách 2 để xóa trực tiếp trong database.

## ✅ Kiểm tra sau khi xóa

### 1. Kiểm tra Database
```sql
-- Xem tất cả users còn lại
SELECT user_id, user_name, full_name, email, is_Admin 
FROM Users 
ORDER BY user_id;

-- Đếm số lượng users
SELECT COUNT(*) as total_users FROM Users;
```

### 2. Kiểm tra Web Page
```
http://localhost:8080/BookingService/database-test
```
- User "hue" không còn xuất hiện trong danh sách
- Tổng số users giảm từ 6 xuống 5

### 3. Kiểm tra Admin Panel
```
http://localhost:8080/BookingService/Login.jsp
Email: admin@haircut.com
Password: admin123
→ Manage Users
```
- User "hue" không còn trong danh sách

## ⚠️ Lưu ý quan trọng

### 1. Không thể xóa Admin
- User admin (ID=1) không thể bị xóa
- Chỉ có thể xóa user thường

### 2. Xóa vĩnh viễn
- Dữ liệu bị xóa không thể khôi phục
- Cần xác nhận trước khi xóa

### 3. Foreign Key Constraints
- Nếu user có bookings, có thể cần xóa bookings trước
- Hoặc sử dụng CASCADE DELETE

## 🔄 Khôi phục user (nếu cần)

### Cách 1: Đăng ký lại
```
http://localhost:8080/BookingService/Register.jsp
```
- Đăng ký user mới với thông tin tương tự

### Cách 2: Insert trực tiếp
```sql
-- Insert lại user "hue"
INSERT INTO Users (user_name, full_name, email, password, phone, gender, birth_date, is_Admin, user_status) 
VALUES ('hue', 'Hue User', 'hue@example.com', 'password123', '0909123456', 'Male', '1990-01-01', FALSE, TRUE);
```

## 🧪 Test sau khi xóa

### 1. Test đăng nhập
```
http://localhost:8080/BookingService/Login.jsp
Email: hue@example.com
Password: password123
```
- Kết quả: "Tài khoản hoặc mật khẩu chưa chính xác"

### 2. Test đăng ký lại
```
http://localhost:8080/BookingService/Register.jsp
```
- Có thể đăng ký lại với username "hue"

### 3. Test admin panel
- User "hue" không còn trong danh sách Manage Users

---

## 📞 Hỗ trợ

Nếu gặp vấn đề:
1. Kiểm tra user ID có đúng không
2. Kiểm tra user có phải admin không
3. Kiểm tra foreign key constraints
4. Restart NetBeans project nếu cần 