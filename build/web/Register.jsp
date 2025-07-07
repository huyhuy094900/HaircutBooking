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
        <title>Đăng ký tài khoản</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/img/favicon.png" rel="icon">
        <style>
            :root {
                --primary-color: #667eea;
                --secondary-color: #764ba2;
                --success-color: #28a745;
                --danger-color: #dc3545;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
            }

            .register-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
            }

            .register-card {
                background: white;
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0,0,0,0.1);
                overflow: hidden;
                margin: 20px 0;
            }

            .register-header {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .register-header h2 {
                margin: 0;
                font-weight: 700;
                font-size: 2rem;
            }

            .register-header p {
                margin: 10px 0 0 0;
                opacity: 0.9;
            }

            .register-form {
                padding: 40px;
            }

            .form-floating {
                margin-bottom: 20px;
            }

            .form-floating .form-control {
                border-radius: 12px;
                border: 2px solid #e9ecef;
                padding: 15px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-floating .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .form-floating label {
                padding: 15px;
                color: #6c757d;
            }

            .form-select {
                border-radius: 12px;
                border: 2px solid #e9ecef;
                padding: 15px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .btn-register {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                border: none;
                border-radius: 12px;
                padding: 15px 30px;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                width: 100%;
                transition: all 0.3s ease;
                margin-bottom: 20px;
            }

            .btn-register:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
                color: white;
            }

            .btn-login {
                background: linear-gradient(135deg, var(--success-color) 0%, #20c997 100%);
                border: none;
                border-radius: 12px;
                padding: 15px 30px;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                width: 100%;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
                color: white;
            }

            .alert {
                border-radius: 12px;
                border: none;
                padding: 15px 20px;
                margin-bottom: 20px;
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border-left: 4px solid var(--success-color);
            }

            .alert-danger {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                border-left: 4px solid var(--danger-color);
            }

            .image-section {
                background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow: hidden;
            }

            .image-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('https://images.unsplash.com/photo-1560472354-b33ff0c44a43?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2126&q=80') center/cover;
                opacity: 0.1;
            }

            .image-content {
                position: relative;
                z-index: 1;
                text-align: center;
                color: white;
                padding: 40px;
            }

            .image-content h3 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 20px;
            }

            .image-content p {
                font-size: 1.2rem;
                opacity: 0.9;
            }

            @media (max-width: 768px) {
                .image-section {
                    display: none;
                }
                
                .register-form {
                    padding: 30px 20px;
                }
                
                .register-header {
                    padding: 20px;
                }
                
                .register-header h2 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="register-container">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="register-card">
                            <div class="row g-0">
                                <div class="col-lg-6">
                                    <div class="register-header">
                                        <h2><i class="bi bi-person-plus"></i> Đăng ký</h2>
                                        <p>Tạo tài khoản mới để sử dụng dịch vụ</p>
                                    </div>
                                    
                                    <div class="register-form">
                                        <form action="register" method="POST">
                                            <!-- Alert Messages -->
                                            <c:if test="${not empty mess}">
                                                <div class="alert ${mess.contains('thành công') ? 'alert-success' : 'alert-danger'}">
                                                    <i class="bi ${mess.contains('thành công') ? 'bi-check-circle' : 'bi-exclamation-triangle'}"></i>
                                                    ${mess}
                                                </div>
                                            </c:if>
                                            
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input type="text" class="form-control" id="username" name="username" placeholder="Tài khoản" required>
                                                        <label for="username"><i class="bi bi-person"></i> Tài khoản</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                                                        <label for="password"><i class="bi bi-lock"></i> Mật khẩu</label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-floating">
                                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                                                <label for="email"><i class="bi bi-envelope"></i> Địa chỉ Email</label>
                                            </div>
                                            
                                            <div class="form-floating">
                                                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Họ và tên" required>
                                                <label for="fullName"><i class="bi bi-person-badge"></i> Họ và tên</label>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Số điện thoại" required>
                                                        <label for="phone"><i class="bi bi-telephone"></i> Số điện thoại</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating">
                                                        <input type="date" class="form-control" id="DOB" name="DOB" required>
                                                        <label for="DOB"><i class="bi bi-calendar3"></i> Ngày sinh</label>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-floating">
                                                <select class="form-select" id="gender" name="gender" required>
                                                    <option value="" disabled selected>Chọn giới tính</option>
                                                    <option value="man">Nam</option>
                                                    <option value="woman">Nữ</option>
                                                    <option value="other">Khác</option>
                                                </select>
                                                <label for="gender"><i class="bi bi-gender-ambiguous"></i> Giới tính</label>
                                            </div>
                                            
                                            <button type="submit" class="btn btn-register">
                                                <i class="bi bi-person-plus"></i> Đăng ký
                                            </button>
                                            
                                            <a href="Login.jsp" class="btn btn-login">
                                                <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
                                            </a>
                                        </form>
                                    </div>
                                </div>
                                
                                <div class="col-lg-6">
                                    <div class="image-section">
                                        <div class="image-content">
                                            <h3>Chào mừng bạn!</h3>
                                            <p>Đăng ký tài khoản để trải nghiệm dịch vụ chăm sóc tóc chuyên nghiệp</p>
                                            <i class="bi bi-scissors" style="font-size: 4rem; opacity: 0.3;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

