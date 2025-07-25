<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt lịch - Admin</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f5f7fa; min-height: 100vh; }
        .admin-header { background: linear-gradient(135deg, #20c997 0%, #0dcaf0 100%); color: white; padding: 32px 0 24px 0; margin-bottom: 24px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); }
        .admin-header h1 { font-weight: 700; font-size: 2.2rem; }
        .placeholder-card { background: white; border-radius: 18px; padding: 40px 24px; box-shadow: 0 4px 16px rgba(13,202,240,0.08); text-align: center; margin-top: 40px; }
        .placeholder-card i { font-size: 3.5rem; color: #20c997; margin-bottom: 18px; }
        .placeholder-card h3 { font-size: 1.5rem; margin-bottom: 10px; }
        .placeholder-card p { color: #666; }
    </style>
</head>
<body>
<jsp:include page="AdminHeader.jsp"/>
<div class="admin-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="bi bi-calendar-check"></i> Quản lý đặt lịch</h1>
                <p class="lead mb-0">Chức năng quản lý đặt lịch cho admin</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="admin" class="btn btn-light">
                    <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                </a>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="placeholder-card">
        <i class="bi bi-tools"></i>
        <h3>Chức năng đang phát triển</h3>
        <p>Trang quản lý đặt lịch cho admin sẽ được cập nhật trong phiên bản tiếp theo.<br>Vui lòng quay lại sau hoặc liên hệ quản trị viên để biết thêm chi tiết.</p>
        <a href="admin" class="btn btn-outline-primary mt-3"><i class="bi bi-arrow-left"></i> Về Dashboard</a>
    </div>
</div>
</body>
</html> 