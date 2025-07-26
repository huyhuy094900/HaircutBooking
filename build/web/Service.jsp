<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dịch vụ cắt tóc - HaircutBooking</title>
    <meta name="description" content="Khám phá các dịch vụ cắt tóc chuyên nghiệp với giá cả hợp lý">
    
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
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
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

        .nav-link:hover, .nav-link.active {
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

        .nav-link:hover::after, .nav-link.active::after {
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
            padding: 8rem 0 4rem;
            color: var(--white-color);
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
            text-align: center;
        }

        .hero-title {
            font-family: 'Poppins', sans-serif;
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Search and Filter Section */
        .search-section {
            background: var(--white-color);
            padding: 2rem 0;
            box-shadow: var(--shadow-light);
            position: relative;
            z-index: 10;
        }

        .search-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .search-box {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1.5rem 1rem 3rem;
            border: 2px solid #e9ecef;
            border-radius: 50px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            background: var(--white-color);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .search-icon {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 1.2rem;
        }



        /* Services Section */
        .services-section {
            padding: 4rem 0;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .service-card {
            background: var(--white-color);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            position: relative;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-heavy);
        }

        .service-image {
            height: 250px;
            background: var(--gradient-primary);
            position: relative;
            overflow: hidden;
        }

        .service-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .service-card:hover .service-image img {
            transform: scale(1.1);
        }

        .service-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.8), rgba(118, 75, 162, 0.8));
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .service-card:hover .service-overlay {
            opacity: 1;
        }

        .service-icon {
            font-size: 4rem;
            color: var(--white-color);
        }

        .service-content {
            padding: 2rem;
        }

        .service-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .service-description {
            color: #6c757d;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            min-height: 60px;
        }

        .service-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: var(--light-color);
            border-radius: 15px;
        }

        .service-price {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-color);
        }

        .service-duration {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6c757d;
            font-weight: 500;
        }

        .service-actions {
            display: flex;
            gap: 1rem;
        }

        .btn-book {
            flex: 1;
            background: var(--gradient-primary);
            color: var(--white-color);
            border: none;
            border-radius: 15px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
            color: var(--white-color);
        }

        .btn-detail {
            background: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            border-radius: 15px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-detail:hover {
            background: var(--primary-color);
            color: var(--white-color);
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--white-color);
            border-radius: 20px;
            box-shadow: var(--shadow-light);
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
            color: #6c757d;
            margin-bottom: 2rem;
        }

        /* Back to Top Button */
        .back-to-top {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            color: var(--white-color);
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s ease;
            opacity: 0;
            visibility: hidden;
            z-index: 1000;
        }

        .back-to-top.show {
            opacity: 1;
            visibility: visible;
        }

        .back-to-top:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }

        /* Loading Animation */
        .loading {
            text-align: center;
            padding: 2rem;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 1rem;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .services-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .service-actions {
                flex-direction: column;
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
                            <a class="nav-link active" href="list_service">Dịch vụ</a>
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
                            <a class="nav-link active" href="list_service">Dịch vụ</a>
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
                            <a class="nav-link active" href="list_service">Dịch vụ</a>
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
            <div class="hero-content" data-aos="fade-up">
                <h1 class="hero-title">
                    <i class="bi bi-stars me-3"></i>
                    Dịch vụ cắt tóc chuyên nghiệp
                </h1>
                <p class="hero-subtitle">
                    Khám phá các dịch vụ cắt tóc, làm đẹp chất lượng cao với giá cả hợp lý. 
                    Đặt lịch ngay để trải nghiệm sự khác biệt!
                </p>
            </div>
        </div>
    </section>

    <!-- Search and Filter Section -->
    <section class="search-section">
        <div class="container">
            <div class="search-container">
                <div class="search-box" data-aos="fade-up">
                    <i class="bi bi-search search-icon"></i>
                    <input type="text" class="search-input" id="searchInput" placeholder="Tìm kiếm dịch vụ...">
                </div>

            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="services-section">
        <div class="container">
            <div id="servicesContainer">
                <c:choose>
                    <c:when test="${empty services}">
                        <div class="empty-state" data-aos="fade-up">
                            <div class="empty-icon">
                                <i class="bi bi-scissors"></i>
                            </div>
                            <h2 class="empty-title">Chưa có dịch vụ nào</h2>
                            <p class="empty-description">
                                Hiện tại chưa có dịch vụ nào được cung cấp. 
                                Vui lòng quay lại sau hoặc liên hệ với chúng tôi.
                            </p>
                            <a href="home" class="btn btn-primary">
                                <i class="bi bi-house me-2"></i>Về trang chủ
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="services-grid" id="servicesGrid">
                            <c:forEach var="service" items="${services}" varStatus="status">
                                <div class="service-card service-item" 
                                     data-aos="fade-up" 
                                     data-aos-delay="${status.index * 100}"
                                     data-name="${service.name}"
                                     data-category="${service.name.toLowerCase()}">
                                    <div class="service-image">
                                        <img src="${pageContext.request.contextPath}/assets/img/${service.image}" 
                                             alt="${service.name}"
                                             onerror="this.src='data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 400 300%22><rect width=%22400%22 height=%22300%22 fill=%22%23667eea%22/><text x=%22200%22 y=%22150%22 text-anchor=%22middle%22 fill=%22white%22 font-size=%2248%22>${service.name}</text></svg>'">
                                        <div class="service-overlay">
                                            <i class="bi bi-scissors service-icon"></i>
                                        </div>
                                    </div>
                                    <div class="service-content">
                                        <h3 class="service-title">${service.name}</h3>
                                        <p class="service-description">${service.description}</p>
                                        <div class="service-meta">
                                            <div class="service-price">
                                                <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" /> VNĐ
                                            </div>
                                            <div class="service-duration">
                                                <i class="bi bi-clock me-1"></i>
                                                ${service.duration} phút
                                            </div>
                                        </div>
                                        <div class="service-actions">
                                            <a href="BookingController?service_id=${service.serviceId}" class="btn-book">
                                                <i class="bi bi-calendar-check"></i>
                                                Đặt lịch
                                            </a>
                                            <a href="service_detail?id=${service.serviceId}" class="btn-detail">
                                                <i class="bi bi-info-circle"></i>
                                                Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Back to Top Button -->
    <button class="back-to-top" id="backToTop" title="Lên đầu trang">
        <i class="bi bi-arrow-up"></i>
    </button>

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

        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const serviceItems = document.querySelectorAll('.service-item');

        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            
            serviceItems.forEach(item => {
                const serviceName = item.getAttribute('data-name').toLowerCase();
                const serviceCategory = item.getAttribute('data-category');
                
                if (serviceName.includes(searchTerm) || serviceCategory.includes(searchTerm)) {
                    item.style.display = 'block';
                    item.classList.add('fade-in-up');
                } else {
                    item.style.display = 'none';
                }
            });
        });



        // Back to top functionality
        const backToTopBtn = document.getElementById('backToTop');
        
        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                backToTopBtn.classList.add('show');
            } else {
                backToTopBtn.classList.remove('show');
            }
        });
        
        backToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
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
