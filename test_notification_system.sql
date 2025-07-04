-- Script test hệ thống thông báo
-- Chạy sau khi đã tạo bảng Notifications

-- 1. Tạo một số thông báo test
INSERT INTO Notifications (title, message, type, status, related_booking_id) VALUES
('Test: Đặt lịch mới', 'Khách hàng Nguyễn Văn Test đã đặt lịch cắt tóc nam với stylist Trần Thị A vào ngày 2024-01-15. Vui lòng kiểm tra lịch trùng.', 'booking', 'unread', NULL),
('Test: Đặt lịch mới', 'Khách hàng Lê Văn Test đã đặt lịch nhuộm tóc với stylist Nguyễn Thị B vào ngày 2024-01-16. Vui lòng kiểm tra lịch trùng.', 'booking', 'unread', NULL),
('Test: Hệ thống', 'Hệ thống đã được cập nhật thành công.', 'system', 'read', NULL),
('Test: Cảnh báo', 'Có 5 đặt lịch chờ xác nhận cần xử lý.', 'alert', 'unread', NULL);

-- 2. Kiểm tra thông báo đã tạo
SELECT 
    notification_id,
    title,
    message,
    type,
    status,
    created_at,
    related_booking_id
FROM Notifications 
ORDER BY created_at DESC;

-- 3. Đếm số thông báo chưa đọc
SELECT COUNT(*) as unread_count 
FROM Notifications 
WHERE status = 'unread';

-- 4. Đếm số thông báo theo loại
SELECT 
    type,
    COUNT(*) as count
FROM Notifications 
GROUP BY type;

-- 5. Test đánh dấu đã đọc
UPDATE Notifications 
SET status = 'read', read_at = NOW() 
WHERE notification_id = 1;

-- 6. Kiểm tra lại sau khi đánh dấu đã đọc
SELECT 
    notification_id,
    title,
    status,
    read_at
FROM Notifications 
WHERE notification_id = 1;

-- 7. Xóa thông báo test
-- DELETE FROM Notifications WHERE title LIKE 'Test:%'; 