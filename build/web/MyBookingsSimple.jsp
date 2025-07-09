<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lịch Hẹn Của Tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .booking-card {
            background: rgba(255,255,255,0.97);
            border-radius: 18px;
            box-shadow: 0 8px 32px 0 rgba(31,38,135,0.15);
            margin-bottom: 1.5rem;
        }
        .badge-status {
            font-size: 1em;
            padding: 0.5em 1em;
            border-radius: 1em;
        }
        .no-booking {
            background: rgba(255,255,255,0.8);
            border-radius: 18px;
            padding: 2rem;
            text-align: center;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-primary"><i class="bi bi-list-ul me-2"></i>Lịch Hẹn Của Tôi</h2>
                <div>
                    <a href="BookingController" class="btn btn-outline-primary me-2">
                        <i class="bi bi-calendar-plus me-1"></i>Đặt Lịch Mới
                    </a>
                    <a href="home" class="btn btn-outline-secondary">
                        <i class="bi bi-house me-1"></i>Về Trang Chủ
                    </a>
                </div>
            </div>
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="no-booking">
                        <i class="bi bi-calendar-x display-4 text-secondary mb-3"></i>
                        <h4 class="mb-2">Bạn chưa có lịch hẹn nào!</h4>
                        <p>Nhấn <b>Đặt Lịch Mới</b> để tạo lịch hẹn đầu tiên.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <c:forEach var="booking" items="${bookings}">
                            <div class="col-md-6">
                                <div class="card booking-card mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h5 class="card-title mb-0">
                                                <i class="bi bi-scissors me-2"></i>${booking.service.name}
                                            </h5>
                                            <span class="badge badge-status
                                                <c:choose>
                                                    <c:when test='${booking.status eq "Pending"}'>bg-warning text-dark</c:when>
                                                    <c:when test='${booking.status eq "Confirmed"}'>bg-success</c:when>
                                                    <c:when test='${booking.status eq "Completed"}'>bg-primary</c:when>
                                                    <c:when test='${booking.status eq "Canceled"}'>bg-danger</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>'>
                                                <i class="bi bi-circle-fill me-1" style="font-size:0.7em;"></i>
                                                <c:choose>
                                                    <c:when test='${booking.status eq "Pending"}'>Chờ Xác Nhận</c:when>
                                                    <c:when test='${booking.status eq "Confirmed"}'>Đã Xác Nhận</c:when>
                                                    <c:when test='${booking.status eq "Completed"}'>Hoàn Thành</c:when>
                                                    <c:when test='${booking.status eq "Canceled"}'>Đã Hủy</c:when>
                                                    <c:otherwise>${booking.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="mb-2">
                                            <i class="bi bi-person me-1"></i>
                                            <b>Thợ Cắt:</b> ${booking.staff.staffName}
                                        </div>
                                        <div class="mb-2">
                                            <i class="bi bi-calendar-event me-1"></i>
                                            <b>Ngày:</b> ${booking.bookingDate}
                                        </div>
                                        <div class="mb-2">
                                            <i class="bi bi-clock me-1"></i>
                                            <b>Giờ:</b> ${booking.shift.startTime} - ${booking.shift.endTime}
                                        </div>
                                        <c:if test="${not empty booking.note}">
                                            <div class="mb-2">
                                                <i class="bi bi-chat-text me-1"></i>
                                                <b>Ghi Chú:</b> ${booking.note}
                                            </div>
                                        </c:if>
                                        <c:if test="${booking.status eq 'Pending' || booking.status eq 'Confirmed'}">
                                            <form method="post" action="BookingController" onsubmit="return confirm('Bạn có chắc muốn hủy lịch hẹn này?');">
                                                <input type="hidden" name="action" value="cancel" />
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <button type="submit" class="btn btn-danger btn-sm mt-2">
                                                    <i class="bi bi-x-circle"></i> Hủy lịch
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="mt-4 text-center">
                <a href="home" class="btn btn-outline-secondary">
                    <i class="bi bi-house me-1"></i>Về Trang Chủ
                </a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 