<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - Admin Dashboard</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --dark-color: #343a40;
            --light-color: #f8f9fa;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        .admin-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 40px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .admin-header h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .admin-header .lead {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .search-box {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border: none;
        }

        .search-box .form-control,
        .search-box .form-select {
            border-radius: 12px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-box .form-control:focus,
        .search-box .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .search-box .input-group-text {
            border-radius: 12px 0 0 12px;
            border: 2px solid #e9ecef;
            border-right: none;
            background: #f8f9fa;
        }

        .user-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            border: none;
        }

        .user-card h4 {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 20px;
        }

        .table {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .table thead th {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border: none;
            padding: 20px 15px;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
        }

        .table tbody td {
            padding: 20px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            margin-right: 15px;
        }

        .user-info h6 {
            margin: 0;
            font-weight: 600;
            color: var(--dark-color);
        }

        .user-info small {
            color: #6c757d;
            font-size: 0.85rem;
        }

        .badge {
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-group .btn {
            border-radius: 8px;
            margin: 0 2px;
            padding: 8px 12px;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .btn-group .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .btn-light {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border: none;
            border-radius: 12px;
            color: var(--dark-color);
            font-weight: 600;
            padding: 12px 20px;
            transition: all 0.3s ease;
        }

        .btn-light:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .empty-state h4 {
            margin-bottom: 10px;
            color: #495057;
        }

        .loading-spinner {
            display: none;
            text-align: center;
            padding: 40px;
        }

        .spinner-border {
            width: 3rem;
            height: 3rem;
            color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .admin-header h1 {
                font-size: 2rem;
            }
            
            .table-responsive {
                border-radius: 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="AdminHeader.jsp"/>
    
    <!-- Admin Header -->
    <div class="admin-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class="bi bi-people-fill"></i> Quản lý người dùng</h1>
                    <p class="lead mb-0">Quản lý tài khoản người dùng, ban/unban, xem thông tin chi tiết</p>
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
        <!-- Search and Filter -->
        <div class="search-box">
            <div class="row">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm theo tên, email...">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="statusFilter">
                        <option value="">Tất cả trạng thái</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="roleFilter">
                        <option value="">Tất cả vai trò</option>
                        <option value="admin">Admin</option>
                        <option value="user">User</option>
                    </select>
                </div>
            </div>
        </div>
        
        <!-- Loading Spinner -->
        <div class="loading-spinner" id="loadingSpinner">
            <div class="spinner-border" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <p class="mt-3">Đang tải dữ liệu...</p>
        </div>
        
        <!-- Users Table -->
        <div class="user-card" id="usersTableContainer">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4><i class="bi bi-table"></i> Danh sách người dùng</h4>
                <div>
                    <span class="badge bg-primary">${userCount} người dùng</span>
                </div>
            </div>
            
            <c:if test="${empty allUsers}">
                <div class="empty-state">
                    <i class="bi bi-people"></i>
                    <h4>Không có người dùng nào</h4>
                    <p>Danh sách người dùng hiện tại đang trống.</p>
                    <a href="userdebug" class="btn btn-primary">
                        <i class="bi bi-bug"></i> Debug Users
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty allUsers}">
                <div class="table-responsive">
                    <table class="table table-hover" id="usersTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Thông tin</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${allUsers}" var="user">
                                <tr class="user-row" 
                                    data-name="${user.fullName}" 
                                    data-email="${user.email}"
                                    data-status="${user.userStatus ? 'active' : 'inactive'}"
                                    data-role="${user.admin ? 'admin' : 'user'}">
                                    <td>
                                        <span class="badge bg-secondary">#${user.userId}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="user-avatar">
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div class="user-info">
                                                <h6>${user.fullName != null ? user.fullName : 'N/A'}</h6>
                                                <small>@${user.userName != null ? user.userName : 'N/A'}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <i class="bi bi-envelope text-muted me-2"></i>
                                        ${user.email != null ? user.email : 'N/A'}
                                    </td>
                                    <td>
                                        <i class="bi bi-telephone text-muted me-2"></i>
                                        ${user.phone != null ? user.phone : 'N/A'}
                                    </td>
                                    <td>
                                        <span class="badge ${user.admin ? 'bg-primary' : 'bg-secondary'}">
                                            <i class="bi ${user.admin ? 'bi-shield-check' : 'bi-person'}"></i>
                                            ${user.admin ? 'Admin' : 'User'}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${user.userStatus ? 'bg-success' : 'bg-danger'}">
                                            <i class="bi ${user.userStatus ? 'bi-check-circle' : 'bi-x-circle'}"></i>
                                            ${user.userStatus ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <i class="bi bi-calendar3 me-1"></i>
                                            ${user.createdAt != null ? user.createdAt : 'N/A'}
                                        </small>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="user_detail_for_admin?userID=${user.userId}" 
                                               class="btn btn-sm btn-info" title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <c:if test="${user.userStatus && !user.admin}">
                                                <a href="ban_user?userID=${user.userId}" 
                                                   class="btn btn-sm btn-warning" title="Ban user"
                                                   onclick="return confirm('Bạn có chắc muốn ban user này?')">
                                                    <i class="bi bi-person-x"></i>
                                                </a>
                                            </c:if>
                                            <c:if test="${!user.userStatus && !user.admin}">
                                                <a href="unban_user?userID=${user.userId}" 
                                                   class="btn btn-sm btn-success" title="Unban user"
                                                   onclick="return confirm('Bạn có chắc muốn unban user này?')">
                                                    <i class="bi bi-person-check"></i>
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search and Filter functionality
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const statusFilter = document.getElementById('statusFilter');
            const roleFilter = document.getElementById('roleFilter');
            const userRows = document.querySelectorAll('.user-row');
            
            function filterUsers() {
                const searchTerm = searchInput.value.toLowerCase();
                const statusValue = statusFilter.value;
                const roleValue = roleFilter.value;
                
                userRows.forEach(row => {
                    const name = row.getAttribute('data-name').toLowerCase();
                    const email = row.getAttribute('data-email').toLowerCase();
                    const status = row.getAttribute('data-status');
                    const role = row.getAttribute('data-role');
                    
                    const matchesSearch = name.includes(searchTerm) || email.includes(searchTerm);
                    const matchesStatus = !statusValue || status === statusValue;
                    const matchesRole = !roleValue || role === roleValue;
                    
                    if (matchesSearch && matchesStatus && matchesRole) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
            
            searchInput.addEventListener('input', filterUsers);
            statusFilter.addEventListener('change', filterUsers);
            roleFilter.addEventListener('change', filterUsers);
            
            // Add active class to current menu item
            const currentUrl = window.location.href;
            if (currentUrl.includes('action=users')) {
                document.querySelector('a[href="admin?action=users"]').classList.add('active');
            }
        });
    </script>
</body>
</html> 