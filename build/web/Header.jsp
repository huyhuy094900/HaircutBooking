<%-- 
    Document   : Header
    Created on : Feb 13, 2025, 11:03:48 PM
    Author     : sontu
--%>
<!DOCTYPE html>
<html>
    <head>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta name="description" content="">
        <meta name="keywords" content="">

        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Nunito:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="assets/css/main.css" rel="stylesheet">

        <!-- Navigation Helper -->
        <script src="assets/js/navigation.js"></script>

        <!-- =======================================================
        * Template Name: Company
        * Template URL: https://bootstrapmade.com/company-free-html-bootstrap-template/
        * Updated: Aug 07 2024 with Bootstrap v5.3.3
        * Author: BootstrapMade.com
        * License: https://bootstrapmade.com/license/
        ======================================================== -->
    </head>
    <body>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <header id="header" class="header d-flex align-items-center sticky-top">
            <div class="container position-relative d-flex align-items-center">
                <a href="home" class="logo d-flex align-items-center me-auto">
                    <img src="assets/img/logo.png" alt="Logo" style="height: 40px; margin-right: 10px;">
                    <h1 class="sitename">HaircutBooking</h1>
                </a>

                <nav id="navmenu" class="navmenu">
                    <ul>
                        <c:if test="${empty sessionScope.user}">
                            <li><a href="home" class="active">Trang chủ</a></li>
                            <li><a href="ServiceDirect.jsp">Dịch vụ</a></li>
                        </c:if>
                        <c:if test="${not empty sessionScope.user and not sessionScope.user.admin}">
                            <li><a href="home" class="active">Trang chủ</a></li>
                            <li><a href="ServiceDirect.jsp">Dịch vụ</a></li>
                            <li><a href="BookingController?action=list"><i class="bi bi-list-ul me-1"></i>Lịch hẹn của tôi</a></li>
                        </c:if>
                        <c:if test="${not empty sessionScope.user}">
                            <li class="dropdown">
                                <a href="#">
                                    <span>Xin chào ${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Người dùng'}</span> 
                                    <i class="bi bi-chevron-down toggle-dropdown"></i>
                                </a>
                                <ul>
                                    <li><a href="BookingController?action=list"><i class="bi bi-list-ul me-1"></i> Lịch hẹn của tôi</a></li>
                                    <li><a href="logout"><i class="bi bi-box-arrow-right me-1"></i> Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                            <li><a href="list_user">Quản lý người dùng</a></li>
                        </c:if>
                    </ul>
                    <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                </nav>

                <div class="header-social-links">
                    <a href="https://www.facebook.com/mai.anh.inh.170269" class="facebook"><i class="bi bi-facebook"></i></a>
                    <a href="https://www.tiktok.com/@nhancongtoiuu?_t=ZS-8u90jLgq45X&_r=1" class="twitter"><i class="bi bi-tiktok"></i></a>
                    <a href="StaffLogin.jsp" class="staff-portal" title="Staff Portal"><i class="bi bi-person-badge"></i></a>
                </div>

                <!-- Nếu chưa đăng nhập, hiển thị nút đăng nhập -->
                <c:if test="${empty sessionScope.user}">
                    <a href="Login.jsp" class="btn login-btn ms-3">Đăng nhập</a>
                </c:if>
            </div>
        </header>

        <style>
            .login-btn {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white !important;
                border: none;
                padding: 10px 20px;
                border-radius: 25px;
                transition: all 0.3s ease;
                font-family: "Roboto", sans-serif;
                font-weight: 600;
                text-decoration: none;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .login-btn:hover {
                background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
                color: white !important;
            }

            .header {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .navmenu ul li a {
                color: #2c3e50;
                font-weight: 500;
                transition: all 0.3s ease;
                position: relative;
            }

            .navmenu ul li a:hover,
            .navmenu ul li a.active {
                color: #667eea;
            }

            .navmenu ul li a::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 0;
                width: 0;
                height: 2px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                transition: width 0.3s ease;
            }

            .navmenu ul li a:hover::after,
            .navmenu ul li a.active::after {
                width: 100%;
            }

            .dropdown-menu {
                border: none;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(20px);
                background: rgba(255, 255, 255, 0.95);
            }

            .dropdown-menu li a {
                padding: 10px 20px;
                color: #2c3e50;
                transition: all 0.3s ease;
                border-radius: 8px;
                margin: 2px 8px;
            }

            .dropdown-menu li a:hover {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                transform: translateX(5px);
            }

            .sitename {
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 700;
            }

            .staff-portal {
                color: #667eea;
                transition: all 0.3s ease;
                font-size: 1.2rem;
            }

            .staff-portal:hover {
                color: #764ba2;
                transform: scale(1.1);
            }
        </style>
    </body>
</html>
