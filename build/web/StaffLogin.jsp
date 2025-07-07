<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Staff Portal</title>
    
    <!-- Bootstrap CSS -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="assets/css/main.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }
        
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .login-header h2 {
            margin: 0;
            font-weight: 600;
        }
        
        .login-header p {
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
        }
        
        .login-body {
            padding: 2rem;
        }
        
        .form-floating {
            margin-bottom: 1rem;
        }
        
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            margin-top: 1rem;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .back-link {
            text-align: center;
            margin-top: 1rem;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
        
        .staff-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <div class="staff-icon">
                <i class="bi bi-person-badge"></i>
            </div>
            <h2>Staff Portal</h2>
            <p>Đăng nhập để quản lý lịch hẹn</p>
        </div>
        
        <div class="login-body">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="bi bi-exclamation-triangle"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-success" role="alert">
                    <i class="bi bi-check-circle"></i>
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            
            <form action="StaffLoginController" method="POST">
                <input type="hidden" name="action" value="login">
                
                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="name@example.com" 
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                           required>
                    <label for="email">
                        <i class="bi bi-envelope"></i> Email
                    </label>
                </div>
                
                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Password" required>
                    <label for="password">
                        <i class="bi bi-lock"></i> Mật khẩu
                    </label>
                </div>
                
                <button type="submit" class="btn btn-primary btn-login">
                    <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                </button>
            </form>
            
            <div class="back-link">
                <a href="index.jsp">
                    <i class="bi bi-arrow-left"></i> Quay lại trang chủ
                </a>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto focus on email field
        document.getElementById('email').focus();
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (!email || !password) {
                e.preventDefault();
                alert('Vui lòng nhập đầy đủ thông tin!');
                return false;
            }
            
            if (!email.includes('@')) {
                e.preventDefault();
                alert('Email không hợp lệ!');
                return false;
            }
        });
    </script>
</body>
</html> 