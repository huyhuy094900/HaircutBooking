<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt lịch - Admin Dashboard</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        .admin-header {
            background: linear-gradient(135deg, #dc3545 0%, #e83e8c 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .booking-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .booking-card:hover {
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
            color: #dc3545;
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
        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
        }
        .status-pending { background: #ffc107; color: #000; }
        .status-confirmed { background: #28a745; color: #fff; }
        .status-completed { background: #17a2b8; color: #fff; }
        .status-cancelled { background: #dc3545; color: #fff; }
    </style>
</head>
<body style="background-color: #f8f9fa;">
    <jsp:include page="AdminHeader.jsp"/>
    
    <!-- Admin Header -->
    <div class="admin-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1><i class="bi bi-calendar-check"></i> Quản lý đặt lịch</h1>
                    <p class="lead mb-0">Quản lý tất cả đặt lịch, xác nhận, hủy bỏ và theo dõi trạng thái</p>
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
                    <i class="bi bi-calendar-check" style="font-size: 3rem; color: #dc3545;"></i>
                    <h3>${bookingCount}</h3>
                    <p class="text-muted">Tổng đặt lịch</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-clock" style="font-size: 3rem; color: #ffc107;"></i>
                    <h3>${pendingBookingCount}</h3>
                    <p class="text-muted">Chờ xác nhận</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-check-circle" style="font-size: 3rem; color: #28a745;"></i>
                    <h3>${confirmedBookingCount}</h3>
                    <p class="text-muted">Đã xác nhận</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="bi bi-currency-dollar" style="font-size: 3rem; color: #17a2b8;"></i>
                    <h3><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" /> VND</h3>
                    <p class="text-muted">Tổng doanh thu</p>
                </div>
            </div>
        </div>
        
        <!-- Search and Filter -->
        <div class="search-box">
            <div class="row">
                <div class="col-md-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm theo tên khách hàng...">
                    </div>
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="statusFilter">
                        <option value="">Tất cả trạng thái</option>
                        <option value="Pending">Chờ xác nhận</option>
                        <option value="Confirmed">Đã xác nhận</option>
                        <option value="Completed">Hoàn thành</option>
                        <option value="Cancelled">Đã hủy</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="date" class="form-control" id="dateFilter" placeholder="Chọn ngày">
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="serviceFilter">
                        <option value="">Tất cả dịch vụ</option>
                        <c:forEach items="${allServices}" var="service">
                            <option value="${service.serviceId}">${service.name} - <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" /> VND</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="staffFilter">
                        <option value="">Tất cả nhân viên</option>
                        <c:forEach items="${allStaff}" var="staff">
                            <option value="${staff.staffId}">${staff.staffName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-1">
                    <button class="btn btn-danger w-100" onclick="createNewBooking()">
                        <i class="bi bi-plus"></i>
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Bookings Table -->
        <div class="booking-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4><i class="bi bi-table"></i> Danh sách đặt lịch</h4>
                <div>
                    <button class="btn btn-outline-danger" onclick="exportBookings()">
                        <i class="bi bi-download"></i> Xuất Excel
                    </button>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-hover" id="bookingsTable">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Khách hàng</th>
                            <th>Dịch vụ</th>
                            <th>Nhân viên</th>
                            <th>Ngày</th>
                            <th>Thời gian</th>
                            <th>Giá</th>
                            <th>Status</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allBookings}" var="booking">
                            <tr class="booking-row" 
                                data-customer="${booking.user.fullName}" 
                                data-service="${booking.service.serviceId}"
                                data-staff="${booking.staff.staffId}"
                                data-status="${booking.status}"
                                data-date="${booking.bookingDate}">
                                <td>${booking.bookingId}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="avatar me-2">
                                            <i class="bi bi-person-circle" style="font-size: 1.5rem; color: #dc3545;"></i>
                                        </div>
                                        <div>
                                            <strong>${booking.user.fullName != null ? booking.user.fullName : 'N/A'}</strong>
                                            <br>
                                            <small class="text-muted">${booking.user.email != null ? booking.user.email : 'N/A'}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-info">
                                        <i class="bi bi-scissors"></i>
                                        ${booking.service.name != null ? booking.service.name : 'N/A'}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-warning">
                                        <i class="bi bi-person-badge"></i>
                                        ${booking.staff.staffName != null ? booking.staff.staffName : 'N/A'}
                                    </span>
                                </td>
                                <td>
                                    <strong>${booking.bookingDate != null ? booking.bookingDate : 'N/A'}</strong>
                                </td>
                                <td>
                                    <span class="badge bg-secondary">
                                        <i class="bi bi-clock"></i>
                                        ${booking.shift.startTime != null ? booking.shift.startTime : 'N/A'} - 
                                        ${booking.shift.endTime != null ? booking.shift.endTime : 'N/A'}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge bg-success">
                                        <i class="bi bi-currency-dollar"></i>
                                        <fmt:formatNumber value="${booking.service.price}" type="number" groupingUsed="true" /> VND
                                    </span>
                                </td>
                                <td>
                                    <span class="status-badge status-${booking.status.toLowerCase()}">
                                        <i class="bi ${booking.status == 'Pending' ? 'bi-clock' : 
                                                      booking.status == 'Confirmed' ? 'bi-check-circle' : 
                                                      booking.status == 'Completed' ? 'bi-check2-all' : 'bi-x-circle'}"></i>
                                        ${booking.status != null ? booking.status : 'N/A'}
                                    </span>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-sm btn-info" 
                                                onclick="viewBookingDetails(${booking.bookingId})" title="Xem chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                        <c:if test="${booking.status == 'Pending'}">
                                            <button class="btn btn-sm btn-success" 
                                                    onclick="confirmBooking(${booking.bookingId})" title="Xác nhận">
                                                <i class="bi bi-check"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger" 
                                                    onclick="cancelBooking(${booking.bookingId})" title="Hủy">
                                                <i class="bi bi-x"></i>
                                            </button>
                                        </c:if>
                                        <c:if test="${booking.status == 'Confirmed'}">
                                            <button class="btn btn-sm btn-primary" 
                                                    onclick="completeBooking(${booking.bookingId})" title="Hoàn thành">
                                                <i class="bi bi-check2-all"></i>
                                            </button>
                                        </c:if>
                                        <button class="btn btn-sm btn-outline-secondary" 
                                                onclick="showBookingInfo(${booking.bookingId})" title="Thông tin">
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
                <span class="text-muted">Hiển thị <span id="showingCount">0</span> trong tổng số ${bookingCount} đặt lịch</span>
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
    
    <!-- Booking Details Modal -->
    <div class="modal fade" id="bookingDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Chi tiết đặt lịch</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="bookingDetailsContent">
                    <!-- Content will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Create Booking Modal -->
    <div class="modal fade" id="createBookingModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tạo đặt lịch mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="createBookingForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="customerSelect" class="form-label">Khách hàng</label>
                                    <select class="form-select" id="customerSelect" required>
                                        <option value="">Chọn khách hàng</option>
                                        <c:forEach items="${allUsers}" var="user">
                                            <option value="${user.userId}">${user.fullName} (${user.email})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="serviceSelect" class="form-label">Dịch vụ</label>
                                    <select class="form-select" id="serviceSelect" required>
                                        <option value="">Chọn dịch vụ</option>
                                        <c:forEach items="${allServices}" var="service">
                                            <option value="${service.serviceId}">${service.name} - <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" /> VND</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="staffSelect" class="form-label">Nhân viên</label>
                                    <select class="form-select" id="staffSelect" required>
                                        <option value="">Chọn nhân viên</option>
                                        <c:forEach items="${allStaff}" var="staff">
                                            <option value="${staff.staffId}">${staff.staffName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="bookingDate" class="form-label">Ngày đặt lịch</label>
                                    <input type="date" class="form-control" id="bookingDate" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="shiftSelect" class="form-label">Ca làm việc</label>
                                    <select class="form-select" id="shiftSelect" required>
                                        <option value="">Chọn ca</option>
                                        <option value="1">Sáng (8:00 - 12:00)</option>
                                        <option value="2">Chiều (13:00 - 17:00)</option>
                                        <option value="3">Tối (18:00 - 22:00)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="bookingStatus" class="form-label">Trạng thái</label>
                                    <select class="form-select" id="bookingStatus">
                                        <option value="Pending">Chờ xác nhận</option>
                                        <option value="Confirmed">Đã xác nhận</option>
                                        <option value="Completed">Hoàn thành</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" onclick="saveBooking()">Tạo đặt lịch</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search and filter functionality
        document.getElementById('searchInput').addEventListener('input', filterBookings);
        document.getElementById('statusFilter').addEventListener('change', filterBookings);
        document.getElementById('dateFilter').addEventListener('change', filterBookings);
        document.getElementById('serviceFilter').addEventListener('change', filterBookings);
        document.getElementById('staffFilter').addEventListener('change', filterBookings);
        
        function filterBookings() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;
            const serviceFilter = document.getElementById('serviceFilter').value;
            const staffFilter = document.getElementById('staffFilter').value;
            const rows = document.querySelectorAll('.booking-row');
            let visibleCount = 0;
            
            rows.forEach(row => {
                const customer = row.dataset.customer.toLowerCase();
                const status = row.dataset.status;
                const date = row.dataset.date;
                const service = row.dataset.service;
                const staff = row.dataset.staff;
                
                const matchesSearch = customer.includes(searchTerm);
                const matchesStatus = !statusFilter || status === statusFilter;
                const matchesDate = !dateFilter || date === dateFilter;
                const matchesService = !serviceFilter || service === serviceFilter;
                const matchesStaff = !staffFilter || staff === staffFilter;
                
                if (matchesSearch && matchesStatus && matchesDate && matchesService && matchesStaff) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('showingCount').textContent = visibleCount;
        }
        
        function viewBookingDetails(bookingId) {
            // Load booking details via AJAX
            fetch(`BookingController?action=viewDetails&bookingId=${bookingId}`)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('bookingDetailsContent').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('bookingDetailsModal')).show();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Không thể tải thông tin đặt lịch');
                });
        }
        
        function createNewBooking() {
            new bootstrap.Modal(document.getElementById('createBookingModal')).show();
        }
        
        function saveBooking() {
            // Save booking functionality
            alert('Chức năng tạo đặt lịch sẽ được thêm sau');
        }
        
        function confirmBooking(bookingId) {
            if (confirm('Bạn có chắc muốn xác nhận đặt lịch này?')) {
                // Confirm booking functionality
                alert('Chức năng xác nhận đặt lịch sẽ được thêm sau');
            }
        }
        
        function cancelBooking(bookingId) {
            if (confirm('Bạn có chắc muốn hủy đặt lịch này?')) {
                // Cancel booking functionality
                alert('Chức năng hủy đặt lịch sẽ được thêm sau');
            }
        }
        
        function completeBooking(bookingId) {
            if (confirm('Bạn có chắc muốn hoàn thành đặt lịch này?')) {
                // Complete booking functionality
                alert('Chức năng hoàn thành đặt lịch sẽ được thêm sau');
            }
        }
        
        function showBookingInfo(bookingId) {
            // Show additional booking information
            alert('Thông tin chi tiết đặt lịch sẽ được hiển thị');
        }
        
        function exportBookings() {
            // Export bookings to Excel functionality
            alert('Chức năng xuất Excel sẽ được thêm sau');
        }
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            filterBookings();
        });
    </script>
</body>
</html> 