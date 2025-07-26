<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch hẹn hôm nay - ${staff.staffName}</title>
    
    <!-- Bootstrap CSS -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="assets/css/main.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        
        .navbar-brand {
            font-weight: 600;
        }
        
        .main-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .time-slot {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .time-slot:hover {
            border-color: #667eea;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }
        
        .time-slot.has-booking {
            border-color: #667eea;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f2ff 100%);
        }
        
        .time-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 2rem;
        }
        
        .booking-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .status-badge {
            font-size: 0.8rem;
            padding: 0.5rem 1rem;
        }
        
        .empty-slot {
            text-align: center;
            color: #6c757d;
            padding: 2rem;
        }
        
        .time-indicator {
            font-size: 1.2rem;
            font-weight: 600;
            color: #667eea;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
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
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2><i class="bi bi-calendar-day"></i> Lịch hẹn hôm nay</h2>
                <p class="text-muted mb-0">${todayDate} - Quản lý lịch hẹn trong ngày</p>
            </div>
            <div>
                <a href="StaffDashboardController?action=viewBookings" class="btn btn-primary">
                    <i class="bi bi-calendar3"></i> Tất cả lịch hẹn
                </a>
                <!-- Đã xóa modal và form xin nghỉ liên quan đến StaffDayOffController ở đây -->
            </div>
        </div>

        <!-- Today's Summary -->
        <div class="time-header">
            <div class="row text-center">
                <div class="col-md-3">
                    <h3>${bookingCount}</h3>
                    <p class="mb-0">Tổng lịch hẹn hôm nay</p>
                </div>
                <div class="col-md-3">
                    <h3 id="pendingCount">0</h3>
                    <p class="mb-0">Chờ xác nhận</p>
                </div>
                <div class="col-md-3">
                    <h3 id="confirmedCount">0</h3>
                    <p class="mb-0">Đã xác nhận</p>
                </div>
                <div class="col-md-3">
                    <h3 id="completedCount">0</h3>
                    <p class="mb-0">Đã hoàn thành</p>
                </div>
            </div>
        </div>

        <!-- Today's Schedule -->
        <div class="main-card">
            <div class="p-4">
                <h4 class="mb-4">
                    <i class="bi bi-clock"></i> Lịch làm việc hôm nay
                </h4>

                <c:if test="${empty todayBookings}">
                    <div class="text-center py-5">
                        <i class="bi bi-calendar-x" style="font-size: 4rem; color: #ccc;"></i>
                        <h5 class="mt-3 text-muted">Không có lịch hẹn nào hôm nay</h5>
                        <p class="text-muted">Bạn có thể nghỉ ngơi hoặc chuẩn bị cho ngày mai</p>
                    </div>
                </c:if>

                <c:if test="${not empty todayBookings}">
                    <!-- Morning Shift (8:00 - 12:00) -->
                    <div class="time-slot">
                        <h5 class="time-indicator mb-3">
                            <i class="bi bi-sunrise"></i> Ca sáng (8:00 - 12:00)
                        </h5>
                        
                        <c:set var="morningBookings" value="" />
                        <c:forEach items="${todayBookings}" var="booking">
                            <c:if test="${booking.shift.startTime.hours >= 8 && booking.shift.startTime.hours < 12}">
                                <c:set var="morningBookings" value="${morningBookings}1" />
                                <div class="booking-card">
                                    <div class="row align-items-center">
                                        <div class="col-md-3">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" 
                                                     style="width: 40px; height: 40px;">
                                                    <i class="bi bi-person"></i>
                                                </div>
                                                <div>
                                                    <strong>${booking.user.fullName}</strong>
                                                    <br>
                                                    <small class="text-muted">${booking.user.email}</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <span class="badge bg-info">
                                                <i class="bi bi-scissors"></i>
                                                ${booking.service.name}
                                            </span>
                                        </div>
                                        <div class="col-md-2">
                                            <i class="bi bi-clock"></i>
                                            <strong>${booking.shift.startTime} - ${booking.shift.endTime}</strong>
                                        </div>
                                        <div class="col-md-2">
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
                                        </div>
                                        <div class="col-md-3">
                                            <div class="btn-group btn-group-sm">
                                                <c:if test="${booking.status == 'Pending'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Confirmed')">
                                                        <i class="bi bi-check"></i> Xác nhận
                                                    </button>
                                                </c:if>
                                                <c:if test="${booking.status == 'Confirmed'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Completed')">
                                                        <i class="bi bi-check-circle"></i> Hoàn thành
                                                    </button>
                                                </c:if>
                                                <button class="btn btn-info btn-sm" onclick="viewDetails(${booking.bookingId})">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${empty morningBookings}">
                            <div class="empty-slot">
                                <i class="bi bi-clock" style="font-size: 2rem;"></i>
                                <p class="mt-2 mb-0">Không có lịch hẹn ca sáng</p>
                            </div>
                        </c:if>
                    </div>

                    <!-- Afternoon Shift (12:00 - 17:00) -->
                    <div class="time-slot">
                        <h5 class="time-indicator mb-3">
                            <i class="bi bi-sun"></i> Ca chiều (12:00 - 17:00)
                        </h5>
                        
                        <c:set var="afternoonBookings" value="" />
                        <c:forEach items="${todayBookings}" var="booking">
                            <c:if test="${booking.shift.startTime.hours >= 12 && booking.shift.startTime.hours < 17}">
                                <c:set var="afternoonBookings" value="${afternoonBookings}1" />
                                <div class="booking-card">
                                    <div class="row align-items-center">
                                        <div class="col-md-3">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" 
                                                     style="width: 40px; height: 40px;">
                                                    <i class="bi bi-person"></i>
                                                </div>
                                                <div>
                                                    <strong>${booking.user.fullName}</strong>
                                                    <br>
                                                    <small class="text-muted">${booking.user.email}</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <span class="badge bg-info">
                                                <i class="bi bi-scissors"></i>
                                                ${booking.service.name}
                                            </span>
                                        </div>
                                        <div class="col-md-2">
                                            <i class="bi bi-clock"></i>
                                            <strong>${booking.shift.startTime} - ${booking.shift.endTime}</strong>
                                        </div>
                                        <div class="col-md-2">
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
                                        </div>
                                        <div class="col-md-3">
                                            <div class="btn-group btn-group-sm">
                                                <c:if test="${booking.status == 'Pending'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Confirmed')">
                                                        <i class="bi bi-check"></i> Xác nhận
                                                    </button>
                                                </c:if>
                                                <c:if test="${booking.status == 'Confirmed'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Completed')">
                                                        <i class="bi bi-check-circle"></i> Hoàn thành
                                                    </button>
                                                </c:if>
                                                <button class="btn btn-info btn-sm" onclick="viewDetails(${booking.bookingId})">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${empty afternoonBookings}">
                            <div class="empty-slot">
                                <i class="bi bi-clock" style="font-size: 2rem;"></i>
                                <p class="mt-2 mb-0">Không có lịch hẹn ca chiều</p>
                            </div>
                        </c:if>
                    </div>

                    <!-- Evening Shift (17:00 - 21:00) -->
                    <div class="time-slot">
                        <h5 class="time-indicator mb-3">
                            <i class="bi bi-moon"></i> Ca tối (17:00 - 21:00)
                        </h5>
                        
                        <c:set var="eveningBookings" value="" />
                        <c:forEach items="${todayBookings}" var="booking">
                            <c:if test="${booking.shift.startTime.hours >= 17 && booking.shift.startTime.hours < 21}">
                                <c:set var="eveningBookings" value="${eveningBookings}1" />
                                <div class="booking-card">
                                    <div class="row align-items-center">
                                        <div class="col-md-3">
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" 
                                                     style="width: 40px; height: 40px;">
                                                    <i class="bi bi-person"></i>
                                                </div>
                                                <div>
                                                    <strong>${booking.user.fullName}</strong>
                                                    <br>
                                                    <small class="text-muted">${booking.user.email}</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <span class="badge bg-info">
                                                <i class="bi bi-scissors"></i>
                                                ${booking.service.name}
                                            </span>
                                        </div>
                                        <div class="col-md-2">
                                            <i class="bi bi-clock"></i>
                                            <strong>${booking.shift.startTime} - ${booking.shift.endTime}</strong>
                                        </div>
                                        <div class="col-md-2">
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
                                        </div>
                                        <div class="col-md-3">
                                            <div class="btn-group btn-group-sm">
                                                <c:if test="${booking.status == 'Pending'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Confirmed')">
                                                        <i class="bi bi-check"></i> Xác nhận
                                                    </button>
                                                </c:if>
                                                <c:if test="${booking.status == 'Confirmed'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Completed')">
                                                        <i class="bi bi-check-circle"></i> Hoàn thành
                                                    </button>
                                                </c:if>
                                                <button class="btn btn-info btn-sm" onclick="viewDetails(${booking.bookingId})">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${empty eveningBookings}">
                            <div class="empty-slot">
                                <i class="bi bi-clock" style="font-size: 2rem;"></i>
                                <p class="mt-2 mb-0">Không có lịch hẹn ca tối</p>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Đã xóa modal và form xin nghỉ liên quan đến StaffDayOffController ở đây -->

    <!-- Bootstrap JS -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function updateStatus(bookingId, status) {
            if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'StaffDashboardController';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'updateStatus';
                form.appendChild(actionInput);
                
                const bookingInput = document.createElement('input');
                bookingInput.type = 'hidden';
                bookingInput.name = 'bookingId';
                bookingInput.value = bookingId;
                form.appendChild(bookingInput);
                
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = status;
                form.appendChild(statusInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function viewDetails(bookingId) {
            alert('Chi tiết lịch hẹn ID: ' + bookingId);
        }
        
        // Update status counts
        function updateCounts() {
            let pendingCount = 0;
            let confirmedCount = 0;
            let completedCount = 0;
            
            document.querySelectorAll('.status-badge').forEach(badge => {
                const status = badge.textContent.trim();
                if (status === 'Pending') pendingCount++;
                else if (status === 'Confirmed') confirmedCount++;
                else if (status === 'Completed') completedCount++;
            });
            
            document.getElementById('pendingCount').textContent = pendingCount;
            document.getElementById('confirmedCount').textContent = confirmedCount;
            document.getElementById('completedCount').textContent = completedCount;
        }
        
        // Initialize counts on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateCounts();
        });
        
        // Auto refresh every 2 minutes
        setTimeout(function() {
            location.reload();
        }, 120000);
    </script>
</body>
</html> 