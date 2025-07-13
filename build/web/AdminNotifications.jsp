<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý thông báo - Admin</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .notification-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            margin-bottom: 18px;
            padding: 20px 24px;
            border-left: 5px solid #667eea;
            transition: box-shadow 0.2s;
        }
        .notification-card.unread { border-left-color: #dc3545; background: #fff8f8; }
        .notification-title { font-weight: bold; font-size: 1.1rem; color: #333; }
        .notification-time { color: #888; font-size: 0.95rem; }
        .notification-content { color: #444; margin: 8px 0 12px 0; }
        .notification-actions { display: flex; gap: 10px; }
        .booking-info { background: #f1f3fa; border-radius: 8px; padding: 10px 14px; margin-bottom: 10px; font-size: 0.97rem; }
        .empty-state { text-align: center; color: #aaa; margin: 60px 0; }
    </style>
</head>
<body>
<div class="container py-4">
    <h2 class="mb-4"><i class="bi bi-bell"></i> Quản lý thông báo gửi cho khách hàng</h2>
                            <c:if test="${unreadCount > 0}">
        <div class="alert alert-info mb-4">
            <i class="bi bi-info-circle"></i> Có <b>${unreadCount}</b> thông báo chưa đọc.
                        </div>
                            </c:if>
                        <c:choose>
                            <c:when test="${empty notifications}">
                                <div class="empty-state">
                <i class="bi bi-bell-slash" style="font-size:3rem;"></i>
                <div>Không có thông báo nào.</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="notification" items="${notifications}">
                <div class="notification-card ${notification.status == 'unread' ? 'unread' : ''}">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <span class="notification-title">
                            <i class="bi bi-${notification.type == 'alert' ? 'exclamation-triangle' : (notification.type == 'appointment' ? 'calendar-check' : 'info-circle')}"></i>
                                                ${notification.title}
                        </span>
                        <span class="notification-time">
                            <c:out value="${notification.createdAt}"/>
                        </span>
                                        </div>
                    <div class="notification-content">
                        ${notification.content}
                                        </div>
                                        <c:if test="${notification.relatedBooking != null}">
                        <div class="booking-info">
                            <b>Thông tin đặt lịch:</b><br>
                            Mã: ${notification.relatedBooking.bookingId} | Ngày: ${notification.relatedBooking.bookingDate} | Trạng thái: ${notification.relatedBooking.status}
                                            </div>
                                        </c:if>
                                        <div class="notification-actions">
                                            <c:if test="${notification.status == 'unread'}">
                                                <button class="btn btn-success btn-sm" onclick="markAsRead(${notification.notificationId})">
                                                    <i class="bi bi-check"></i> Đã đọc
                                                </button>
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
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
function markAsRead(id) {
    fetch('NotificationController?action=markAsRead&notificationId=' + id)
        .then(r => r.text())
        .then(t => { if (t === 'success') location.reload(); });
}
function deleteNotification(id) {
    if (confirm('Bạn chắc chắn muốn xóa thông báo này?')) {
        fetch('NotificationController?action=delete&notificationId=' + id)
            .then(r => r.text())
            .then(t => { if (t === 'success') location.reload(); });
    }
            }
    </script>
</body>
</html> 