# Luồng Của Cắt Tóc

## **Tổng Quan Hệ Thống**

### **Kiến trúc tổng quan:**
- **Frontend**: JSP pages với Bootstrap UI
- **Backend**: Java Servlets (MVC pattern)
- **Database**: MySQL với các bảng Users, Services, Staff, Shifts, Bookings
- **Server**: Tomcat với Jakarta EE

---

## **1. Luồng Đăng Nhập và Xác Thực**

```
User → Login.jsp → LoginController → Database → Session → Home.jsp
```

**Chi tiết:**
- User nhập thông tin đăng nhập vào `Login.jsp`
- `LoginController` xác thực thông tin với database
- Nếu thành công: tạo session và redirect về `Home.jsp`
- Nếu thất bại: hiển thị lỗi và yêu cầu nhập lại

**Cấu hình Session:**
- Session timeout: 30 phút
- Cookie: http-only=true, secure=false
- Tất cả controllers đều kiểm tra session trước khi xử lý

---

## **2. Luồng Đặt Lịch Chính**

### **Bước 1: Truy cập form đặt lịch**
```
User → BookingController (không có action) → showBookingForm() → BookingForm.jsp
```

### **Bước 2: Hiển thị form đặt lịch**
`BookingController.showBookingForm()` thực hiện:
- Lấy danh sách services từ `DaoService.getAllActiveServices()`
- Lấy danh sách staff từ `StaffDAO.getActiveStaff()`
- Lấy danh sách shifts từ `BookingDAO.getAllShifts()`
- Forward dữ liệu đến `BookingForm.jsp`

### **Bước 3: User điền form và submit**
```
BookingForm.jsp → BookingController?action=create → createBooking()
```

### **Bước 4: Xử lý đặt lịch**
`createBooking()` method thực hiện:
1. Lấy thông tin từ form:
   - `serviceId`: ID dịch vụ
   - `staffId`: ID stylist
   - `shiftId`: ID ca làm việc
   - `bookingDate`: Ngày đặt lịch
   - `note`: Ghi chú (optional)

2. Kiểm tra availability: `bookingDAO.isTimeSlotAvailable()`
   - Kiểm tra xem time slot đã có booking nào chưa
   - Loại trừ các booking có status "Canceled"

3. Nếu available:
   - Tạo booking mới với status "Pending"
   - Forward đến `BookingSuccess.jsp`

4. Nếu không available:
   - Hiển thị lỗi "Selected time slot is not available!"
   - Forward về `BookingForm.jsp`

---

## **3. Luồng Xem Lịch Đã Đặt**

```
User → BookingController?action=list → listUserBookings() → MyBookingsSimple.jsp
```

**Chi tiết:**
- `listUserBookings()` lấy tất cả bookings của user từ `BookingDAO.getBookingsByUser()`
- Query kết hợp thông tin từ các bảng: Users, Services, Staff, Shifts
- Hiển thị danh sách với các action: Cancel, Confirm, Complete
- Sắp xếp theo booking_date DESC (mới nhất trước)

---

## **4. Luồng Quản Lý Booking (Admin)**

```
Admin → AdminBookings.jsp → BookingController?action=confirm/cancel/complete
```

**Các action có sẵn:**
- **Confirm**: `BookingDAO.updateBookingStatus(bookingId, "Confirmed")`
- **Cancel**: `BookingDAO.cancelBooking(bookingId, reason)`
- **Complete**: `BookingDAO.updateBookingStatus(bookingId, "Completed")`

**Sau mỗi action:**
- Redirect về `AdminBookings.jsp`
- Hiển thị thông báo success/error

---

## **5. Kiểm Tra Availability Real-time**

```
AJAX → BookingController?action=checkAvailability → checkAvailability()
```

**Chức năng:**
- Kiểm tra real-time xem time slot có available không
- Trả về JSON response
- Sử dụng cho dynamic validation

---

## **6. Các Luồng Phụ**

### **Đăng ký tài khoản:**
```
Register.jsp → RegisterController → Database → Login.jsp
```

