<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên - Admin Dashboard</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        .admin-header {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .staff-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .staff-card:hover {
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
            color: #ffc107;
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
        .staff-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(45deg, #ffc107, #fd7e14);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
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
                    <h1><i class="bi bi-person-badge"></i> Quản lý nhân viên</h1>
                    <p class="lead mb-0">Quản lý thông tin nhân viên, lịch làm việc và phân công</p>
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
                    <i class="bi bi-person-badge" style="font-size: 3rem; color: #ffc107;"></i>
                    <h3>${staffCount}</h3>
                    <p class="text-muted">Tổng nhân viên</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-person-check" style="font-size: 3rem; color: #28a745;"></i>
                    <h3>${activeStaffCount}</h3>
                    <p class="text-muted">Nhân viên Active</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-person-x" style="font-size: 3rem; color: #dc3545;"></i>
                    <h3>${inactiveStaffCount}</h3>
                    <p class="text-muted">Nhân viên Inactive</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-calendar-check" style="font-size: 3rem; color: #17a2b8;"></i>
                    <h3>${totalBookings}</h3>
                    <p class="text-muted">Tổng đặt lịch</p>
                </div>
            </div>
        </div>
        
        <!-- Search and Filter -->
        <div class="search-box">
            <div class="row">
                <div class="col-md-4">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm theo tên, email...">
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
                    <select class="form-select" id="positionFilter">
                        <option value="">Tất cả vị trí</option>
                        <option value="Stylist">Stylist</option>
                        <option value="Manager">Manager</option>
                        <option value="Assistant">Assistant</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button class="btn btn-warning w-100" onclick="addNewStaff()">
                        <i class="bi bi-plus"></i> Thêm mới
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Staff Table -->
        <div class="staff-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4><i class="bi bi-table"></i> Danh sách nhân viên</h4>
                <div>
                    <button class="btn btn-outline-warning" onclick="exportStaff()">
                        <i class="bi bi-download"></i> Xuất Excel
                    </button>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover" id="staffTable">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nhân viên</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Vị trí</th>
                            <th>Status</th>
                            <th>Lịch làm việc</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allStaff}" var="staff">
                            <tr class="staff-row" 
                                data-name="${staff.staffName}" 
                                data-email="${staff.staffEmail}"
                                data-status="${staff.staffStatus ? 'Active' : 'Inactive'}"
                                data-position="${staff.staffPosition}">
                                <td>${staff.staffId}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="staff-avatar me-2">
                                            ${staff.staffName != null ? staff.staffName.charAt(0).toUpperCase() : 'N'}
                                        </div>
                                        <div>
                                            <strong>${staff.staffName != null ? staff.staffName : 'N/A'}</strong>
                                            <br>
                                            <small class="text-muted">ID: ${staff.staffId}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>${staff.staffEmail != null ? staff.staffEmail : 'N/A'}</td>
                                <td>${staff.staffPhone != null ? staff.staffPhone : 'N/A'}</td>
                                <td>
                                    <span class="badge bg-info">
                                        <i class="bi bi-briefcase"></i>
                                        ${staff.staffPosition != null ? staff.staffPosition : 'N/A'}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge ${staff.staffStatus ? 'bg-success' : 'bg-danger'}">
                                        <i class="bi ${staff.staffStatus ? 'bi-check-circle' : 'bi-x-circle'}"></i>
                                        ${staff.staffStatus ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" 
                                            onclick="viewSchedule(${staff.staffId})" title="Xem lịch">
                                        <i class="bi bi-calendar3"></i> Lịch
                                    </button>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-sm btn-info" 
                                                onclick="viewStaffDetails(${staff.staffId})" title="Xem chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                        <button class="btn btn-sm btn-warning" 
                                                onclick="editStaff(${staff.staffId})" title="Chỉnh sửa">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <c:if test="${staff.staffStatus}">
                                            <button class="btn btn-sm btn-danger" 
                                                    onclick="deactivateStaff(${staff.staffId})" title="Vô hiệu hóa">
                                                <i class="bi bi-pause-circle"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${!staff.staffStatus}">
                                            <button class="btn btn-sm btn-success" 
                                                    onclick="activateStaff(${staff.staffId})" title="Kích hoạt">
                                                <i class="bi bi-play-circle"></i>
                                            </button>
                                        </c:if>
                                        <button class="btn btn-sm btn-outline-secondary" 
                                                onclick="showStaffInfo(${staff.staffId})" title="Thông tin">
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
                <span class="text-muted">Hiển thị <span id="showingCount">0</span> trong tổng số ${staffCount} nhân viên</span>
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
    
    <!-- Staff Details Modal -->
    <div class="modal fade" id="staffDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết nhân viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="staffDetailsContent">
                    <!-- Content will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Staff Schedule Modal -->
    <div class="modal fade" id="staffScheduleModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Lịch làm việc nhân viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="staffScheduleContent">
                    <!-- Schedule content will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add/Edit Staff Modal -->
    <div class="modal fade" id="staffFormModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staffFormTitle">Thêm nhân viên mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="staffForm">
                        <div class="mb-3">
                            <label for="staffName" class="form-label">Tên nhân viên</label>
                            <input type="text" class="form-control" id="staffName" required>
                        </div>
                        <div class="mb-3">
                            <label for="staffEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="staffEmail" required>
                        </div>
                        <div class="mb-3">
                            <label for="staffPhone" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="staffPhone" required>
                        </div>
                        <div class="mb-3">
                            <label for="staffPosition" class="form-label">Vị trí</label>
                            <select class="form-select" id="staffPosition" required>
                                <option value="">Chọn vị trí</option>
                                <option value="Stylist">Stylist</option>
                                <option value="Manager">Manager</option>
                                <option value="Assistant">Assistant</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="staffStatus" class="form-label">Trạng thái</label>
                            <select class="form-select" id="staffStatus">
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-warning" onclick="saveStaff()">Lưu</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search and filter functionality
        document.getElementById('searchInput').addEventListener('input', filterStaff);
        document.getElementById('statusFilter').addEventListener('change', filterStaff);
        document.getElementById('positionFilter').addEventListener('change', filterStaff);
        
        function filterStaff() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const positionFilter = document.getElementById('positionFilter').value;
            const rows = document.querySelectorAll('.staff-row');
            let visibleCount = 0;
            
            rows.forEach(row => {
                const name = row.dataset.name.toLowerCase();
                const email = row.dataset.email.toLowerCase();
                const status = row.dataset.status;
                const position = row.dataset.position;
                
                const matchesSearch = name.includes(searchTerm) || email.includes(searchTerm);
                const matchesStatus = !statusFilter || status === statusFilter;
                const matchesPosition = !positionFilter || position === positionFilter;
                
                if (matchesSearch && matchesStatus && matchesPosition) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('showingCount').textContent = visibleCount;
        }
        
        function viewStaffDetails(staffId) {
            // Load staff details via AJAX
            fetch(`AdminSetupController?action=viewStaff&staffId=${staffId}`)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('staffDetailsContent').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('staffDetailsModal')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Không thể tải thông tin nhân viên');
                });
        }
        
        function viewSchedule(staffId) {
            // Load staff schedule via AJAX
            fetch(`AdminSetupController?action=viewSchedule&staffId=${staffId}`)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('staffScheduleContent').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('staffScheduleModal')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Không thể tải lịch làm việc');
                });
        }
        
        function addNewStaff() {
            document.getElementById('staffFormTitle').textContent = 'Thêm nhân viên mới';
            document.getElementById('staffForm').reset();
            new bootstrap.Modal(document.getElementById('staffFormModal')).show();
        }
        
        function editStaff(staffId) {
            document.getElementById('staffFormTitle').textContent = 'Chỉnh sửa nhân viên';
            // Load staff data and populate form
            new bootstrap.Modal(document.getElementById('staffFormModal')).show();
        }
        
        function saveStaff() {
            // Save staff functionality
            alert('Chức năng lưu nhân viên sẽ được thêm sau');
        }
        
        function activateStaff(staffId) {
            if (confirm('Bạn có chắc muốn kích hoạt nhân viên này?')) {
                // Activate staff functionality
                alert('Chức năng kích hoạt nhân viên sẽ được thêm sau');
            }
        }
        
        function deactivateStaff(staffId) {
            if (confirm('Bạn có chắc muốn vô hiệu hóa nhân viên này?')) {
                // Deactivate staff functionality
                alert('Chức năng vô hiệu hóa nhân viên sẽ được thêm sau');
            }
        }
        
        function showStaffInfo(staffId) {
            // Show additional staff information
            alert('Thông tin chi tiết nhân viên sẽ được hiển thị');
        }
        
        function exportStaff() {
            // Export staff to Excel functionality
            alert('Chức năng xuất Excel sẽ được thêm sau');
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            filterStaff();
        });
    </script>
</body>
</html> 