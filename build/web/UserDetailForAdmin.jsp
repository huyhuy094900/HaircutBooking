<%-- 
    Document   : UserDetailForAdmin
    Created on : Feb 24, 2025, 2:33:52 AM
    Author     : sontu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>HomePage - Job Community</title>
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

        <!-- =======================================================
        * Template Name: Company
        * Template URL: https://bootstrapmade.com/company-free-html-bootstrap-template/
        * Updated: Aug 07 2024 with Bootstrap v5.3.3
        * Author: BootstrapMade.com
        * License: https://bootstrapmade.com/license/
        ======================================================== -->
    </head>

    <body class="blog-details-page">
        <%@include file="Header.jsp" %>
        <main class="main">

            <!-- Page Title -->
            <div class="page-title accent-background">
                <div class="container d-lg-flex justify-content-between align-items-center">
                    <h1 class="mb-2 mb-lg-0">Chi tiết bài đăng</h1>
                    <nav class="breadcrumbs">
                        <ol>
                            <li><a href="Home.jsp">Trang chủ</a></li>
                            <li class="current">Chi tiết bài đăng</li>
                        </ol>
                    </nav>
                </div>
            </div><!-- End Page Title -->

            <div class="container">
                <div class="row">

                    <div class="col-lg-18">

                        <!-- Blog Details Section -->
                        <section id="blog-details" class="blog-details section">
                            <div class="container">

                                <article class="article">   

                                    <div class="post-img">
                                        <img src="${User.avatar}" alt="Image" class="img-fluid">
                                    </div>
                                    <div class="content">
                                        <h3>Mã hệ thống:</h3>
                                        <p>
                                            ${User.id}
                                        </p>
                                        <h3>Tài khoản:</h3>
                                        <p>${User.userName}</p>
                                        <h3>Mật Khẩu:</h3>
                                        <p>${User.password}</p>
                                        <h3>Email:</h3>
                                        <p>${User.email}</p>
                                        <h3>Họ và tên:</h3>
                                        <p>${User.fullName}</p>
                                        <h3>Số điện thoại:</h3>
                                        <p>${User.phone}</p>
                                        <h3>Ngày tháng năm sinh:</h3>
                                        <p>${User.birthOfDate}</p>
                                        <h3>Giới tính:</h3>
                                        <p>${User.gender}</p>
                                        <h3>Địa chỉ: </h3>
                                        <p>${User.address}</p>
                                        <h3>Loại tài khoản: </h3>
                                        <c:choose>
                                            <c:when test="${User.roleID == 0}">
                                                <p> Là Admin</p>
                                            </c:when>
                                            <c:when test="${User.roleID == 1}">
                                                <p> Khách hàng</p>
                                            </c:when>
                                            <c:when test="${User.roleID == 2}">
                                                <p> Nhân viên</p>
                                            </c:when>
                                        </c:choose>
                                        <h3>Ban or Unban User:</h3>
                                        <c:choose>
                                            <c:when test="${User.status == 0}">
                                                <a href="unban_user?id=${User.id}"> Unban This User</a>
                                            </c:when>
                                            <c:when test="${User.status == 1}">
                                                <a href="ban_user?id=${User.id}"> Ban This User</a>
                                            </c:when>
                                        </c:choose>
                                    </div><!-- End post content -->
                                </article>

                            </div>
                        </section><!-- /Blog Details Section -->

                        <!-- Blog Comments Section -->
                    </div>
                </div>
            </div>
            <style>
                .login-btn {
                    background-color: rgb(30, 50, 186) !important;
                    color: white !important;
                    border: none;
                    padding: 8px 16px;
                    border-radius: 5px;
                    transition: 0.3s;
                    font-family: "Roboto", sans-serif;
                }

                .login-btn:hover {
                    background-color: rgb(62, 112, 186) !important; /* Màu tối hơn khi hover */
                }

            </style>
        </main>

        <%@include file="Footer.jsp" %>

        <!-- Vendor JS Files -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
        <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
        <script src="assets/vendor/waypoints/noframework.waypoints.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

        <!-- Main JS File -->
        <script src="assets/js/main.js"></script>

    </body>

</html>
