<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="Model.Booking" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt lịch - Admin</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f5f7fa; min-height: 100vh; }
        .admin-header { background: linear-gradient(135deg, #20c997 0%, #0dcaf0 100%); color: white; padding: 32px 0 24px 0; margin-bottom: 24px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .admin-header h1 { font-weight: 700; font-size: 2.2rem; }
        .table-card { background: white; border-radius: 18px; padding: 32px 24px; box-shadow: 0 4px 16px rgba(13,202,240,0.08); margin-top: 24px; }
        .table th, .table td { vertical-align: middle; }
    </style>
</head>
<body>
<jsp:include page="AdminHeader.jsp"/>
<div class="admin-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="bi bi-calendar-check"></i> Quản lý đặt lịch</h1>
                <p class="lead mb-0">Chức năng quản lý đặt lịch cho admin</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="admin" class="btn btn-light">
                    <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                </a>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-card">
        <h3 class="mb-4"><i class="bi bi-list-check"></i> Danh sách lịch đặt</h3>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Khách hàng</th>
                        <th>Dịch vụ</th>
                        <th>Nhân viên</th>
                        <th>Ngày</th>
                        <th>Ca</th>
                        <th>Trạng thái</th>
                        <th>Ghi chú</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${allBookings}" var="booking">
                        <tr>
                            <td>${booking.bookingId}</td>
                            <td>${booking.user.fullName}</td>
                            <td>${booking.service.name}</td>
                            <td>${booking.staff.staffName}</td>
                            <td>${booking.bookingDate}</td>
                            <td>${booking.shift.startTime} - ${booking.shift.endTime}</td>
                            <td>
                                <span class="badge 
                                    ${booking.status == 'Pending' ? 'bg-warning' : 
                                      booking.status == 'Confirmed' ? 'bg-success' : 
                                      booking.status == 'Completed' ? 'bg-info' : 'bg-danger'}">
                                    ${booking.status}
                                </span>
                            </td>
                            <td>${booking.note}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <c:if test="${empty allBookings}">
            <div class="alert alert-info mt-4">Chưa có lịch đặt nào.</div>
        </c:if>
    </div>
</div>

<!-- Notification System -->
<script src="assets/js/notification.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    // Notification system for booking manager
    document.addEventListener('DOMContentLoaded', function() {
        const notificationSystem = new NotificationSystem();
        notificationSystem.startMonitoring(30000, 'bookingManagerCompletedCount');
    });
</script>
</body>
</html> 