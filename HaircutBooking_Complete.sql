-- HaircutBooking Complete Database Setup
-- File này bao gồm cả schema và dữ liệu mẫu
-- Chạy file này để có hệ thống hoàn chỉnh

-- Tạo database nếu chưa có
CREATE DATABASE IF NOT EXISTS HaircutBooking;
USE HaircutBooking;

-- Drop existing tables (if they exist) in correct order due to foreign keys
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS ActivityLogs;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Shifts;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Users;

-- Create Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50),
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    phone VARCHAR(15),
    gender ENUM('Male', 'Female', 'Other'),
    birth_date DATE,
    address VARCHAR(255),
    is_Admin BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_status BOOLEAN DEFAULT FALSE
);

-- Create Services table
CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    duration INT, 
    price DECIMAL(10, 2),
    image VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    service_status BOOLEAN DEFAULT FALSE,
    CHECK (duration > 0),
    CHECK (price >= 0)
);

-- Create Shifts table
CREATE TABLE Shifts (
    shifts_id INT AUTO_INCREMENT PRIMARY KEY,
    start_time TIME,
    end_time TIME,
    CHECK (start_time < end_time)
);

-- Create Staff table
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_name VARCHAR(50),
    staff_email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    staff_image VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    staff_status BOOLEAN DEFAULT FALSE
);

-- Create Bookings table
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    service_id INT,
    staff_id INT,
    shifts_id INT,
    booking_date DATE,
    status ENUM('Pending', 'Confirmed', 'Completed', 'Canceled') DEFAULT 'Pending',
    note TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    FOREIGN KEY (shifts_id) REFERENCES Shifts(shifts_id)
);

-- Create ActivityLogs table
CREATE TABLE ActivityLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    actor_id INT NOT NULL,   
    actor_type ENUM('User', 'Staff', 'Admin') NOT NULL,  
    action TEXT NOT NULL,
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert Admin User
INSERT INTO Users (user_name, full_name, email, password, phone, gender, birth_date, address, is_Admin, user_status) 
VALUES 
('admin', 'System Administrator', 'admin@haircut.com', 'admin123', '0909123456', 'Male', '1990-01-01', '123 Admin Street', TRUE, TRUE);

-- Insert Regular Users
INSERT INTO Users (user_name, full_name, email, password, phone, gender, birth_date, address, is_Admin, user_status) 
VALUES 
('john123', 'John Doe', 'john@example.com', 'password123', '0909123457', 'Male', '1990-05-15', '123 ABC Street', FALSE, TRUE),
('anna456', 'Anna Smith', 'anna@example.com', 'password123', '0911223344', 'Female', '1995-08-20', '456 XYZ Avenue', FALSE, TRUE),
('mike789', 'Mike Johnson', 'mike@example.com', 'password123', '0999888777', 'Male', '1988-12-10', '789 Main Road', FALSE, TRUE),
('lisa321', 'Lisa Brown', 'lisa@example.com', 'password123', '0987654321', 'Female', '1992-03-25', '321 Oak Lane', FALSE, TRUE);

-- Insert Services
INSERT INTO Services (name, description, duration, price, image, service_status) 
VALUES 
('Cắt tóc nam', 'Dịch vụ cắt tóc chuyên nghiệp cho nam giới với nhiều kiểu tóc hiện đại', 30, 100000, 'haircut-male.jpg', TRUE),
('Cắt tóc nữ', 'Dịch vụ cắt tóc và tạo kiểu cho nữ giới', 45, 150000, 'haircut-female.jpg', TRUE),
('Gội đầu massage', 'Thư giãn với gội đầu và massage da đầu chuyên nghiệp', 30, 80000, 'shampoo-massage.jpg', TRUE),
('Nhuộm tóc', 'Dịch vụ nhuộm tóc với nhiều màu sắc đẹp', 90, 300000, 'hair-dye.jpg', TRUE),
('Uốn tóc', 'Dịch vụ uốn tóc tạo kiểu', 120, 400000, 'hair-curling.jpg', TRUE),
('Chăm sóc da mặt', 'Dịch vụ chăm sóc và làm sạch da mặt', 60, 250000, 'facial.jpg', TRUE),
('Làm móng tay', 'Dịch vụ làm móng tay và sơn gel', 45, 120000, 'nail-art.jpg', TRUE),
('Tẩy tế bào chết', 'Dịch vụ tẩy tế bào chết toàn thân', 60, 200000, 'body-scrub.jpg', TRUE);