### **Quản lý profile:**
```
UserChangeProfile.jsp → ChangePersonalInformationController → Database
```

### **Admin Dashboard:**
```
AdminDashboard.jsp → AdminDashboardController → Các trang quản lý
```

### **Quản lý User (Admin):**
- Ban/Unban user
- Xem chi tiết user
- Danh sách tất cả users

---

## **7. Database Schema**

### **Bảng chính:**

**Users:**
- `user_id` (PK)
- `full_name`
- `email`
- `password` (hashed)
- `phone`
- `role` (user/admin)
- `status` (active/banned)

**Services:**
- `service_id` (PK)
- `name`
- `price`
- `duration` (minutes)
- `description`
- `status` (active/inactive)

**Staff:**
- `staff_id` (PK)
- `staff_name`
- `phone`
- `email`
- `staff_status` (active/inactive)

**Shifts:**
- `shifts_id` (PK)
- `start_time`
- `end_time`

**Bookings:**
- `booking_id` (PK)
- `user_id` (FK → Users)
- `service_id` (FK → Services)
- `staff_id` (FK → Staff)
- `shifts_id` (FK → Shifts)
- `booking_date`
- `status` (Pending/Confirmed/Completed/Canceled)
- `note`
- `created_at`

---

## **8. Servlet Mappings (web.xml)**

**BookingController:**
- URL: `/BookingController`
- Class: `Controller.BookingController`

**Các Controllers khác:**
- `LoginController`: `/login`
- `HomeController`: `/home`
- `RegisterController`: `/register`
- `AdminController`: `/admin`
- `ListAllService`: `/list_service`

---

## **9. Error Handling**

### **Database Operations:**
- Try-catch trong tất cả database operations
- Log lỗi và hiển thị user-friendly messages

### **Session Validation:**
- Kiểm tra session trong tất cả protected controllers
- Redirect về `Login.jsp` nếu chưa đăng nhập

### **Input Validation:**
- Validate form data trước khi xử lý
- Hiển thị error messages qua JSP

### **Error Pages:**
- 404: `/error/404.jsp`
- 500: `/error/500.jsp`

---

## **10. Security Features**

### **Session Management:**
- Session timeout: 30 phút
- Http-only cookies
- Session validation trên tất cả protected pages

### **Password Security:**
- Password hashing (BCrypt)
- Secure password reset flow

### **Input Sanitization:**
- Prepared statements cho tất cả database queries
- Validation và sanitization input data

### **Role-based Access:**
- User role: chỉ có thể đặt lịch và xem booking của mình
- Admin role: quản lý toàn bộ hệ thống

---

## **11. UI/UX Features**

### **Bootstrap Integration:**
- Responsive design
- Modern UI components
- Mobile-friendly interface

### **Interactive Elements:**
- Dynamic form validation
- Real-time availability checking
- Status badges cho bookings

### **User Experience:**
- Clear navigation
- Intuitive booking flow
- Success/error feedback
- Loading states

---

## **12. Build và Deployment**

### **Build Process:**
- PowerShell build script: `build_and_deploy.ps1`
- Compile Java files với proper encoding
- Copy compiled classes và resources

### **Dependencies:**
- Jakarta Servlet API
- MySQL Connector
- JSTL
- BCrypt for password hashing

### **Deployment:**
- Tomcat server
- MySQL database
- Proper file permissions

---

## **13. Testing và Debugging**

### **Test Controllers:**
- `TestLoginController` cho testing
- Error logging và debugging
- Session testing

### **Database Testing:**
- Test data scripts
- Connection testing
- Query optimization

---

## **Kết Luận**

Đây là một hệ thống booking hoàn chỉnh với:
- ✅ Đầy đủ chức năng CRUD
- ✅ Authentication và Authorization
- ✅ Session management
- ✅ Admin management
- ✅ Real-time availability checking
- ✅ Modern UI/UX
- ✅ Security features
- ✅ Error handling
- ✅ Database optimization

Hệ thống được thiết kế theo mô hình MVC, dễ maintain và mở rộng. 