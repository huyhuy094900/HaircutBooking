<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tất cả lịch hẹn - ${staff.staffName}</title>
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/main.css" rel="stylesheet">
        <style>
        body { background-color: #f8f9fa; }
        .main-card { background: white; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .booking-row { transition: transform 0.3s ease; }
        .booking-row:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .status-badge { font-size: 0.8rem; padding: 0.5rem 1rem; }
        .stats-summary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="StaffDashboardController">
                    <i class="bi bi-person-badge"></i> Staff Portal
                </a>
                <div class="navbar-nav ms-auto">
                    <span class="navbar-text me-3">
                        <i class="bi bi-person-circle"></i> ${staff.staffName}
                    </span>
                    <a class="nav-link" href="StaffLoginController?action=logout">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </nav>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2><i class="bi bi-calendar3"></i> Tất cả lịch hẹn</h2>
                    <p class="text-muted mb-0">Quản lý tất cả lịch hẹn của bạn</p>
                </div>
            </div>
        <div class="stats-summary mb-4">
                <div class="row text-center">
                <div class="col-md-3"><h3>${bookingCount}</h3><p class="mb-0">Tổng lịch hẹn</p></div>
                <div class="col-md-3"><h3>${pendingCount}</h3><p class="mb-0">Chờ xác nhận</p></div>
                <div class="col-md-3"><h3>${confirmedCount}</h3><p class="mb-0">Đã xác nhận</p></div>
                <div class="col-md-3"><h3>${completedCount}</h3><p class="mb-0">Đã hoàn thành</p></div>
            </div>
                    </div>
        <div class="main-card p-4">
            <h4 class="mb-3">Danh sách lịch hẹn</h4>
                    <c:if test="${empty allBookings}">
                        <div class="text-center py-5">
                            <i class="bi bi-calendar-x" style="font-size: 4rem; color: #ccc;"></i>
                            <h5 class="mt-3 text-muted">Chưa có lịch hẹn nào</h5>
                            <p class="text-muted">Bạn sẽ thấy các lịch hẹn ở đây khi có khách hàng đặt lịch</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty allBookings}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Khách hàng</th>
                                        <th>Dịch vụ</th>
                                        <th>Ngày</th>
                                        <th>Giờ</th>
                                        <th>Trạng thái</th>
                                        <th>Ghi chú</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${allBookings}" var="booking">
                                <tr class="booking-row">
                                            <td>${booking.bookingId}</td>
                                            <td>
                                        <strong>${booking.user != null ? booking.user.fullName : 'N/A'}</strong><br>
                                        <small class="text-muted">${booking.user != null ? booking.user.email : 'N/A'}</small>
                                            </td>
                                            <td>
                                        <span class="badge bg-info"><i class="bi bi-scissors"></i> ${booking.service != null ? booking.service.name : 'N/A'}</span>
                                            </td>
                                    <td><strong>${booking.bookingDate != null ? booking.bookingDate : 'N/A'}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty booking.shift}">
                                                        <i class="bi bi-clock"></i> ${booking.shift.startTime} - ${booking.shift.endTime}
                                                    </c:when>
                                                    <c:otherwise>N/A</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="badge status-badge 
                                                      <c:choose>
                                                          <c:when test="${booking.status == 'Pending'}">bg-warning</c:when>
                                                          <c:when test="${booking.status == 'Confirmed'}">bg-info</c:when>
                                                          <c:when test="${booking.status == 'Completed'}">bg-success</c:when>
                                                          <c:when test="${booking.status == 'Canceled'}">bg-danger</c:when>
                                                          <c:otherwise>bg-secondary</c:otherwise>
                                                      </c:choose>">
                                                    ${booking.status}
                                                </span>
                                            </td>
                                            <td>
                                        <c:choose>
                                            <c:when test="${not empty booking.note}">
                                                    <span class="text-muted" title="${booking.note}">
                                                        <i class="bi bi-chat-text"></i>
                                                    <c:choose>
                                                        <c:when test="${booking.note.length() > 20}">
                                                            ${booking.note.substring(0, 20)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${booking.note}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Không có ghi chú</span>
                                            </c:otherwise>
                                        </c:choose>
                                            </td>
                                            <td>
                                                    <a class="btn btn-info btn-sm" href="BookingDetailController?id=${booking.bookingId}" title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 