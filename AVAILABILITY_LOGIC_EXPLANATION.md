# Logic Kiểm Tra Availability Đã Được Đơn Giản Hóa

## Logic Mới (Đơn Giản)

Logic hiện tại đã được đơn giản hóa theo yêu cầu:

### 1. Kiểm Tra Khung Giờ Available (`getAvailableShifts`)

```sql
SELECT DISTINCT sh.* FROM Shifts sh 
WHERE EXISTS (
    SELECT 1 FROM Staff st 
    WHERE st.staff_status = TRUE 
    AND NOT EXISTS (
        SELECT 1 FROM Bookings b 
        WHERE b.staff_id = st.staff_id 
        AND b.shifts_id = sh.shifts_id 
        AND b.booking_date = ? 
        AND b.status != 'Canceled'
    )
) ORDER BY sh.start_time
```

**Logic:**
- Lấy tất cả khung giờ (shifts)
- Với mỗi khung giờ, kiểm tra xem có ít nhất 1 stylist available không
- Stylist available = stylist có trạng thái active VÀ chưa có booking nào trong khung giờ và ngày đó
- Chỉ trả về những khung giờ có ít nhất 1 stylist available

### 2. Kiểm Tra Stylist Available (`getAvailableStylists`)

```sql
SELECT st.* FROM Staff st 
WHERE st.staff_status = TRUE 
AND NOT EXISTS (
    SELECT 1 FROM Bookings b 
    WHERE b.staff_id = st.staff_id 
    AND b.shifts_id = ? 
    AND b.booking_date = ? 
    AND b.status != 'Canceled'
)
```

**Logic:**
- Lấy tất cả stylist có trạng thái active
- Loại bỏ những stylist đã có booking trong khung giờ và ngày cụ thể
- Trả về danh sách stylist available

### 3. Kiểm Tra Time Slot Available (`isStylistAvailable`)

```sql
SELECT COUNT(*) FROM Bookings 
WHERE staff_id = ? AND shifts_id = ? AND booking_date = ? AND status != 'Canceled'
```

**Logic:**
- Kiểm tra xem stylist cụ thể có available trong khung giờ và ngày cụ thể không
- Trả về `true` nếu không có booking nào (available)
- Trả về `false` nếu đã có booking (not available)

## Điểm Khác Biệt So Với Logic Cũ

### Logic Cũ (Phức Tạp):
- Kiểm tra theo service_id
- Loại bỏ toàn bộ khung giờ nếu có booking cho service đó
- Không phân biệt stylist

### Logic Mới (Đơn Giản):
- Không phân biệt service (tất cả staff làm được tất cả services)
- Chỉ kiểm tra xem stylist có bị trùng lịch không
- Trả về khung giờ nếu có ít nhất 1 stylist available

## Ví Dụ Thực Tế

**Tình huống:** Ngày 2025-01-20, khung giờ 10:00-12:00

**Dữ liệu hiện tại:**
- Staff 1 (Linh): Đã có booking
- Staff 2 (Hoang): Chưa có booking
- Staff 3 (Mai): Chưa có booking

**Kết quả:**
- Khung giờ 10:00-12:00 = **AVAILABLE** (vì có Staff 2 và 3 available)
- Stylist available: Hoang, Mai

## Cách Test

1. **Test khung giờ available:**
   ```
   GET /checkAvailability?date=2025-01-20&serviceId=1
   ```

2. **Test stylist available:**
   ```
   GET /getAvailableStylists?shiftId=2&date=2025-01-20&serviceId=1
   ```

3. **Test booking:**
   ```
   POST /booking
   {
     "serviceId": 1,
     "staffId": 2,
     "shiftId": 2,
     "date": "2025-01-20"
   }
   ```

## Lưu Ý

- Logic này đơn giản hơn và dễ hiểu hơn
- Tất cả staff có thể làm tất cả services
- Chỉ cần kiểm tra trùng lịch stylist
- Không cần kiểm tra service compatibility 