<%-- 
    Document   : PostDetail
    Created on : Feb 13, 2025, 10:51:15 PM
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
                                        <img src="${PostDetail.img}" alt="Image" class="img-fluid">
                                    </div>

                                    <h2 class="title">${PostDetail.title}</h2>

                                    <div class="meta-top">
                                        <ul>
                                            <li class="d-flex align-items-center"><i class="bi bi-arrow-bar-right"></i>${PostDetail.startedDate}</li>
                                            <li class="d-flex align-items-center"><i class="bi bi-clock"></i> <time datetime="2020-01-01">${PostDetail.timeDuration}</time></li> 
                                        </ul>
                                    </div><!-- End meta top -->

                                    <div class="content">
                                        <p>
                                            Người đăng: ${PostDetail.userName}
                                        </p>
                                        <h3>Thông tin chi tiết:</h3>
                                        <p>${PostDetail.description}</p>
                                        <h3>Ngày làm:</h3>
                                        <p>${PostDetail.startedDate}</p>
                                        <h3>Địa điểm:</h3>
                                        <p>${PostDetail.place}</p>
                                        <h3>Thời gian thanh toán:</h3>
                                        <p>${PostDetail.paymentTime}</p>
                                        <h3>Thời gian làm:</h3>
                                        <p>${PostDetail.timeDuration}</p>
                                        <h3>Lương:</h3>
                                        <p>${PostDetail.salary}VND</p>
                                        <h3>Yêu cầu(cho nhân công):</h3>
                                        <p>${PostDetail.requirements}</p>
                                    </div><!-- End post content -->
                                    <c:if test="${PostDetail.userID == sessionScope.user.userID}">
                                        <c:if test="${PostDetail.status == 1}">
                                        <a href="inactive_post?postID=${PostDetail.postID}" class="btn login-btn ms-3">Xóa bài đăng</a>
                                        </c:if>
                                        <p>Bạn là chủ bài đăng này!</p>
                                    </c:if>

                                </article>

                            </div>
                        </section><!-- /Blog Details Section -->

                        <!-- Blog Comments Section -->
                        <section id="blog-comments" class="blog-comments section">

                            <div class="container">

                                <h4 class="comments-count">Comments</h4>
                                <c:forEach items="${listCommentbyPostID}" var="lc">
                                    <div id="comment-1" class="comment">
                                        <div class="d-flex">
                                            <div class="comment-img"><img src="${lc.img}" alt="image"></div>
                                            <div>
                                                <h5>${lc.userName}</h5>
                                                <time datetime="2020-01-01">${lc.createdAt}</time>
                                                <p>
                                                    ${lc.content}
                                                </p>
                                            </div>
                                        </div>
                                    </div><!-- End comment #1 -->
                                </c:forEach>
                            </div>

                        </section><!-- /Blog Comments Section -->
                        <c:if test="${not empty sessionScope.user}">
                            <!-- Comment Form Section -->
                            <section id="comment-form" class="comment-form section">
                                <div class="container">

                                    <form action="post_comment">

                                        <h4>Đăng bình luận</h4>
                                        <input type="hidden" value="${sessionScope.user.userID}" name="userID">
                                        <input type="hidden" value="${PostDetail.postID}" name="postID">
                                        <div class="row">
                                            <div class="col form-group">
                                                <textarea name="content" class="form-control" placeholder="Your Comment*"></textarea>
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <button type="submit" class="btn btn-primary">Post Comment</button>
                                        </div>

                                    </form>

                                </div>
                            </section><!-- /Comment Form Section -->
                        </c:if>
                        <c:if test="${ empty sessionScope.user}">
                            <!-- Comment Form Section -->
                            <section id="comment-form" class="comment-form section">
                                <div class="text-center">
                                    <p>You need to login to comment !</p>
                                </div>
                        </div>
                        </section><!-- /Comment Form Section -->
                    </c:if>
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
