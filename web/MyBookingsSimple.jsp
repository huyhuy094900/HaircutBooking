<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Hẹn Của Tôi - HaircutBooking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }

        body {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--dark-color);
        }

        .main-container {
            padding: 2rem 0;
        }

        .header-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .page-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 0;
            font-size: 2.5rem;
        }

        .stats-card {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stats-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .booking-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: none;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
        }

        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .booking-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .card-header-custom {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
        }

        .service-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: linear-gradient(135deg, var(--warning-color), #ffb74d);
            color: #fff;
        }

        .status-confirmed {
            background: linear-gradient(135deg, var(--success-color), #4caf50);
            color: #fff;
        }

        .status-completed {
            background: linear-gradient(135deg, var(--info-color), #2196f3);
            color: #fff;
        }

        .status-canceled {
            background: linear-gradient(135deg, var(--danger-color), #f44336);
            color: #fff;
        }

        .booking-info {
            padding: 1.5rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem;
            background: rgba(248, 249, 250, 0.5);
            border-radius: 10px;
            transition: background 0.3s ease;
        }

        .info-item:hover {
            background: rgba(248, 249, 250, 0.8);
        }

        .info-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-size: 1.1rem;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0;
        }

        .action-buttons {
            padding: 1.5rem;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            background: rgba(248, 249, 250, 0.3);
        }

        .btn-custom {
            border-radius: 25px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-cancel {
            background: linear-gradient(135deg, var(--danger-color), #f44336);
            color: white;
        }

        .btn-cancel:hover {
            background: linear-gradient(135deg, #c82333, #e53935);
            color: white;
            transform: translateY(-2px);
        }

        .empty-state {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 4rem 2rem;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .empty-icon {
            font-size: 5rem;
            color: var(--primary-color);
            margin-bottom: 2rem;
            opacity: 0.7;
        }

        .empty-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .empty-description {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 2rem;
        }

        .floating-action {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            z-index: 1000;
        }

        .btn-floating {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .btn-floating:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.4);
            color: white;
        }

        .filter-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .filter-btn {
            border-radius: 20px;
            padding: 0.5rem 1.5rem;
            margin: 0.25rem;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            font-weight: 600;
        }

        .filter-btn.active {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-color: var(--primary-color);
        }

        .filter-btn:not(.active) {
            background: transparent;
            color: var(--dark-color);
            border-color: #dee2e6;
        }

        .filter-btn:not(.active):hover {
            background: rgba(102, 126, 234, 0.1);
            border-color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .stats-card {
                margin-bottom: 1rem;
            }
            
            .booking-card {
                margin-bottom: 1.5rem;
            }
        }

        .animate-fade-in {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="container">
            <!-- Header Section -->
            <div class="header-section animate-fade-in">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="page-title">
                            <i class="bi bi-calendar-check me-3"></i>
                            Lịch Hẹn Của Tôi
                        </h1>
                        <p class="text-muted mb-0">Quản lý và theo dõi tất cả lịch hẹn của bạn</p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <a href="BookingController" class="btn btn-custom btn-primary me-2">
                            <i class="bi bi-plus-circle me-2"></i>Đặt Lịch Mới
                        </a>
                        <a href="home" class="btn btn-custom btn-outline-secondary">
                            <i class="bi bi-house me-2"></i>Trang Chủ
                        </a>
                    </div>
                </div>
            </div>

            <!-- Statistics Section -->
            <div class="row mb-4 animate-fade-in" style="animation-delay: 0.2s;">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-number">${bookings.size()}</div>
                        <div class="stats-label">Tổng Lịch Hẹn</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-number">
                            <c:set var="confirmedCount" value="0"/>
                            <c:forEach var="booking" items="${bookings}">
                                <c:if test="${booking.status eq 'Confirmed'}">
                                    <c:set var="confirmedCount" value="${confirmedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${confirmedCount}
                        </div>
                        <div class="stats-label">Đã Xác Nhận</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-number">
                            <c:set var="pendingCount" value="0"/>
                            <c:forEach var="booking" items="${bookings}">
                                <c:if test="${booking.status eq 'Pending'}">
                                    <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${pendingCount}
                        </div>
                        <div class="stats-label">Chờ Xác Nhận</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="stats-card">
                        <div class="stats-number">
                            <c:set var="completedCount" value="0"/>
                            <c:forEach var="booking" items="${bookings}">
                                <c:if test="${booking.status eq 'Completed'}">
                                    <c:set var="completedCount" value="${completedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${completedCount}
                        </div>
                        <div class="stats-label">Hoàn Thành</div>
                    </div>
                </div>
            </div>

            <!-- Filter Section -->
            <c:if test="${not empty bookings}">
                <div class="filter-section animate-fade-in" style="animation-delay: 0.4s;">
                    <h6 class="mb-3"><i class="bi bi-funnel me-2"></i>Lọc theo trạng thái:</h6>
                    <button class="filter-btn active" data-filter="all">Tất cả</button>
                    <button class="filter-btn" data-filter="Pending">Chờ xác nhận</button>
                    <button class="filter-btn" data-filter="Confirmed">Đã xác nhận</button>
                    <button class="filter-btn" data-filter="Completed">Hoàn thành</button>
                    <button class="filter-btn" data-filter="Canceled">Đã hủy</button>
                </div>
            </c:if>

            <!-- Bookings List -->
            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="empty-state animate-fade-in" style="animation-delay: 0.6s;">
                        <div class="empty-icon">
                            <i class="bi bi-calendar-x"></i>
                        </div>
                        <h2 class="empty-title">Bạn chưa có lịch hẹn nào!</h2>
                        <p class="empty-description">
                            Hãy đặt lịch hẹn đầu tiên để trải nghiệm dịch vụ của chúng tôi.
                        </p>
                        <a href="BookingController" class="btn btn-custom btn-primary btn-lg">
                            <i class="bi bi-plus-circle me-2"></i>Đặt Lịch Ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row" id="bookingsContainer">
                        <c:forEach var="booking" items="${bookings}" varStatus="status">
                            <div class="col-lg-6 col-xl-4 mb-4 booking-item" data-status="${booking.status}" 
                                 style="animation-delay: ${status.index * 0.1}s;">
                                <div class="card booking-card animate-fade-in">
                                    <div class="card-header-custom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h5 class="service-name">
                                                <i class="bi bi-scissors me-2"></i>${booking.service.name}
                                            </h5>
                                            <span class="status-badge status-${booking.status.toLowerCase()}">
                                                <i class="bi bi-circle-fill me-1"></i>
                                                <c:choose>
                                                    <c:when test='${booking.status eq "Pending"}'>Chờ Xác Nhận</c:when>
                                                    <c:when test='${booking.status eq "Confirmed"}'>Đã Xác Nhận</c:when>
                                                    <c:when test='${booking.status eq "Completed"}'>Hoàn Thành</c:when>
                                                    <c:when test='${booking.status eq "Canceled"}'>Đã Hủy</c:when>
                                                    <c:otherwise>${booking.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="booking-info">
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div class="info-content">
                                                <div class="info-label">Thợ cắt tóc</div>
                                                <div class="info-value">${booking.staff.staffName}</div>
                                            </div>
                                        </div>
                                        
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="bi bi-calendar-event"></i>
                                            </div>
                                            <div class="info-content">
                                                <div class="info-label">Ngày hẹn</div>
                                                <div class="info-value">
                                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="info-item">
                                            <div class="info-icon">
                                                <i class="bi bi-clock"></i>
                                            </div>
                                            <div class="info-content">
                                                <div class="info-label">Thời gian</div>
                                                <div class="info-value">${booking.shift.startTime} - ${booking.shift.endTime}</div>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${not empty booking.note}">
                                            <div class="info-item">
                                                <div class="info-icon">
                                                    <i class="bi bi-chat-text"></i>
                                                </div>
                                                <div class="info-content">
                                                    <div class="info-label">Ghi chú</div>
                                                    <div class="info-value">${booking.note}</div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <c:if test="${booking.status eq 'Pending' || booking.status eq 'Confirmed'}">
                                        <div class="action-buttons">
                                            <form method="post" action="BookingController" 
                                                  onsubmit="return confirmCancel('${booking.service.name}', '${booking.bookingDate}')">
                                                <input type="hidden" name="action" value="cancel" />
                                                <input type="hidden" name="bookingId" value="${booking.bookingId}" />
                                                <button type="submit" class="btn btn-custom btn-cancel w-100">
                                                    <i class="bi bi-x-circle me-2"></i>Hủy Lịch Hẹn
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Floating Action Button -->
    <div class="floating-action">
        <a href="BookingController" class="btn btn-floating" title="Đặt lịch mới">
            <i class="bi bi-plus"></i>
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filter functionality
        document.addEventListener('DOMContentLoaded', function() {
            const filterBtns = document.querySelectorAll('.filter-btn');
            const bookingItems = document.querySelectorAll('.booking-item');

            filterBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const filter = this.getAttribute('data-filter');
                    
                    // Update active button
                    filterBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Filter items
                    bookingItems.forEach(item => {
                        if (filter === 'all' || item.getAttribute('data-status') === filter) {
                            item.style.display = 'block';
                            item.classList.add('animate-fade-in');
                        } else {
                            item.style.display = 'none';
                        }
                    });
                });
            });
        });

        // Enhanced cancel confirmation
        function confirmCancel(serviceName, bookingDate) {
            return confirm(`Bạn có chắc muốn hủy lịch hẹn "${serviceName}" vào ngày ${bookingDate}?\n\nHành động này không thể hoàn tác.`);
        }

        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Add loading animation
        window.addEventListener('load', function() {
            document.body.classList.add('loaded');
        });
    </script>
</body>
</html> 