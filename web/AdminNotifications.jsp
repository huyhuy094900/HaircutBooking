<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý thông báo - Admin Dashboard</title>
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
        .notification-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s;
            border-left: 4px solid #667eea;
        }
        .notification-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        .notification-card.unread {
            border-left-color: #dc3545;
            background: linear-gradient(135deg, #fff 0%, #fff8f8 100%);
        }
        .notification-card.booking {
            border-left-color: #28a745;
        }
        .notification-card.system {
            border-left-color: #ffc107;
        }
        .notification-card.alert {
            border-left-color: #dc3545;
        }
        .notification-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 10px;
        }
        .notification-title {
            font-weight: bold;
            color: #333;
            margin: 0;
        }
        .notification-time {
            color: #666;
            font-size: 0.9rem;
        }
        .notification-message {
            color: #555;
            margin-bottom: 10px;
        }
        .notification-actions {
            display: flex;
            gap: 10px;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.8rem;
        }
        .top-bar {
            background: white;
            padding: 15px 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .stats-badge {
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
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
                        <a class="nav-link" href="admin">
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
                        <a class="nav-link active" href="NotificationController">
                            <i class="bi bi-bell"></i> Thông báo
                            <c:if test="${unreadCount > 0}">
                                <span class="badge bg-danger ms-2">${unreadCount}</span>
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
                            <h4 class="mb-0">
                                <i class="bi bi-bell"></i> Quản lý thông báo
                            </h4>
                            <small class="text-muted">Theo dõi và quản lý tất cả thông báo hệ thống</small>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="stats-badge">
                                <i class="bi bi-bell"></i> ${unreadCount} chưa đọc
                            </span>
                            <c:if test="${unreadCount > 0}">
                                <button class="btn btn-outline-primary btn-sm" onclick="markAllAsRead()">
                                    <i class="bi bi-check-all"></i> Đánh dấu tất cả đã đọc
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Notifications List -->
                <div class="row">
                    <div class="col-12">
                        <c:choose>
                            <c:when test="${empty notifications}">
                                <div class="empty-state">
                                    <i class="bi bi-bell-slash"></i>
                                    <h5>Không có thông báo nào</h5>
                                    <p>Tất cả thông báo đã được xử lý hoặc chưa có thông báo mới.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="notification" items="${notifications}">
                                    <div class="notification-card ${notification.status == 'unread' ? 'unread' : ''} ${notification.type}">
                                        <div class="notification-header">
                                            <h6 class="notification-title">
                                                <i class="bi bi-${notification.type == 'booking' ? 'calendar-check' : notification.type == 'system' ? 'gear' : 'exclamation-triangle'}"></i>
                                                ${notification.title}
                                            </h6>
                                            <span class="notification-time">${notification.timeAgo}</span>
                                        </div>
                                        <div class="notification-message">
                                            ${notification.message}
                                        </div>
                                        <c:if test="${notification.relatedBooking != null}">
                                            <div class="alert alert-info py-2 px-3 mb-3">
                                                <small>
                                                    <strong>Thông tin đặt lịch:</strong><br>
                                                    ID đặt lịch: ${notification.relatedBooking.bookingId}<br>
                                                    Ngày: ${notification.relatedBooking.bookingDate}<br>
                                                    Trạng thái: 
                                                    <span class="badge bg-${notification.relatedBooking.status == 'Pending' ? 'warning' : notification.relatedBooking.status == 'Confirmed' ? 'success' : 'secondary'}">
                                                        ${notification.relatedBooking.status}
                                                    </span>
                                                </small>
                                            </div>
                                        </c:if>
                                        <div class="notification-actions">
                                            <c:if test="${notification.status == 'unread'}">
                                                <button class="btn btn-success btn-sm" onclick="markAsRead(${notification.notificationId})">
                                                    <i class="bi bi-check"></i> Đã đọc
                                                </button>
                                            </c:if>
                                            <c:if test="${notification.relatedBookingId > 0}">
                                                <a href="admin?action=bookings&bookingId=${notification.relatedBookingId}" class="btn btn-primary btn-sm">
                                                    <i class="bi bi-eye"></i> Xem chi tiết
                                                </a>
                                            </c:if>
                                            <button class="btn btn-danger btn-sm" onclick="deleteNotification(${notification.notificationId})">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        function markAsRead(notificationId) {
            fetch('NotificationController?action=markAsRead&notificationId=' + notificationId)
                .then(response => response.text())
                .then(result => {
                    if (result === 'success') {
                        location.reload();
                    } else {
                        alert('Có lỗi xảy ra khi đánh dấu đã đọc');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra');
                });
        }

        function markAllAsRead() {
            if (confirm('Bạn có chắc muốn đánh dấu tất cả thông báo đã đọc?')) {
                fetch('NotificationController?action=markAllAsRead')
                    .then(response => response.text())
                    .then(result => {
                        if (result === 'success') {
                            location.reload();
                        } else {
                            alert('Có lỗi xảy ra khi đánh dấu tất cả đã đọc');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra');
                    });
            }
        }

        function deleteNotification(notificationId) {
            if (confirm('Bạn có chắc muốn xóa thông báo này?')) {
                fetch('NotificationController?action=delete&notificationId=' + notificationId)
                    .then(response => response.text())
                    .then(result => {
                        if (result === 'success') {
                            location.reload();
                        } else {
                            alert('Có lỗi xảy ra khi xóa thông báo');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra');
                    });
            }
        }

        // Auto refresh notifications every 30 seconds
        setInterval(function() {
            fetch('NotificationController?action=getUnreadCount')
                .then(response => response.text())
                .then(count => {
                    const badge = document.querySelector('.badge');
                    if (badge) {
                        if (count > 0) {
                            badge.textContent = count;
                            badge.style.display = 'inline';
                        } else {
                            badge.style.display = 'none';
                        }
                    }
                })
                .catch(error => console.error('Error updating notification count:', error));
        }, 30000);
    </script>
</body>
</html> 