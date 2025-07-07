<%-- 
    Document   : UserChangeProfile
    Created on : Jun 4, 2025, 2:14:41 AM
    Author     : sontu
--%>

<%-- 
    Document   : Register
    Created on : Feb 18, 2025, 11:10:15 AM
    Author     : sontu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="assets/css/login.css" rel="stylesheet">
        <link href="assets/img/favicon.png" rel="icon">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    </head>
    <body>
        <section class="vh-100">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-sm-6 text-black">

                        <div class="px-5 ms-xl-4">
                            <i class="fas fa-crow fa-2x me-3 pt-5 mt-xl-4" style="color: #709085;"></i>
                            <span class="h1 fw-bold mb-0">Thay đổi thông tin cá nhân</span>
                        </div>

                        <div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">

                            <form style="width: 23rem;" action="change_personal_information">

                                <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Log in</h3>

                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="text" id="form2Example18" class="form-control form-control-lg" name="username" placeholder="Tài khoản" value="${User.userName}"/>
                                    <label class="form-label" for="form2Example18">Tài khoản</label>
                                </div>

                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="password" id="form2Example28" class="form-control form-control-lg" name="password" placeholder="Mật khẩu" value="${User.password}"/>
                                    <label class="form-label" for="form2Example28">Mật Khẩu</label>
                                </div>
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="email" id="form2Example28" class="form-control form-control-lg" name="email" placeholder="Email" value="${User.email}"/>
                                    <label class="form-label" for="form2Example28">Địa chỉ Email</label>
                                </div>
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="text" id="form2Example28" class="form-control form-control-lg" name="fullName" placeholder="Họ và tên" value="${User.fullName}"/>
                                    <label class="form-label" for="form2Example28">Họ và Tên</label>
                                </div>
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="number" id="form2Example28" class="form-control form-control-lg" name="phone" placeholder="Số điện thoại" value="${User.phone}"/>
                                    <label class="form-label" for="form2Example28">Số điện thoại</label>
                                </div>
                                <div data-mdb-input-init class="form-outline mb-4">
                                    <input type="date" id="form2ExampleBOD" class="form-control form-control-lg" name="DOB" value="${User.birthOfDate}" />
                                    <label class="form-label" for="form2ExampleBOD">Ngày tháng năm sinh</label>
                                </div>

                                <div class="form-outline mb-4">
                                    <input type="text" id="form2ExampleBOD" class="form-control form-control-lg" name="gender" value="${User.gender}" />
                                    <label class="form-label" for="form2ExampleBOD">Giới tính</label>
                                </div>

                                <div class="pt-1 mb-4">
                                    <button data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-lg btn-block" type="submit">Đồng ý</button>
                                </div>
                                <div class="pt-1 mb-4">
                                    <a class="btn btn-info btn-lg btn-block" href="home">Trở lại Trang Chủ</a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </section>
    </body>
</html>