-- Insert Staff
INSERT INTO Staff (staff_name, staff_email, password, staff_image, staff_status) 
VALUES 
('Linh Nguyen', 'linh.staff@haircut.com', 'staff123', 'linh.jpg', TRUE),
('Hoang Tran', 'hoang.staff@haircut.com', 'staff123', 'hoang.jpg', TRUE),
('Mai Pham', 'mai.staff@haircut.com', 'staff123', 'mai.jpg', TRUE),
('Duc Le', 'duc.staff@haircut.com', 'staff123', 'duc.jpg', TRUE),
('Hoa Nguyen', 'hoa.staff@haircut.com', 'staff123', 'hoa.jpg', TRUE),
('Tuan Pham', 'tuan.staff@haircut.com', 'staff123', 'tuan.jpg', TRUE);

-- Insert Shifts
INSERT INTO Shifts (start_time, end_time) 
VALUES 
('08:00:00', '10:00:00'),
('10:00:00', '12:00:00'),
('13:00:00', '15:00:00'),
('15:00:00', '17:00:00'),
('17:00:00', '19:00:00'),
('19:00:00', '21:00:00');

-- Insert Sample Bookings
INSERT INTO Bookings (user_id, service_id, staff_id, shifts_id, booking_date, status, note) 
VALUES 
(2, 1, 1, 2, '2025-01-20', 'Confirmed', 'Khách yêu cầu cắt ngắn hơn'),
(3, 2, 2, 3, '2025-01-21', 'Pending', 'Yêu cầu tạo kiểu tóc xoăn'),
(4, 3, 3, 4, '2025-01-22', 'Completed', 'Khách hài lòng với dịch vụ'),
(2, 4, 1, 5, '2025-01-23', 'Confirmed', 'Nhuộm màu nâu sáng'),
(3, 5, 2, 6, '2025-01-24', 'Pending', 'Uốn tóc kiểu sóng'),
(5, 1, 4, 1, '2025-01-25', 'Confirmed', 'Cắt tóc nam kiểu hiện đại'),
(4, 6, 5, 3, '2025-01-26', 'Pending', 'Chăm sóc da mặt'),
(2, 7, 6, 4, '2025-01-27', 'Confirmed', 'Làm móng tay gel');

-- Insert Activity Logs
INSERT INTO ActivityLogs (actor_id, actor_type, action) 
VALUES 
(1, 'Admin', 'Tạo tài khoản admin đầu tiên'),
(2, 'User', 'Đăng ký tài khoản mới'),
(3, 'User', 'Đăng ký tài khoản mới'),
(4, 'User', 'Đăng ký tài khoản mới'),
(5, 'User', 'Đăng ký tài khoản mới'),
(1, 'Admin', 'Thêm dịch vụ mới: Cắt tóc nam'),
(1, 'Admin', 'Thêm dịch vụ mới: Cắt tóc nữ'),
(1, 'Admin', 'Thêm nhân viên: Linh Nguyen'),
(1, 'Admin', 'Thêm nhân viên: Hoang Tran'),
(2, 'User', 'Đặt lịch dịch vụ Cắt tóc nam'),
(3, 'User', 'Đặt lịch dịch vụ Cắt tóc nữ'),
(4, 'User', 'Đặt lịch dịch vụ Gội đầu massage');

-- Display summary
SELECT '=== HAIRCUTBOOKING DATABASE SETUP COMPLETE ===' as Status;
SELECT 'Users' as Table_Name, COUNT(*) as Count FROM Users
UNION ALL
SELECT 'Services', COUNT(*) FROM Services
UNION ALL
SELECT 'Staff', COUNT(*) FROM Staff
UNION ALL
SELECT 'Shifts', COUNT(*) FROM Shifts
UNION ALL
SELECT 'Bookings', COUNT(*) FROM Bookings
UNION ALL
SELECT 'ActivityLogs', COUNT(*) FROM ActivityLogs;

-- Show admin account info
SELECT '=== ADMIN ACCOUNT ===' as Info;
SELECT user_name, email, password FROM Users WHERE is_Admin = TRUE;

-- Show test user accounts
SELECT '=== TEST USER ACCOUNTS ===' as Info;
SELECT user_name, email, password FROM Users WHERE is_Admin = FALSE LIMIT 3;

-- Show services
SELECT '=== AVAILABLE SERVICES ===' as Info;
SELECT name, price, duration FROM Services WHERE service_status = TRUE;

-- Show staff
SELECT '=== AVAILABLE STAFF ===' as Info;
SELECT staff_name, staff_email FROM Staff WHERE staff_status = TRUE;

-- Test ngay bây giờ
SELECT * FROM Users ORDER BY created_at DESC LIMIT 5;

-- Update password cho user "hue"
UPDATE Users 
SET password = 'newpassword123' 
WHERE user_name = 'hue'; 

-- Kết nối MySQL
mysql -u root -p
USE HaircutBooking;

-- Tìm user "hue"
SELECT user_id, user_name, full_name, email, password, user_status, is_Admin 
FROM Users 
WHERE user_name = 'hue';

-- Hoặc tìm theo email
SELECT * FROM Users WHERE email LIKE '%hue%'; 