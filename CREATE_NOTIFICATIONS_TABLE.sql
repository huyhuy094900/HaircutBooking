-- Tạo bảng Notifications để lưu thông báo cho admin
CREATE TABLE IF NOT EXISTS Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50) NOT NULL DEFAULT 'system', -- 'booking', 'system', 'alert'
    status VARCHAR(20) NOT NULL DEFAULT 'unread', -- 'unread', 'read'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    related_booking_id INT NULL,
    FOREIGN KEY (related_booking_id) REFERENCES Bookings(booking_id) ON DELETE SET NULL
);

-- Tạo index để tối ưu hiệu suất truy vấn
CREATE INDEX idx_notifications_status ON Notifications(status);
CREATE INDEX idx_notifications_type ON Notifications(type);
CREATE INDEX idx_notifications_created_at ON Notifications(created_at);
CREATE INDEX idx_notifications_related_booking ON Notifications(related_booking_id);

-- Thêm comment cho bảng
ALTER TABLE Notifications COMMENT = 'Bảng lưu thông báo cho admin khi có đặt lịch mới hoặc sự kiện quan trọng';

-- Thêm một số thông báo mẫu (tùy chọn)
INSERT INTO Notifications (title, message, type, status, related_booking_id) VALUES
('Hệ thống đã sẵn sàng', 'Hệ thống quản lý đặt lịch đã được khởi tạo thành công.', 'system', 'read', NULL),
('Chào mừng Admin', 'Chào mừng bạn đến với hệ thống quản lý đặt lịch. Hãy kiểm tra các đặt lịch mới thường xuyên.', 'system', 'read', NULL); 