<%-- 
    Document   : Login
    Created on : Feb 13, 2025, 3:44:11 PM
    Author     : sontu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhập - Hệ Thống Đặt Lịch Cắt Tóc</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta name="description" content="Đăng nhập vào hệ thống đặt lịch cắt tóc chuyên nghiệp">
        <meta name="keywords" content="đăng nhập, login, haircut, booking">
        
        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
        
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        
        <!-- AOS Animation -->
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        
        <!-- Custom CSS -->
        <link href="assets/css/login.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .login-card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border: none;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            }
            .form-control {
                border-radius: 10px;
                border: 2px solid #e9ecef;
                transition: all 0.3s ease;
            }
            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }
            .btn-login {
                background: linear-gradient(45deg, #667eea, #764ba2);
                border: none;
                border-radius: 25px;
                padding: 12px 30px;
                font-weight: 600;
                transition: all 0.3s ease;
            }
            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }
        </style>
    </head>
    
    <body class="login-page">
        <!-- Background Animation -->
        <div class="background-animation">
            <div class="floating-shapes">
                <div class="shape shape-1"></div>
                <div class="shape shape-2"></div>
                <div class="shape shape-3"></div>
                <div class="shape shape-4"></div>
                <div class="shape shape-5"></div>
            </div>
        </div>

        <div class="container-fluid">
            <div class="row min-vh-100">
                <!-- Left Side - Login Form -->
                <div class="col-lg-6 col-md-12 d-flex align-items-center justify-content-center">
                    <div class="login-container" data-aos="fade-right">
                        <!-- Logo & Brand -->
                        <div class="text-center mb-5">
                            <div class="logo-container mb-4">
                                <i class="bi bi-scissors logo-icon"></i>
                            </div>
                            <h1 class="brand-title">HaircutBooking</h1>
                            <p class="brand-subtitle">Hệ thống đặt lịch cắt tóc chuyên nghiệp</p>
                        </div>

                        <!-- Login Form -->
                        <div class="login-form-container">
                            <div class="form-header mb-4">
                                <h2 class="form-title">Đăng Nhập</h2>
                                <p class="form-subtitle">Hệ Thống Đặt Lịch Cắt Tóc</p>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                    ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="bi bi-check-circle me-2"></i>
                                    ${success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="login" method="post" class="login-form" id="loginForm">
                                <!-- Email Field -->
                                <div class="form-group mb-4">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-envelope"></i>
                                        </span>
                                        <input type="email" 
                                               class="form-control" 
                                               name="email" 
                                               placeholder="Nhập email của bạn"
                                               value="${param.email}"
                                               required>
                                    </div>
                                </div>

                                <!-- Password Field -->
                                <div class="form-group mb-4">
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-lock"></i>
                                        </span>
                                        <input type="password" 
                                               class="form-control" 
                                               name="password" 
                                               placeholder="Nhập mật khẩu"
                                               required>
                                        <button class="btn btn-outline-secondary" 
                                                type="button" 
                                                id="togglePassword">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <!-- Error Message -->
                                <c:if test="${not empty mess}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="bi bi-exclamation-triangle me-2"></i>
                                        ${mess}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <!-- Submit Button -->
                                <div class="form-group mb-4">
                                    <button type="submit" class="btn btn-primary btn-login w-100">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>
                                        Đăng Nhập
                                    </button>
                                </div>

                                <!-- Remember Me & Forgot Password -->
                                <div class="form-group d-flex justify-content-between align-items-center mb-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="rememberMe">
                                        <label class="form-check-label" for="rememberMe">
                                            Ghi nhớ đăng nhập
                                        </label>
                                    </div>
                                    <a href="ResetPassword.jsp" class="forgot-password">
                                        <i class="bi bi-key me-1"></i>Quên Mật Khẩu?
                                    </a>
                                </div>
                            </form>

                            <!-- Divider -->
                            <div class="divider mb-4">
                                <span>hoặc</span>
                            </div>

                            <!-- Quick Actions -->
                            <div class="quick-actions">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <a href="Register.jsp" class="btn btn-outline-primary w-100">
                                            <i class="bi bi-person-plus me-2"></i>
                                            Đăng Ký Tài Khoản
                                        </a>
                                    </div>
                                    <div class="col-12">
                                        <a href="AdminSetupController" class="btn btn-outline-secondary w-100">
                                            <i class="bi bi-gear me-2"></i>
                                            Tạo tài khoản Admin
                                        </a>
                                    </div>
                                    <div class="col-12">
                                        <a href="home" class="btn btn-outline-info w-100">
                                            <i class="bi bi-house me-2"></i>
                                            Về trang chủ
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Side - Hero Image -->
                <div class="col-lg-6 col-md-12 d-none d-lg-block">
                    <div class="hero-section" data-aos="fade-left">
                        <div class="hero-content">
                            <div class="hero-text">
                                <h2 class="hero-title">Đặt lịch cắt tóc chuyên nghiệp</h2>
                                <p class="hero-description">
                                    Hệ thống đặt lịch hiện đại, tiện lợi với đội ngũ chuyên nghiệp. 
                                    Đặt lịch nhanh chóng, quản lý dễ dàng.
                                </p>
                                <div class="hero-features">
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle"></i>
                                        <span>Đặt lịch 24/7</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle"></i>
                                        <span>Chất lượng cao</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="bi bi-check-circle"></i>
                                        <span>An toàn tuyệt đối</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="hero-image">
                            <i class="bi bi-scissors hero-icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <!-- AOS Animation -->
        <script src="assets/vendor/aos/aos.js"></script>
        
        <!-- Custom JS -->
        <script>
            // Initialize AOS
            AOS.init({
                duration: 1000,
                easing: 'ease-in-out',
                once: true
            });

            // Toggle password visibility
            document.getElementById('togglePassword').addEventListener('click', function() {
                const passwordInput = document.querySelector('input[name="password"]');
                const icon = this.querySelector('i');
                
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            });

            // Form validation
            document.getElementById('loginForm').addEventListener('submit', function(e) {
                const email = document.querySelector('input[name="email"]').value;
                const password = document.querySelector('input[name="password"]').value;
                
                if (!email || !password) {
                    e.preventDefault();
                    alert('Vui lòng nhập đầy đủ thông tin!');
                    return false;
                }
                
                // Show loading state
                const submitBtn = document.querySelector('.btn-login');
                submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang đăng nhập...';
                submitBtn.disabled = true;
            });

            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>
    </body>
</html>
