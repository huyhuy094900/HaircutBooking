<%-- 
    Document   : Home
    Created on : Feb 13, 2025, 10:27:01 AM
    Author     : sontu
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HaircutBooking - Hệ thống đặt lịch cắt tóc chuyên nghiệp</title>
        <meta name="description" content="Đặt lịch cắt tóc nhanh chóng, tiện lợi với đội ngũ chuyên nghiệp">
        <meta name="keywords" content="cắt tóc, đặt lịch, salon, làm đẹp, hair salon">
        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

        <!-- AOS Animation -->
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="assets/css/home.css" rel="stylesheet">
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
                                <a class="nav-link" href="list_service">Dịch vụ</a>
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
                                <a class="nav-link" href="list_service">Dịch vụ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="BookingController">Đặt lịch</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="BookingController?action=list">
                                    <i class="bi bi-list-ul me-1"></i>Lịch hẹn của tôi
                                </a>
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

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6" data-aos="fade-right">
                        <div class="hero-content">
                            <h1 class="hero-title">Đặt lịch cắt tóc chuyên nghiệp</h1>
                            <p class="hero-subtitle">Hệ thống đặt lịch hiện đại, tiện lợi với đội ngũ chuyên nghiệp. Đặt lịch nhanh chóng, quản lý dễ dàng.</p>
                            <div class="hero-buttons">
                                <a href="BookingController" class="btn btn-primary">
                                    <i class="bi bi-calendar-check me-2"></i>Đặt lịch ngay
                                </a>
                                <a href="list_service" class="btn btn-secondary">
                                    <i class="bi bi-list-ul me-2"></i>Xem dịch vụ
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6" data-aos="fade-left">
                        <div class="text-center">
                            <i class="bi bi-scissors" style="font-size: 15rem; color: rgba(255,255,255,0.2);"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Tại sao chọn chúng tôi?</h2>
                <p class="section-subtitle" data-aos="fade-up">Những lý do khiến HaircutBooking trở thành lựa chọn hàng đầu</p>
                
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-clock"></i>
                            </div>
                            <h3 class="feature-title">Đặt lịch 24/7</h3>
                            <p class="feature-description">Đặt lịch bất cứ lúc nào, mọi nơi với hệ thống online tiện lợi</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-star"></i>
                            </div>
                            <h3 class="feature-title">Chất lượng cao</h3>
                            <p class="feature-description">Đội ngũ chuyên nghiệp với tay nghề cao và kinh nghiệm lâu năm</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-shield-check"></i>
                            </div>
                            <h3 class="feature-title">An toàn tuyệt đối</h3>
                            <p class="feature-description">Tuân thủ nghiêm ngặt các quy định vệ sinh và an toàn</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-currency-dollar"></i>
                            </div>
                            <h3 class="feature-title">Giá cả hợp lý</h3>
                            <p class="feature-description">Mức giá cạnh tranh với chất lượng dịch vụ tốt nhất</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-phone"></i>
                            </div>
                            <h3 class="feature-title">Hỗ trợ nhanh chóng</h3>
                            <p class="feature-description">Đội ngũ hỗ trợ khách hàng 24/7, sẵn sàng giải đáp mọi thắc mắc</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-heart"></i>
                            </div>
                            <h3 class="feature-title">Hài lòng 100%</h3>
                            <p class="feature-description">Cam kết mang đến trải nghiệm tốt nhất cho mọi khách hàng</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Services Section -->
        <section class="services-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Dịch vụ nổi bật</h2>
                <p class="section-subtitle" data-aos="fade-up">Khám phá các dịch vụ cắt tóc và làm đẹp chuyên nghiệp</p>
                
                <div class="row g-4">
                    <c:if test="${not empty list3Services}">
                        <c:forEach items="${list3Services}" var="service" varStatus="status">
                            <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                                <div class="service-card">
                                    <div class="service-image">
                                        <i class="bi bi-scissors"></i>
                                    </div>
                                    <div class="service-content">
                                        <h3 class="service-title">${service.name}</h3>
                                        <p class="service-description">${service.description}</p>
                                        <div class="service-price"><fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" /> VND</div>
                                        <div class="service-duration">
                                            <i class="bi bi-clock me-1"></i>${service.duration} phút
                                        </div>
                                        <div class="d-grid gap-2">
                                            <a href="BookingController?service_id=${service.serviceId}" class="btn btn-primary">
                                                <i class="bi bi-calendar-check me-2"></i>Đặt lịch
                                            </a>
                                            <a href="service_detail?id=${service.serviceId}" class="btn btn-outline-primary">
                                                <i class="bi bi-info-circle me-2"></i>Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    
                    <c:if test="${empty list3Services}">
                        <div class="col-12 text-center" data-aos="fade-up">
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle me-2"></i>
                                Đang tải dịch vụ... Vui lòng thử lại sau.
                            </div>
                        </div>
                    </c:if>
                </div>
                
                <div class="text-center mt-5" data-aos="fade-up">
                    <a href="list_service" class="btn btn-primary btn-lg">
                        <i class="bi bi-list-ul me-2"></i>Xem tất cả dịch vụ
                    </a>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="stat-item">
                            <div class="stat-number">1000+</div>
                            <div class="stat-label">Khách hàng hài lòng</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="stat-item">
                            <div class="stat-number">50+</div>
                            <div class="stat-label">Chuyên gia tay nghề cao</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="stat-item">
                            <div class="stat-number">10+</div>
                            <div class="stat-label">Năm kinh nghiệm</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="stat-item">
                            <div class="stat-number">24/7</div>
                            <div class="stat-label">Hỗ trợ khách hàng</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <div class="container">
                <h2 class="cta-title" data-aos="fade-up">Sẵn sàng thay đổi diện mạo?</h2>
                <p class="cta-subtitle" data-aos="fade-up">Đặt lịch ngay hôm nay và trải nghiệm dịch vụ chuyên nghiệp</p>
                <div class="hero-buttons justify-content-center" data-aos="fade-up">
                    <a href="BookingController" class="btn btn-primary btn-lg">
                        <i class="bi bi-calendar-check me-2"></i>Đặt lịch ngay
                    </a>
                    <a href="Register.jsp" class="btn btn-secondary btn-lg">
                        <i class="bi bi-person-plus me-2"></i>Đăng ký tài khoản
                    </a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-section">
                        <h5><i class="bi bi-scissors me-2"></i>HaircutBooking</h5>
                        <p>Hệ thống đặt lịch cắt tóc chuyên nghiệp, tiện lợi và hiện đại. Mang đến trải nghiệm tốt nhất cho khách hàng.</p>
                    </div>
                    
                    <div class="footer-section">
                        <h5>Dịch vụ</h5>
                        <ul class="list-unstyled">
                            <li><a href="list_service">Cắt tóc nam</a></li>
                            <li><a href="list_service">Cắt tóc nữ</a></li>
                            <li><a href="list_service">Nhuộm tóc</a></li>
                            <li><a href="list_service">Uốn tóc</a></li>
                        </ul>
                    </div>
                    
                    <div class="footer-section">
                        <h5>Liên kết</h5>
                        <ul class="list-unstyled">
                            <li><a href="home">Trang chủ</a></li>
                            <li><a href="list_service">Dịch vụ</a></li>
                            <li><a href="BookingController">Đặt lịch</a></li>
                            <li><a href="Login.jsp">Đăng nhập</a></li>
                        </ul>
                    </div>
                    
                    <div class="footer-section">
                        <h5>Liên hệ</h5>
                        <ul class="list-unstyled">
                            <li><i class="bi bi-geo-alt me-2"></i>123 Đường ABC, Quận 1, TP.HCM</li>
                            <li><i class="bi bi-telephone me-2"></i>0123 456 789</li>
                            <li><i class="bi bi-envelope me-2"></i>info@haircutbooking.com</li>
                        </ul>
                    </div>
                </div>
                
                <div class="footer-bottom">
                    <p>&copy; 2024 HaircutBooking. Tất cả quyền được bảo lưu.</p>
                </div>
            </div>
        </footer>

        <!-- Floating Action Button -->
        <div class="floating-action">
            <a href="BookingController" class="floating-btn" title="Đặt lịch nhanh">
                <i class="bi bi-calendar-plus"></i>
            </a>
        </div>

        <!-- Bootstrap JS -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        
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
            
            // Navbar scroll effect
            window.addEventListener('scroll', function() {
                const navbar = document.querySelector('.navbar');
                if (window.scrollY > 50) {
                    navbar.style.background = 'rgba(255, 255, 255, 0.98)';
                    navbar.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.1)';
                } else {
                    navbar.style.background = 'rgba(255, 255, 255, 0.95)';
                    navbar.style.boxShadow = '0 10px 25px rgba(0, 0, 0, 0.1)';
                }
            });
            
            // Smooth scrolling for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        </script>
    </body>

</html>
