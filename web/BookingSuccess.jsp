<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đặt Lịch Thành Công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .success-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        .success-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(45deg, #28a745, #20c997);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .btn-custom {
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card success-card">
                    <div class="card-body text-center p-5">
                        <div class="success-icon">
                            <i class="bi bi-check-circle-fill text-white" style="font-size: 2.5rem;"></i>
                        </div>
                        
                        <h2 class="card-title text-success mb-4">Đặt Lịch Thành Công!</h2>
                        
                        <c:if test="${not empty success}">
                            <div class="alert alert-success border-0 bg-success bg-opacity-10">
                                <i class="bi bi-info-circle me-2"></i>
                                ${success}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty warning}">
                            <div class="alert alert-warning border-0 bg-warning bg-opacity-10">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                ${warning}
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger border-0 bg-danger bg-opacity-10">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                ${error}
                            </div>
                        </c:if>
                        
                        <div class="row mt-4">
                            <div class="col-md-6 mb-3">
                                <a href="BookingController" class="btn btn-primary btn-custom w-100">
                                    <i class="bi bi-calendar-plus me-2"></i>
                                    Đặt Lịch Khác
                                </a>
                            </div>
                            <div class="col-md-6 mb-3">
                                <a href="BookingController?action=list" class="btn btn-outline-primary btn-custom w-100">
                                    <i class="bi bi-list-ul me-2"></i>
                                    Xem Lịch Của Tôi
                                </a>
                            </div>
                        </div>
                        
                        <div class="mt-4">
                            <a href="home" class="btn btn-outline-secondary btn-custom">
                                <i class="bi bi-house me-2"></i>
                                Về Trang Chủ
                            </a>
                        </div>
                        
                        <div class="mt-4 text-muted">
                            <small>
                                <i class="bi bi-clock me-1"></i>
                                Bạn sẽ nhận được email xác nhận trong thời gian ngắn.
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 