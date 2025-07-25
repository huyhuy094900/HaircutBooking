-- Reset Staff and Shifts for HaircutBooking
-- This script resets staff data and updates shifts to new schedule

USE HaircutBooking;

-- Clear existing staff and shifts
DELETE FROM Bookings WHERE staff_id IN (SELECT staff_id FROM Staff);
DELETE FROM Staff;
DELETE FROM Shifts;

-- Reset auto increment
ALTER TABLE Staff AUTO_INCREMENT = 1;
ALTER TABLE Shifts AUTO_INCREMENT = 1;

-- Insert new shifts with updated schedule
INSERT INTO Shifts (start_time, end_time) VALUES 
('08:00:00', '12:00:00'),  -- Ca sáng: 8:00 - 12:00
('12:00:00', '17:00:00'),  -- Ca chiều: 12:00 - 17:00  
('17:00:00', '21:00:00');  -- Ca tối: 17:00 - 21:00

-- Insert staff members
INSERT INTO Staff (staff_name, staff_email, password, staff_image, staff_status, staff_position) VALUES 
('Linh Nguyen', 'linh.staff@haircut.com', 'staff123', 'linh.jpg', TRUE, 'Stylist'),
('Hoang Tran', 'hoang.staff@haircut.com', 'staff123', 'hoang.jpg', TRUE, 'Manager'),
('Mai Pham', 'mai.staff@haircut.com', 'staff123', 'mai.jpg', TRUE, 'Stylist'),
('Duc Le', 'duc.staff@haircut.com', 'staff123', 'duc.jpg', TRUE, 'Assistant'),
('Hoa Nguyen', 'hoa.staff@haircut.com', 'staff123', 'hoa.jpg', TRUE, 'Stylist'),
('Tuan Pham', 'tuan.staff@haircut.com', 'staff123', 'tuan.jpg', TRUE, 'Assistant');

-- Update staff positions
UPDATE Staff SET staff_position = 'Stylist' WHERE staff_id IN (1, 3, 5);
UPDATE Staff SET staff_position = 'Manager' WHERE staff_id = 2;
UPDATE Staff SET staff_position = 'Assistant' WHERE staff_id IN (4, 6);

-- Display results
SELECT '=== SHIFTS UPDATED ===' as Status;
SELECT shifts_id, start_time, end_time FROM Shifts ORDER BY start_time;

SELECT '=== STAFF RESET ===' as Status;
SELECT staff_id, staff_name, staff_email, staff_position FROM Staff ORDER BY staff_id;
