<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách dịch vụ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .service-header {
            text-align: center;
            margin: 40px 0 30px 0;
        }
        .service-header h1 {
            font-weight: 700;
            color: #2c3e50;
            font-size: 2.5rem;
        }
        .service-header p {
            color: #6c757d;
            font-size: 1.1rem;
        }
        .service-card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(44,62,80,0.08);
            transition: transform 0.2s, box-shadow 0.2s;
            background: #fff;
        }
        .service-card:hover {
            transform: translateY(-6px) scale(1.03);
            box-shadow: 0 16px 40px rgba(44,62,80,0.15);
        }
        .service-icon {
            font-size: 2.5rem;
            color: #007bff;
            margin-bottom: 10px;
        }
        .service-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2c3e50;
        }
        .service-desc {
            color: #6c757d;
            font-size: 1rem;
            min-height: 48px;
        }
        .service-meta {
            margin: 15px 0 10px 0;
            display: flex;
            gap: 18px;
            font-size: 0.98rem;
        }
        .service-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #495057;
        }
        .service-price {
            font-weight: bold;
            color: #28a745;
            font-size: 1.1rem;
        }
        .btn-book {
            background: linear-gradient(90deg, #007bff, #00c6ff);
            color: #fff;
            border: none;
            border-radius: 25px;
            padding: 10px 28px;
            font-weight: 600;
            font-size: 1rem;
            transition: background 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 16px rgba(0,123,255,0.08);
        }
        .btn-book:hover {
            background: linear-gradient(90deg, #0056b3, #007bff);
            color: #fff;
            box-shadow: 0 8px 24px rgba(0,123,255,0.18);
        }
        .service-img img {
            max-height: 220px;
            object-fit: cover;
            width: 100%;
            border-radius: 18px 18px 0 0;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 16px rgba(44,62,80,0.08);
        }
        .service-img img:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 32px rgba(44,62,80,0.18);
        }
        @media (max-width: 768px) {
            .service-header h1 { font-size: 2rem; }
            .service-card { margin-bottom: 20px; }
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="home">
                <i class="bi bi-scissors me-2"></i>HaircutBooking
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="list_service">Dịch vụ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="BookingController">Đặt lịch</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.user and not sessionScope.user.admin}">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="list_service">Dịch vụ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="BookingController">Đặt lịch</a>
                        </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i>
                                ${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'User'}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="logout">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                        <c:if test="${sessionScope.user.admin}">
                            <li class="nav-item">
                                <a class="nav-link" href="AdminDashboardController">
                                    <i class="bi bi-gear me-1"></i>Admin
                                </a>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="btn btn-primary" href="Login.jsp">Đăng nhập</a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Back Button -->
    <button class="back-btn" onclick="window.location.href='home'" title="Quay lại trang chủ">
        <i class="bi bi-arrow-left"></i>
    </button>
    
    <!-- Header -->
    <div class="service-header">
        <h1><i class="bi bi-stars"></i> Danh sách dịch vụ</h1>
        <p>Chọn dịch vụ bạn muốn và đặt lịch ngay!</p>
    </div>
    
    <div class="container mt-4">
        <div class="row g-4">
            <c:choose>
                <c:when test="${empty services}">
                    <div class="col-12">
                        <div class="alert alert-warning text-center">Hiện chưa có dịch vụ nào.</div>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="service" items="${services}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card service-card h-100 p-0 overflow-hidden">
                                <div class="service-img text-center" style="background:#f8f9fa;">
                                    <img src="${pageContext.request.contextPath}/assets/img/${service.image}"
                                         alt="${service.name}"
                                         class="img-fluid"
                                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/img/default-service.jpg';">
                                        </div>
                                <div class="card-body d-flex flex-column justify-content-between align-items-center">
                                    <div class="service-title mb-2 text-center" style="font-size:1.3rem;font-weight:600;color:#2c3e50;">${service.name}</div>
                                    <div class="service-desc mb-3 text-center" style="color:#6c757d;font-size:1rem;min-height:48px;">${service.description}</div>
                                    <div class="service-meta d-flex flex-column align-items-center mb-2">
                                        <span style="color:#495057;"><i class="bi bi-clock"></i> ${service.duration} phút</span>
                                        <span class="service-price mt-2" style="font-weight:bold;color:#212529;font-size:1.2rem;">Giá tiêu chuẩn<br><fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" /> VND</span>
                                    </div>
                                    <a href="BookingController" class="btn btn-book w-100 mt-2" style="background:linear-gradient(90deg,#007bff,#00c6ff);color:#fff;font-weight:600;font-size:1rem;border-radius:25px;">
                                        <i class="bi bi-calendar-check me-1"></i>Chọn
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">
                <i class="bi bi-exclamation-triangle me-2"></i>
                ${error}
            </div>
        </c:if>
    </div>
    
    <%@include file="FooterInclude.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
