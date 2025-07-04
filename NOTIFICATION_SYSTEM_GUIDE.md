# Hệ thống thông báo cho Admin

## Tổng quan
Hệ thống thông báo được thiết kế để giúp admin theo dõi và quản lý các đặt lịch mới, đảm bảo không có trùng lịch với stylist.

## Tính năng chính

### 1. Thông báo tự động khi có đặt lịch mới
- Khi khách hàng đặt lịch thành công, hệ thống tự động tạo thông báo cho admin
- Thông báo bao gồm thông tin chi tiết: tên khách hàng, dịch vụ, stylist, ngày giờ
- Admin có thể kiểm tra ngay để tránh trùng lịch

### 2. Quản lý thông báo
- Xem danh sách tất cả thông báo
- Đánh dấu đã đọc từng thông báo hoặc tất cả
- Xóa thông báo không cần thiết
- Phân loại thông báo theo loại (booking, system, alert)

### 3. Hiển thị số lượng thông báo chưa đọc
- Badge hiển thị số thông báo chưa đọc trên sidebar
- Tự động cập nhật mỗi 30 giây
- Dễ dàng nhận biết có thông báo mới

## Cách sử dụng

### Đối với Admin:

1. **Truy cập trang thông báo:**
   - Đăng nhập với tài khoản admin
   - Click vào "Thông báo" trong sidebar
   - Hoặc truy cập trực tiếp: `/NotificationController`

2. **Xem thông báo mới:**
   - Thông báo chưa đọc có viền đỏ và nền hơi đỏ
   - Click "Đã đọc" để đánh dấu đã xem
   - Click "Xem chi tiết" để xem thông tin đặt lịch

3. **Quản lý thông báo:**
   - "Đánh dấu tất cả đã đọc" để xử lý hàng loạt
   - "Xóa" để loại bỏ thông báo không cần thiết
   - Thông báo được sắp xếp theo thời gian tạo (mới nhất trước)

### Đối với Khách hàng:
- Không cần thao tác gì thêm
- Hệ thống tự động tạo thông báo khi đặt lịch thành công

## Cấu trúc dữ liệu

### Bảng Notifications:
```sql
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50) NOT NULL DEFAULT 'system',
    status VARCHAR(20) NOT NULL DEFAULT 'unread',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    related_booking_id INT NULL,
    FOREIGN KEY (related_booking_id) REFERENCES Bookings(booking_id)
);
```

### Các loại thông báo:
- **booking**: Thông báo về đặt lịch mới
- **system**: Thông báo hệ thống
- **alert**: Thông báo cảnh báo

### Trạng thái thông báo:
- **unread**: Chưa đọc
- **read**: Đã đọc

## Tích hợp với hệ thống hiện tại

### 1. BookingController
- Tự động tạo thông báo khi có đặt lịch mới
- Lấy thông tin khách hàng, dịch vụ, stylist để tạo thông báo chi tiết

### 2. AdminController
- Load số lượng thông báo chưa đọc cho dashboard
- Hiển thị badge trên sidebar

### 3. AdminDashboard
- Hiển thị link thông báo với badge số lượng
- Tự động cập nhật số lượng thông báo

## Cài đặt

### 1. Tạo bảng database:
```sql
-- Chạy file CREATE_NOTIFICATIONS_TABLE.sql
```

### 2. Cập nhật web.xml:
```xml
<servlet>
    <servlet-name>NotificationController</servlet-name>
    <servlet-class>Controller.NotificationController</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>NotificationController</servlet-name>
    <url-pattern>/NotificationController</url-pattern>
</servlet-mapping>
```

### 3. Deploy các file mới:
- `src/java/Model/Notification.java`
- `src/java/DAO/NotificationDAO.java`
- `src/java/Controller/NotificationController.java`
- `web/AdminNotifications.jsp`

## Lợi ích

1. **Tránh trùng lịch**: Admin được thông báo ngay khi có đặt lịch mới
2. **Quản lý hiệu quả**: Dễ dàng theo dõi và xử lý các đặt lịch
3. **Thông tin chi tiết**: Mỗi thông báo chứa đầy đủ thông tin cần thiết
4. **Giao diện thân thiện**: Thiết kế đẹp, dễ sử dụng
5. **Tự động cập nhật**: Không cần refresh trang để xem thông báo mới

## Troubleshooting

### Lỗi thường gặp:

1. **Thông báo không hiển thị:**
   - Kiểm tra bảng Notifications đã được tạo chưa
   - Kiểm tra NotificationController đã được đăng ký trong web.xml

2. **Badge không cập nhật:**
   - Kiểm tra JavaScript console có lỗi không
   - Kiểm tra NotificationDAO.getUnreadCount() có hoạt động không

3. **Thông báo không được tạo khi đặt lịch:**
   - Kiểm tra BookingController có gọi NotificationDAO không
   - Kiểm tra log lỗi trong console

## Tương lai

Có thể mở rộng thêm các tính năng:
- Thông báo email cho admin
- Thông báo push notification
- Lọc thông báo theo loại, thời gian
- Export thông báo ra file
- Cài đặt tần suất thông báo 