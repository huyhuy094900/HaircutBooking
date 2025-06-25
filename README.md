# Hệ Thống Đặt Lịch Cắt Tóc

## 📋 Mô tả
Hệ thống đặt lịch cắt tóc được phát triển bằng Java Web với công nghệ JSP, Servlet và MySQL. Hệ thống cho phép khách hàng đặt lịch cắt tóc trực tuyến và quản lý lịch hẹn một cách dễ dàng.

## ✨ Tính năng chính

### 👤 Người dùng
- Đăng ký và đăng nhập tài khoản
- Đặt lịch cắt tóc với nhiều dịch vụ khác nhau
- Chọn thợ cắt và thời gian phù hợp
- Xem lịch sử đặt lịch
- Hủy lịch hẹn
- Cập nhật thông tin cá nhân

### 👨‍💼 Admin
- Quản lý danh sách khách hàng
- Quản lý dịch vụ cắt tóc
- Quản lý thợ cắt
- Xác nhận/hủy lịch hẹn
- Xem báo cáo và thống kê

## 🛠️ Công nghệ sử dụng

### Backend
- **Java Servlet**: Xử lý logic nghiệp vụ
- **JSP**: Giao diện người dùng
- **MySQL**: Cơ sở dữ liệu
- **JDBC**: Kết nối database

### Frontend
- **Bootstrap 5**: Framework CSS
- **Bootstrap Icons**: Icon library
- **JavaScript**: Xử lý client-side
- **HTML5/CSS3**: Giao diện responsive

### Build & Deploy
- **Apache Tomcat**: Web server
- **PowerShell**: Script build tự động

## 📁 Cấu trúc dự án

```
BookingService/
├── src/
│   └── java/
│       ├── Controller/     # Các Servlet
│       ├── DAO/           # Data Access Objects
│       └── Model/         # Các Entity classes
├── web/
│   ├── WEB-INF/          # Cấu hình web
│   ├── assets/           # CSS, JS, Images
│   └── *.jsp            # Các trang JSP
├── build_and_deploy.ps1  # Script build
├── CompleteDatabase.sql  # Database schema
└── README.md
```

## 🚀 Cài đặt và chạy

### Yêu cầu hệ thống
- Java JDK 8 trở lên
- Apache Tomcat 9+
- MySQL 8.0+
- PowerShell (Windows)

### Bước 1: Clone repository
```bash
git clone https://github.com/your-username/BookingService.git
cd BookingService
```

### Bước 2: Cài đặt database
1. Tạo database MySQL mới
2. Import file `CompleteDatabase.sql`
3. Cập nhật thông tin kết nối trong `DBContext.java`

### Bước 3: Build project
```powershell
.\build_and_deploy.ps1
```

### Bước 4: Deploy lên Tomcat
1. Copy thư mục `web` vào `webapps` của Tomcat
2. Khởi động Tomcat
3. Truy cập: `http://localhost:8080/BookingService`

## 📊 Database Schema

### Bảng chính
- **Users**: Thông tin người dùng
- **Services**: Dịch vụ cắt tóc
- **Staff**: Thợ cắt
- **Shifts**: Ca làm việc
- **Bookings**: Lịch hẹn

## 🔧 Cấu hình

### Database Connection
Cập nhật thông tin kết nối trong `src/java/DAO/DBContext.java`:
```java
private static final String SERVER_NAME = "localhost";
private static final String DB_NAME = "haircut_booking";
private static final String PORT_NUMBER = "3306";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

## 📱 Giao diện

### Trang chủ
- Hiển thị dịch vụ nổi bật
- Thông tin về salon
- Đăng nhập/Đăng ký

### Đặt lịch
- Form đặt lịch với validation
- Chọn dịch vụ, thợ cắt, thời gian
- Giao diện responsive

### Quản lý lịch hẹn
- Xem danh sách lịch hẹn
- Trạng thái: Chờ xác nhận, Đã xác nhận, Hoàn thành, Đã hủy
- Hủy lịch hẹn

## 🤝 Đóng góp

1. Fork dự án
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit thay đổi (`git commit -m 'Add some AmazingFeature'`)
4. Push lên branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📄 License

Dự án này được phát hành dưới MIT License. Xem file `LICENSE` để biết thêm chi tiết.

## 👨‍💻 Tác giả

**Tên của bạn**
- Email: your.email@example.com
- GitHub: [@your-username](https://github.com/your-username)

## 🙏 Cảm ơn

Cảm ơn bạn đã quan tâm đến dự án này! Nếu có bất kỳ câu hỏi nào, hãy tạo issue hoặc liên hệ trực tiếp. 