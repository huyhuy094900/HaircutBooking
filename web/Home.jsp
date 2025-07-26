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

    <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

        <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --accent-color: #f093fb;
            --success-color: #4facfe;
            --warning-color: #43e97b;
            --danger-color: #fa709a;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
            --white-color: #ffffff;
            --gradient-primary: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            --gradient-accent: linear-gradient(135deg, var(--accent-color) 0%, var(--primary-color) 100%);
            --gradient-success: linear-gradient(135deg, var(--success-color) 0%, var(--warning-color) 100%);
            --shadow-light: 0 10px 30px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 15px 35px rgba(0, 0, 0, 0.15);
            --shadow-heavy: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            overflow-x: hidden;
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 0;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.98);
            box-shadow: var(--shadow-light);
        }

        .navbar-brand {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--primary-color) !important;
            text-decoration: none;
        }

        .nav-link {
            font-weight: 500;
            color: var(--dark-color) !important;
            margin: 0 0.5rem;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--gradient-primary);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            border-radius: 25px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* Hero Section */
        .hero-section {
            background: var(--gradient-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><polygon fill="rgba(255,255,255,0.1)" points="0,1000 1000,0 1000,1000"/></svg>');
            background-size: cover;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            color: var(--white-color);
        }

        .hero-title {
            font-family: 'Poppins', sans-serif;
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-hero {
            padding: 1rem 2rem;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-hero-primary {
            background: var(--white-color);
            color: var(--primary-color);
        }

        .btn-hero-primary:hover {
            background: var(--light-color);
            color: var(--primary-color);
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }

        .btn-hero-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: var(--white-color);
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-hero-secondary:hover {
            background: rgba(255, 255, 255, 0.3);
            color: var(--white-color);
            transform: translateY(-3px);
        }

        .hero-image {
            position: relative;
            z-index: 2;
        }

        .hero-icon {
            font-size: 20rem;
            color: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        /* Features Section */
        .features-section {
            padding: 6rem 0;
            background: var(--white-color);
        }

        .section-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        .section-subtitle {
            font-size: 1.1rem;
            text-align: center;
            color: #6c757d;
            margin-bottom: 4rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .feature-card {
            background: var(--white-color);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            height: 100%;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-heavy);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: var(--white-color);
        }

        .feature-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--dark-color);
        }

        .feature-description {
            color: #6c757d;
            line-height: 1.6;
        }

        /* Statistics Section */
        .stats-section {
            background: var(--gradient-accent);
            padding: 4rem 0;
            color: var(--white-color);
        }

        .stat-card {
            text-align: center;
            padding: 2rem 1rem;
        }

        .stat-number {
            font-family: 'Poppins', sans-serif;
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: block;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Services Preview */
        .services-section {
            padding: 6rem 0;
            background: var(--light-color);
        }

        .service-card {
            background: var(--white-color);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            height: 100%;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-medium);
        }

        .service-image {
            height: 200px;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: var(--white-color);
        }

        .service-content {
            padding: 1.5rem;
        }

        .service-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }

        .service-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .service-description {
            color: #6c757d;
            margin-bottom: 1rem;
            line-height: 1.6;
        }

        /* CTA Section */
        .cta-section {
            background: var(--gradient-success);
            padding: 6rem 0;
            color: var(--white-color);
            text-align: center;
        }

        .cta-title {
            font-family: 'Poppins', sans-serif;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .cta-description {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .btn-cta {
            background: var(--white-color);
            color: var(--success-color);
            padding: 1rem 2.5rem;
            border-radius: 30px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-cta:hover {
            background: var(--light-color);
            color: var(--success-color);
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }

        /* Footer */
        .footer {
            background: var(--dark-color);
            color: var(--white-color);
            padding: 3rem 0 1rem;
        }

        .footer-content {
            text-align: center;
        }

        .footer-brand {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .footer-description {
            color: #adb5bd;
            margin-bottom: 2rem;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white-color);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .social-link:hover {
            transform: translateY(-3px);
            color: var(--white-color);
        }

        .footer-bottom {
            border-top: 1px solid #495057;
            padding-top: 1rem;
            text-align: center;
            color: #adb5bd;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-buttons {
                flex-direction: column;
            }
            
            .btn-hero {
                width: 100%;
                justify-content: center;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .hero-icon {
                font-size: 10rem;
            }
        }

        /* Animations */
        .fade-in-up {
            animation: fadeInUp 0.8s ease-out;
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

        .scale-in {
            animation: scaleIn 0.6s ease-out;
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
    </head>

    <body>
        <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top" id="navbar">
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
                        <li class="nav-item">
                            <a class="btn btn-primary" href="Login.jsp">Đăng nhập</a>
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
                    </c:if>
                    <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Trang chủ</a>
                        </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="AdminDashboardController">
                                        <i class="bi bi-gear me-1"></i>Admin
                                    </a>
                                </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i>
                                ${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Admin'}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="logout">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
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
                        <p class="hero-subtitle">
                            Hệ thống đặt lịch hiện đại, tiện lợi với đội ngũ chuyên nghiệp. 
                            Đặt lịch nhanh chóng, quản lý dễ dàng, trải nghiệm tuyệt vời.
                        </p>
                            <div class="hero-buttons">
                            <a href="BookingController" class="btn-hero btn-hero-primary">
                                <i class="bi bi-calendar-check"></i>
                                Đặt lịch ngay
                                </a>
                            <a href="list_service" class="btn-hero btn-hero-secondary">
                                <i class="bi bi-list-ul"></i>
                                Xem dịch vụ
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6" data-aos="fade-left">
                    <div class="hero-image text-center">
                        <i class="bi bi-scissors hero-icon"></i>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-card">
                        <span class="stat-number">500+</span>
                        <div class="stat-label">Khách hàng hài lòng</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-card">
                        <span class="stat-number">50+</span>
                        <div class="stat-label">Thợ cắt chuyên nghiệp</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-card">
                        <span class="stat-number">1000+</span>
                        <div class="stat-label">Lịch hẹn thành công</div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="stat-card">
                        <span class="stat-number">24/7</span>
                        <div class="stat-label">Hỗ trợ khách hàng</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Tại sao chọn chúng tôi?</h2>
            <p class="section-subtitle" data-aos="fade-up">
                Những lý do khiến HaircutBooking trở thành lựa chọn hàng đầu cho việc đặt lịch cắt tóc
            </p>
                
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-clock"></i>
                            </div>
                            <h3 class="feature-title">Đặt lịch 24/7</h3>
                        <p class="feature-description">
                            Đặt lịch bất cứ lúc nào, mọi nơi với hệ thống online tiện lợi. 
                            Không cần gọi điện hay đến tận nơi.
                        </p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-star"></i>
                            </div>
                            <h3 class="feature-title">Chất lượng cao</h3>
                        <p class="feature-description">
                            Đội ngũ chuyên nghiệp với tay nghề cao và kinh nghiệm lâu năm. 
                            Cam kết mang đến kết quả tốt nhất.
                        </p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-shield-check"></i>
                            </div>
                            <h3 class="feature-title">An toàn tuyệt đối</h3>
                        <p class="feature-description">
                            Tuân thủ nghiêm ngặt các quy định vệ sinh và an toàn. 
                            Đảm bảo sức khỏe cho mọi khách hàng.
                        </p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-currency-dollar"></i>
                            </div>
                            <h3 class="feature-title">Giá cả hợp lý</h3>
                        <p class="feature-description">
                            Mức giá cạnh tranh với chất lượng dịch vụ tốt nhất. 
                            Không có phí ẩn, minh bạch 100%.
                        </p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-phone"></i>
                            </div>
                            <h3 class="feature-title">Hỗ trợ nhanh chóng</h3>
                        <p class="feature-description">
                            Đội ngũ hỗ trợ khách hàng 24/7, sẵn sàng giải đáp mọi thắc mắc. 
                            Phản hồi nhanh chóng và chính xác.
                        </p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-heart"></i>
                            </div>
                            <h3 class="feature-title">Hài lòng 100%</h3>
                        <p class="feature-description">
                            Cam kết mang đến trải nghiệm tốt nhất cho mọi khách hàng. 
                            Nếu không hài lòng, chúng tôi sẽ hoàn tiền.
                        </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    <!-- Services Preview Section -->
        <section class="services-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Dịch vụ nổi bật</h2>
            <p class="section-subtitle" data-aos="fade-up">
                Khám phá các dịch vụ cắt tóc chuyên nghiệp của chúng tôi
            </p>
                
                <div class="row g-4">
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                                <div class="service-card">
                                    <div class="service-image">
                            <i class="bi bi-person"></i>
                                    </div>
                                    <div class="service-content">
                            <h3 class="service-title">Cắt tóc nam</h3>
                            <div class="service-price">100,000 VNĐ</div>
                            <p class="service-description">
                                Dịch vụ cắt tóc chuyên nghiệp cho nam giới với nhiều kiểu tóc hiện đại
                            </p>
                            <a href="list_service" class="btn btn-primary w-100">
                                <i class="bi bi-arrow-right me-2"></i>Xem chi tiết
                                            </a>
                                        </div>
                                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="service-card">
                        <div class="service-image">
                            <i class="bi bi-person-heart"></i>
                        </div>
                        <div class="service-content">
                            <h3 class="service-title">Cắt tóc nữ</h3>
                            <div class="service-price">150,000 VNĐ</div>
                            <p class="service-description">
                                Dịch vụ cắt tóc và tạo kiểu cho nữ giới với nhiều xu hướng mới
                            </p>
                            <a href="list_service" class="btn btn-primary w-100">
                                <i class="bi bi-arrow-right me-2"></i>Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="service-card">
                        <div class="service-image">
                            <i class="bi bi-droplet"></i>
                        </div>
                        <div class="service-content">
                            <h3 class="service-title">Nhuộm tóc</h3>
                            <div class="service-price">300,000 VNĐ</div>
                            <p class="service-description">
                                Dịch vụ nhuộm tóc với nhiều màu sắc đẹp và chất lượng cao
                            </p>
                            <a href="list_service" class="btn btn-primary w-100">
                                <i class="bi bi-arrow-right me-2"></i>Xem chi tiết
                            </a>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    <!-- Call to Action Section -->
        <section class="cta-section">
            <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center" data-aos="fade-up">
                    <h2 class="cta-title">Sẵn sàng đặt lịch ngay?</h2>
                    <p class="cta-description">
                        Hãy trải nghiệm dịch vụ cắt tóc chuyên nghiệp của chúng tôi ngay hôm nay!
                    </p>
                    <a href="BookingController" class="btn-cta">
                        <i class="bi bi-calendar-check"></i>
                        Đặt lịch ngay
                    </a>
                </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                <div class="footer-brand">
                    <i class="bi bi-scissors me-2"></i>HaircutBooking
                </div>
                <p class="footer-description">
                    Hệ thống đặt lịch cắt tóc chuyên nghiệp, tiện lợi và hiện đại. 
                    Mang đến trải nghiệm tốt nhất cho mọi khách hàng.
                </p>
                <div class="social-links">
                    <a href="#" class="social-link">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="#" class="social-link">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="#" class="social-link">
                        <i class="bi bi-twitter"></i>
                    </a>
                    <a href="#" class="social-link">
                        <i class="bi bi-youtube"></i>
                    </a>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 HaircutBooking. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </footer>
        
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        
        <script>
            // Initialize AOS
            AOS.init({
            duration: 800,
                easing: 'ease-in-out',
                once: true
            });
            
            // Navbar scroll effect
            window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
                if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
                } else {
                navbar.classList.remove('scrolled');
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

        // Add loading animation
        window.addEventListener('load', function() {
            document.body.classList.add('loaded');
        });

        // Parallax effect for hero section
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const heroSection = document.querySelector('.hero-section');
            if (heroSection) {
                heroSection.style.transform = `translateY(${scrolled * 0.5}px)`;
            }
        });
        </script>
    </body>
</html>
