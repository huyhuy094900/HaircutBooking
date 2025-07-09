<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý dịch vụ - Admin Dashboard</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        .admin-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .service-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .service-card:hover {
            transform: translateY(-5px);
        }
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stats-card h3 {
            color: #28a745;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .search-box {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .price-badge {
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body style="background-color: #f8f9fa;">
    <jsp:include page="AdminHeader.jsp"/>
    
    <!-- Admin Header -->
    <div class="admin-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class="bi bi-scissors"></i> Quản lý dịch vụ</h1>
                    <p class="lead mb-0">Quản lý các dịch vụ cắt tóc, giá cả, mô tả và trạng thái</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="AdminDashboardController" class="btn btn-light btn-lg">
                        <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container">
        <!-- Statistics -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-scissors" style="font-size: 3rem; color: #28a745;"></i>
                    <h3>${serviceCount}</h3>
                    <p class="text-muted">Tổng dịch vụ</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-check-circle" style="font-size: 3rem; color: #28a745;"></i>
                    <h3>${activeServiceCount}</h3>
                    <p class="text-muted">Dịch vụ Active</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-x-circle" style="font-size: 3rem; color: #dc3545;"></i>
                    <h3>${inactiveServiceCount}</h3>
                    <p class="text-muted">Dịch vụ Inactive</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-currency-dollar" style="font-size: 3rem; color: #ffc107;"></i>
                    <h3>$${totalRevenue}</h3>
                    <p class="text-muted">Tổng doanh thu</p>
                </div>
            </div>
        </div>
        
        <!-- Search and Filter -->
        <div class="search-box">
            <div class="row">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm theo tên dịch vụ...">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="statusFilter">
                        <option value="">Tất cả trạng thái</option>
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="priceFilter">
                        <option value="">Tất cả giá</option>
                        <option value="0-20">$0 - $20</option>
                        <option value="20-50">$20 - $50</option>
                        <option value="50-100">$50 - $100</option>
                        <option value="100+">$100+</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-success w-100" onclick="addNewService()">
                        <i class="bi bi-plus"></i> Thêm mới
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Services Table -->
        <div class="service-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4><i class="bi bi-table"></i> Danh sách dịch vụ</h4>
                <div>
                    <button class="btn btn-outline-success" onclick="exportServices()">
                        <i class="bi bi-download"></i> Xuất Excel
                    </button>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover" id="servicesTable">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên dịch vụ</th>
                            <th>Mô tả</th>
                            <th>Giá</th>
                            <th>Thời gian</th>
                            <th>Status</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allServices}" var="service">
                            <tr class="service-row" 
                                data-name="${service.name}" 
                                data-status="${service.serviceStatus ? 'Active' : 'Inactive'}"
                                data-price="${service.price}">
                                <td>${service.serviceId}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-2">
                                            <i class="bi bi-scissors" style="font-size: 1.5rem; color: #28a745;"></i>
                                        </div>
                                        <div>
                                            <strong>${service.name != null ? service.name : 'N/A'}</strong>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="text-muted">
                                        ${service.description != null ? service.description : 'Không có mô tả'}
                                    </span>
                                </td>
                                <td>
                                    <span class="price-badge">
                                        $${service.price != null ? service.price : '0'}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-info">
                                        <i class="bi bi-clock"></i>
                                        ${service.duration != null ? service.duration : '0'} phút
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${service.serviceStatus ? 'bg-success' : 'bg-danger'}">
                                        <i class="bi ${service.serviceStatus ? 'bi-check-circle' : 'bi-x-circle'}"></i>
                                        ${service.serviceStatus ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="service_detail?serviceId=${service.serviceId}" 
                                           class="btn btn-sm btn-info" title="Xem chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <button class="btn btn-sm btn-warning" 
                                                onclick="editService(${service.serviceId})" title="Chỉnh sửa">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <c:if test="${service.serviceStatus}">
                                            <button class="btn btn-sm btn-danger" 
                                                    onclick="deactivateService(${service.serviceId})" title="Vô hiệu hóa">
                                                <i class="bi bi-pause-circle"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${!service.serviceStatus}">
                                            <button class="btn btn-sm btn-success" 
                                                    onclick="activateService(${service.serviceId})" title="Kích hoạt">
                                                <i class="bi bi-play-circle"></i>
                                            </button>
                                        </c:if>
                                        <button class="btn btn-sm btn-outline-secondary" 
                                                onclick="showServiceDetails(${service.serviceId})" title="Thông tin">
                                            <i class="bi bi-info-circle"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Pagination -->
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <span class="text-muted">Hiển thị <span id="showingCount">0</span> trong tổng số ${serviceCount} dịch vụ</span>
            </div>
            <nav>
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="#">Trước</a></li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                </ul>
            </nav>
        </div>
    </div>
    
    <!-- Service Details Modal -->
    <div class="modal fade" id="serviceDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết dịch vụ</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="serviceDetailsContent">
                    <!-- Content will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add/Edit Service Modal -->
    <div class="modal fade" id="serviceFormModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="serviceFormTitle">Thêm dịch vụ mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="serviceForm">
                        <div class="mb-3">
                            <label for="serviceName" class="form-label">Tên dịch vụ</label>
                            <input type="text" class="form-control" id="serviceName" required>
                        </div>
                        <div class="mb-3">
                            <label for="serviceDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="serviceDescription" rows="3"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="servicePrice" class="form-label">Giá ($)</label>
                                    <input type="number" class="form-control" id="servicePrice" min="0" step="0.01" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="serviceDuration" class="form-label">Thời gian (phút)</label>
                                    <input type="number" class="form-control" id="serviceDuration" min="1" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="serviceStatus" class="form-label">Trạng thái</label>
                            <select class="form-select" id="serviceStatus">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-success" onclick="saveService()">Lưu</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search and filter functionality
        document.getElementById('searchInput').addEventListener('input', filterServices);
        document.getElementById('statusFilter').addEventListener('change', filterServices);
        document.getElementById('priceFilter').addEventListener('change', filterServices);
        
        function filterServices() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const priceFilter = document.getElementById('priceFilter').value;
            const rows = document.querySelectorAll('.service-row');
            let visibleCount = 0;
            
            rows.forEach(row => {
                const name = row.dataset.name.toLowerCase();
                const status = row.dataset.status;
                const price = parseFloat(row.dataset.price);
                
                const matchesSearch = name.includes(searchTerm);
                const matchesStatus = !statusFilter || status === statusFilter;
                const matchesPrice = !priceFilter || checkPriceRange(price, priceFilter);
                
                if (matchesSearch && matchesStatus && matchesPrice) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('showingCount').textContent = visibleCount;
        }
        
        function checkPriceRange(price, range) {
            switch(range) {
                case '0-20': return price >= 0 && price <= 20;
                case '20-50': return price > 20 && price <= 50;
                case '50-100': return price > 50 && price <= 100;
                case '100+': return price > 100;
                default: return true;
            }
        }
        
        function showServiceDetails(serviceId) {
            // Load service details via AJAX
            fetch(`service_detail?serviceId=${serviceId}`)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('serviceDetailsContent').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('serviceDetailsModal')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Không thể tải thông tin dịch vụ');
                });
        }
        
        function addNewService() {
            document.getElementById('serviceFormTitle').textContent = 'Thêm dịch vụ mới';
            document.getElementById('serviceForm').reset();
            new bootstrap.Modal(document.getElementById('serviceFormModal')).show();
        }
        
        function editService(serviceId) {
            document.getElementById('serviceFormTitle').textContent = 'Chỉnh sửa dịch vụ';
            // Load service data and populate form
            // This would typically involve an AJAX call to get service details
            new bootstrap.Modal(document.getElementById('serviceFormModal')).show();
        }
        
        function saveService() {
            // Save service functionality
            alert('Chức năng lưu dịch vụ sẽ được thêm sau');
        }
        
        function activateService(serviceId) {
            if (confirm('Bạn có chắc muốn kích hoạt dịch vụ này?')) {
                // Activate service functionality
                alert('Chức năng kích hoạt dịch vụ sẽ được thêm sau');
            }
        }
        
        function deactivateService(serviceId) {
            if (confirm('Bạn có chắc muốn vô hiệu hóa dịch vụ này?')) {
                // Deactivate service functionality
                alert('Chức năng vô hiệu hóa dịch vụ sẽ được thêm sau');
            }
        }
        
        function exportServices() {
            // Export services to Excel functionality
            alert('Chức năng xuất Excel sẽ được thêm sau');
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            filterServices();
        });
    </script>
</body>
</html> 