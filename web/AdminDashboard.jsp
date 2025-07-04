<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - HaircutBooking</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            position: fixed;
            width: 250px;
            z-index: 1000;
        }
        .sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 15px 20px;
            border-radius: 0;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }
        .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left-color: #fff;
        }
        .sidebar .nav-link.active {
            background: rgba(255,255,255,0.2);
            color: white;
            border-left-color: #fff;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            background: #f8f9fa;
            min-height: 100vh;
        }
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            border-left: 4px solid;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .stats-card.users { border-left-color: #667eea; }
        .stats-card.services { border-left-color: #28a745; }
        .stats-card.staff { border-left-color: #ffc107; }
        .stats-card.bookings { border-left-color: #dc3545; }
        .stats-card.pending { border-left-color: #fd7e14; }
        .stats-card.revenue { border-left-color: #6f42c1; }
        
        .stats-card h3 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .stats-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .stats-card.users .stats-icon { color: #667eea; }
        .stats-card.services .stats-icon { color: #28a745; }
        .stats-card.staff .stats-icon { color: #ffc107; }
        .stats-card.bookings .stats-icon { color: #dc3545; }
        .stats-card.pending .stats-icon { color: #fd7e14; }
        .stats-card.revenue .stats-icon { color: #6f42c1; }
        
        .table-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .top-bar {
            background: white;
            padding: 15px 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .welcome-text {
            color: #667eea;
            font-weight: bold;
        }
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .activity-item {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
        .activity-item:last-child {
            border-bottom: none;
        }
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: white;
            font-size: 1.2rem;
        }
        .activity-icon.booking { background: #dc3545; }
        .activity-icon.user { background: #667eea; }
        .activity-icon.service { background: #28a745; }
        .activity-icon.staff { background: #ffc107; }
        
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="p-4">
                    <h4 class="text-center mb-4">
                        <i class="bi bi-shield-check"></i> Admin Panel
                    </h4>
                    <nav class="nav flex-column">
                        <a class="nav-link active" href="#dashboard" data-bs-toggle="tab">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                        <a class="nav-link" href="admin?action=users">
                            <i class="bi bi-people"></i> Quản lý người dùng
                        </a>
                        <a class="nav-link" href="admin?action=services">
                            <i class="bi bi-scissors"></i> Quản lý dịch vụ
                        </a>
                        <a class="nav-link" href="admin?action=staff">
                            <i class="bi bi-person-badge"></i> Quản lý nhân viên
                        </a>
                        <a class="nav-link" href="admin?action=bookings">
                            <i class="bi bi-calendar-check"></i> Quản lý đặt lịch
                        </a>
                        <a class="nav-link" href="NotificationController">
                            <i class="bi bi-bell"></i> Thông báo
                            <c:if test="${unreadNotificationCount > 0}">
                                <span class="badge bg-danger ms-2">${unreadNotificationCount}</span>
                            </c:if>
                        </a>
                        <hr style="border-color: rgba(255,255,255,0.3);">
                        <a class="nav-link" href="logout">
                            <i class="bi bi-box-arrow-right"></i> Đăng xuất
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Top Bar -->
                <div class="top-bar">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="welcome-text mb-0">
                                <i class="bi bi-person-circle"></i> Chào mừng, ${sessionScope.user.fullName}!
                            </h4>
                            <small class="text-muted">Bạn đang đăng nhập với quyền Administrator</small>
                        </div>
                        <div>
                            <span class="badge bg-success">Online</span>
                        </div>
                    </div>
                </div>

                <div class="tab-content">
                    <!-- Dashboard Tab -->
                    <div class="tab-pane fade show active" id="dashboard">
                        <h2 class="mb-4">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </h2>
                        
                        <!-- Quick Stats -->
                        <div class="quick-stats">
                            <div class="stats-card users text-center">
                                <i class="bi bi-people stats-icon"></i>
                                <h3>${userCount}</h3>
                                <p class="text-muted">Người dùng</p>
                            </div>
                            <div class="stats-card services text-center">
                                <i class="bi bi-scissors stats-icon"></i>
                                <h3>${serviceCount}</h3>
                                <p class="text-muted">Dịch vụ</p>
                            </div>
                            <div class="stats-card staff text-center">
                                <i class="bi bi-person-badge stats-icon"></i>
                                <h3>${staffCount}</h3>
                                <p class="text-muted">Nhân viên</p>
                            </div>
                            <div class="stats-card bookings text-center">
                                <i class="bi bi-calendar-check stats-icon"></i>
                                <h3>${bookingCount}</h3>
                                <p class="text-muted">Đặt lịch</p>
                            </div>
                        </div>

                        <!-- Additional Stats Row -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="stats-card pending text-center">
                                    <i class="bi bi-clock stats-icon"></i>
                                    <h3>${pendingBookings}</h3>
                                    <p class="text-muted">Đặt lịch chờ xác nhận</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="stats-card revenue text-center">
                                    <i class="bi bi-currency-dollar stats-icon"></i>
                                    <h3>$${totalRevenue}</h3>
                                    <p class="text-muted">Doanh thu tháng này</p>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Activity & Charts Row -->
                        <div class="row">
                            <div class="col-md-8">
                                <div class="recent-activity">
                                    <h4 class="mb-4">
                                        <i class="bi bi-activity"></i> Hoạt động gần đây
                                    </h4>
                                    <div class="activity-item">
                                        <div class="activity-icon booking">
                                            <i class="bi bi-calendar-plus"></i>
                                        </div>
                                        <div>
                                            <strong>Đặt lịch mới</strong>
                                            <p class="text-muted mb-0">Nguyễn Văn A đã đặt lịch cắt tóc nam</p>
                                            <small class="text-muted">2 phút trước</small>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon user">
                                            <i class="bi bi-person-plus"></i>
                                        </div>
                                        <div>
                                            <strong>Người dùng mới</strong>
                                            <p class="text-muted mb-0">Trần Thị B đã đăng ký tài khoản</p>
                                            <small class="text-muted">15 phút trước</small>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon service">
                                            <i class="bi bi-scissors"></i>
                                        </div>
                                        <div>
                                            <strong>Dịch vụ hoàn thành</strong>
                                            <p class="text-muted mb-0">Đặt lịch #123 đã hoàn thành</p>
                                            <small class="text-muted">1 giờ trước</small>
                                        </div>
                                    </div>
                                    <div class="activity-item">
                                        <div class="activity-icon staff">
                                            <i class="bi bi-person-badge"></i>
                                        </div>
                                        <div>
                                            <strong>Nhân viên mới</strong>
                                            <p class="text-muted mb-0">Lê Văn C đã được thêm vào hệ thống</p>
                                            <small class="text-muted">2 giờ trước</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="chart-container">
                                    <h4 class="mb-4">
                                        <i class="bi bi-pie-chart"></i> Thống kê nhanh
                                    </h4>
                                    <div class="text-center">
                                        <div class="mb-3">
                                            <h5 class="text-success">${completedBookings}</h5>
                                            <small class="text-muted">Hoàn thành hôm nay</small>
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-warning">${pendingBookings}</h5>
                                            <small class="text-muted">Chờ xác nhận</small>
                                        </div>
                                        <div class="mb-3">
                                            <h5 class="text-info">${activeUsers}</h5>
                                            <small class="text-muted">Người dùng hoạt động</small>
                                        </div>
                                        <div>
                                            <h5 class="text-primary">${availableStaff}</h5>
                                            <small class="text-muted">Nhân viên có sẵn</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Users Tab -->
                    <div class="tab-pane fade" id="users">
                        <h2 class="mb-4">
                            <i class="bi bi-people"></i> Quản lý người dùng
                        </h2>
                        <div class="table-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Danh sách người dùng</h4>
                                <a href="AdminDashboardController?action=users" class="btn btn-primary">
                                    <i class="bi bi-people"></i> Xem tất cả
                                </a>
                            </div>
                            <p class="text-muted">Quản lý tài khoản người dùng, ban/unban, xem thông tin chi tiết.</p>
                            
                            <!-- Recent Users Table -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${recentUsers}" var="user" varStatus="loop">
                                            <c:if test="${loop.index < 5}">
                                                <tr>
                                                    <td>${user.userId}</td>
                                                    <td>${user.fullName}</td>
                                                    <td>${user.email}</td>
                                                    <td>
                                                        <span class="badge ${user.admin ? 'bg-primary' : 'bg-secondary'}">
                                                            ${user.admin ? 'Admin' : 'User'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge ${user.userStatus ? 'bg-success' : 'bg-danger'}">
                                                            ${user.userStatus ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a href="user_detail_for_admin?userID=${user.userId}" 
                                                           class="btn btn-sm btn-info">
                                                            <i class="bi bi-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Services Tab -->
                    <div class="tab-pane fade" id="services">
                        <h2 class="mb-4">
                            <i class="bi bi-scissors"></i> Quản lý dịch vụ
                        </h2>
                        <div class="table-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Danh sách dịch vụ</h4>
                                <a href="AdminDashboardController?action=services" class="btn btn-success">
                                    <i class="bi bi-scissors"></i> Xem tất cả
                                </a>
                            </div>
                            <p class="text-muted">Quản lý các dịch vụ cắt tóc, giá cả, mô tả.</p>
                            
                            <!-- Recent Services Table -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên dịch vụ</th>
                                            <th>Giá</th>
                                            <th>Thời gian</th>
                                            <th>Status</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${recentServices}" var="service" varStatus="loop">
                                            <c:if test="${loop.index < 5}">
                                                <tr>
                                                    <td>${service.serviceId}</td>
                                                    <td>${service.name}</td>
                                                    <td>$${service.price}</td>
                                                    <td>${service.duration} phút</td>
                                                    <td>
                                                        <span class="badge ${service.serviceStatus ? 'bg-success' : 'bg-danger'}">
                                                            ${service.serviceStatus ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a href="service_detail?serviceId=${service.serviceId}" 
                                                           class="btn btn-sm btn-info">
                                                            <i class="bi bi-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Staff Tab -->
                    <div class="tab-pane fade" id="staff">
                        <h2 class="mb-4">
                            <i class="bi bi-person-badge"></i> Quản lý nhân viên
                        </h2>
                        <div class="table-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Danh sách nhân viên</h4>
                                <a href="AdminDashboardController?action=staff" class="btn btn-warning">
                                    <i class="bi bi-person-badge"></i> Quản lý nhân viên
                                </a>
                            </div>
                            <p class="text-muted">Quản lý thông tin nhân viên, lịch làm việc.</p>
                            
                            <!-- Recent Staff Table -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Status</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${recentStaff}" var="staff" varStatus="loop">
                                            <c:if test="${loop.index < 5}">
                                                <tr>
                                                    <td>${staff.staffId}</td>
                                                    <td>${staff.staffName}</td>
                                                    <td>${staff.staffEmail}</td>
                                                    <td>${staff.staffPhone}</td>
                                                    <td>
                                                        <span class="badge ${staff.staffStatus ? 'bg-success' : 'bg-danger'}">
                                                            ${staff.staffStatus ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a href="AdminSetupController" 
                                                           class="btn btn-sm btn-info">
                                                            <i class="bi bi-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Bookings Tab -->
                    <div class="tab-pane fade" id="bookings">
                        <h2 class="mb-4">
                            <i class="bi bi-calendar-check"></i> Quản lý đặt lịch
                        </h2>
                        <div class="table-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4>Danh sách đặt lịch</h4>
                                <a href="AdminDashboardController?action=bookings" class="btn btn-primary">
                                    <i class="bi bi-calendar-plus"></i> Xem tất cả
                                </a>
                            </div>
                            <p class="text-muted">Quản lý tất cả đặt lịch, xác nhận, hủy bỏ.</p>
                            
                            <!-- Recent Bookings Table -->
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>Khách hàng</th>
                                            <th>Dịch vụ</th>
                                            <th>Ngày</th>
                                            <th>Thời gian</th>
                                            <th>Status</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${recentBookings}" var="booking" varStatus="loop">
                                            <c:if test="${loop.index < 5}">
                                                <tr>
                                                    <td>${booking.bookingId}</td>
                                                    <td>${booking.user.fullName}</td>
                                                    <td>${booking.service.name}</td>
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
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <c:if test="${booking.status == 'Pending'}">
                                                                <a href="BookingController?action=confirm&bookingId=${booking.bookingId}" 
                                                                   class="btn btn-sm btn-success"
                                                                   onclick="return confirm('Xác nhận đặt lịch này?')">
                                                                    <i class="bi bi-check"></i>
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${booking.status == 'Confirmed'}">
                                                                <a href="BookingController?action=complete&bookingId=${booking.bookingId}" 
                                                                   class="btn btn-sm btn-info"
                                                                   onclick="return confirm('Hoàn thành đặt lịch này?')">
                                                                    <i class="bi bi-check-circle"></i>
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle active menu highlighting
        document.addEventListener('DOMContentLoaded', function() {
            // Get current URL to determine which menu should be active
            const currentUrl = window.location.href;
            const navLinks = document.querySelectorAll('.nav-link');
            
            // Remove active class from all links
            navLinks.forEach(link => link.classList.remove('active'));
            
            // Add active class based on current URL
            if (currentUrl.includes('action=users')) {
                document.querySelector('a[href="admin?action=users"]').classList.add('active');
            } else if (currentUrl.includes('action=services')) {
                document.querySelector('a[href="admin?action=services"]').classList.add('active');
            } else if (currentUrl.includes('action=staff')) {
                document.querySelector('a[href="admin?action=staff"]').classList.add('active');
            } else if (currentUrl.includes('action=bookings')) {
                document.querySelector('a[href="admin?action=bookings"]').classList.add('active');
            } else {
                // Default to dashboard
                document.querySelector('a[href="#dashboard"]').classList.add('active');
            }
        });
    </script>
</body>
</html> 