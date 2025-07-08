<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tất cả lịch hẹn - ${staff.staffName}</title>
    
    <!-- Bootstrap CSS -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="assets/css/main.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        
        .navbar-brand {
            font-weight: 600;
        }
        
        .main-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .booking-row {
            transition: transform 0.3s ease;
        }
        
        .booking-row:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .status-badge {
            font-size: 0.8rem;
            padding: 0.5rem 1rem;
        }
        
        .filter-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stats-summary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
<% 
    out.println("DEBUG: staff=" + request.getAttribute("staff"));
    out.println("DEBUG: allBookings=" + request.getAttribute("allBookings"));
    out.println("DEBUG: error=" + request.getAttribute("error"));
%>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="StaffDashboardController">
                <i class="bi bi-person-badge"></i> Staff Portal
            </a>
            
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="bi bi-person-circle"></i> ${staff.staffName}
                </span>
                <a class="nav-link" href="StaffLoginController?action=logout">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2><i class="bi bi-calendar3"></i> Tất cả lịch hẹn</h2>
                <p class="text-muted mb-0">Quản lý tất cả lịch hẹn của bạn</p>
            </div>
        </div>

        <!-- Statistics Summary -->
        <div class="stats-summary">
            <div class="row text-center">
                <div class="col-md-3">
                    <h3>${bookingCount}</h3>
                    <p class="mb-0">Tổng lịch hẹn</p>
                </div>
                <div class="col-md-3">
                    <h3 id="pendingCount">0</h3>
                    <p class="mb-0">Chờ xác nhận</p>
                </div>
                <div class="col-md-3">
                    <h3 id="confirmedCount">0</h3>
                    <p class="mb-0">Đã xác nhận</p>
                </div>
                <div class="col-md-3">
                    <h3 id="completedCount">0</h3>
                    <p class="mb-0">Đã hoàn thành</p>
                </div>
            </div>
        </div>

        <!-- Filters -->
        <div class="filter-section">
            <div class="row">
                <div class="col-md-4">
                    <label for="searchInput" class="form-label">Tìm kiếm</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Tên khách hàng, email...">
                </div>
                <div class="col-md-3">
                    <label for="statusFilter" class="form-label">Trạng thái</label>
                    <select class="form-select" id="statusFilter">
                        <option value="">Tất cả</option>
                        <option value="Pending">Chờ xác nhận</option>
                        <option value="Confirmed">Đã xác nhận</option>
                        <option value="Completed">Đã hoàn thành</option>
                        <option value="Canceled">Đã hủy</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="dateFilter" class="form-label">Ngày</label>
                    <input type="date" class="form-control" id="dateFilter">
                </div>
                <div class="col-md-2">
                    <label class="form-label">&nbsp;</label>
                    <button class="btn btn-outline-secondary w-100" onclick="clearFilters()">
                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                    </button>
                </div>
            </div>
        </div>

        <!-- Bookings Table -->
        <div class="main-card">
            <div class="p-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Danh sách lịch hẹn</h4>
                    <span class="text-muted">Hiển thị <span id="showingCount">0</span> / ${bookingCount} lịch hẹn</span>
                </div>

                <c:if test="${empty allBookings}">
                    <div class="text-center py-5">
                        <i class="bi bi-calendar-x" style="font-size: 4rem; color: #ccc;"></i>
                        <h5 class="mt-3 text-muted">Chưa có lịch hẹn nào</h5>
                        <p class="text-muted">Bạn sẽ thấy các lịch hẹn ở đây khi có khách hàng đặt lịch</p>
                    </div>
                </c:if>

                <c:if test="${not empty allBookings}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Khách hàng</th>
                                    <th>Dịch vụ</th>
                                    <th>Ngày</th>
                                    <th>Giờ</th>
                                    <th>Trạng thái</th>
                                    <th>Ghi chú</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${allBookings}" var="booking">
                                    <tr class="booking-row" 
                                        data-customer="${booking.user.fullName}" 
                                        data-email="${booking.user.email}"
                                        data-status="${booking.status}"
                                        data-date="${booking.bookingDate}">
                                        <td>${booking.bookingId}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center me-2" 
                                                     style="width: 35px; height: 35px;">
                                                    <i class="bi bi-person"></i>
                                                </div>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.user}">
                                                            <strong>${booking.user.fullName}</strong>
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose><br>
                                                    <c:choose>
                                                        <c:when test="${not empty booking.user}">
                                                            <small class="text-muted">${booking.user.email}</small>
                                                        </c:when>
                                                        <c:otherwise><small class="text-muted">N/A</small></c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty booking.service}">
                                                    <span class="badge bg-info"><i class="bi bi-scissors"></i> ${booking.service.name}</span>
                                                </c:when>
                                                <c:otherwise><span class="badge bg-secondary">N/A</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty booking.bookingDate}">
                                                    <strong>${booking.bookingDate}</strong>
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty booking.shift}">
                                                    <i class="bi bi-clock"></i> ${booking.shift.startTime} - ${booking.shift.endTime}
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge status-badge 
                                                <c:choose>
                                                    <c:when test="${booking.status == 'Pending'}">bg-warning</c:when>
                                                    <c:when test="${booking.status == 'Confirmed'}">bg-info</c:when>
                                                    <c:when test="${booking.status == 'Completed'}">bg-success</c:when>
                                                    <c:when test="${booking.status == 'Canceled'}">bg-danger</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>">
                                                ${booking.status}
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${not empty booking.note}">
                                                <span class="text-muted" title="${booking.note}">
                                                    <i class="bi bi-chat-text"></i>
                                                    ${booking.note.length() > 20 ? booking.note.substring(0, 20) + '...' : booking.note}
                                                </span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <c:if test="${booking.status == 'Pending'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Confirmed')" title="Xác nhận">
                                                        <i class="bi bi-check"></i>
                                                    </button>
                                                </c:if>
                                                <c:if test="${booking.status == 'Confirmed'}">
                                                    <button class="btn btn-success btn-sm" onclick="updateStatus(${booking.bookingId}, 'Completed')" title="Hoàn thành">
                                                        <i class="bi bi-check-circle"></i>
                                                    </button>
                                                </c:if>
                                                <a class="btn btn-info btn-sm" href="BookingDetailController?id=${booking.bookingId}" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
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
    </div>

    <!-- Bootstrap JS -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Search and filter functionality
        document.getElementById('searchInput').addEventListener('input', filterBookings);
        document.getElementById('statusFilter').addEventListener('change', filterBookings);
        document.getElementById('dateFilter').addEventListener('change', filterBookings);
        
        function filterBookings() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            const dateFilter = document.getElementById('dateFilter').value;
            const rows = document.querySelectorAll('.booking-row');
            let visibleCount = 0;
            let pendingCount = 0;
            let confirmedCount = 0;
            let completedCount = 0;
            
            rows.forEach(row => {
                const customer = row.dataset.customer.toLowerCase();
                const email = row.dataset.email.toLowerCase();
                const status = row.dataset.status;
                const date = row.dataset.date;
                
                const matchesSearch = customer.includes(searchTerm) || email.includes(searchTerm);
                const matchesStatus = !statusFilter || status === statusFilter;
                const matchesDate = !dateFilter || date === dateFilter;
                
                if (matchesSearch && matchesStatus && matchesDate) {
                    row.style.display = '';
                    visibleCount++;
                    
                    // Count by status
                    if (status === 'Pending') pendingCount++;
                    else if (status === 'Confirmed') confirmedCount++;
                    else if (status === 'Completed') completedCount++;
                } else {
                    row.style.display = 'none';
                }
            });
            
            document.getElementById('showingCount').textContent = visibleCount;
            document.getElementById('pendingCount').textContent = pendingCount;
            document.getElementById('confirmedCount').textContent = confirmedCount;
            document.getElementById('completedCount').textContent = completedCount;
        }
        
        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('statusFilter').value = '';
            document.getElementById('dateFilter').value = '';
            filterBookings();
        }
        
        function updateStatus(bookingId, status) {
            if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'StaffDashboardController';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'updateStatus';
                form.appendChild(actionInput);
                
                const bookingInput = document.createElement('input');
                bookingInput.type = 'hidden';
                bookingInput.name = 'bookingId';
                bookingInput.value = bookingId;
                form.appendChild(bookingInput);
                
                const statusInput = document.createElement('input');
                statusInput.type = 'hidden';
                statusInput.name = 'status';
                statusInput.value = status;
                form.appendChild(statusInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function viewDetails(bookingId) {
            // You can implement a modal or redirect to a details page
            alert('Chi tiết lịch hẹn ID: ' + bookingId);
        }
        
        // Initialize counts on page load
        document.addEventListener('DOMContentLoaded', function() {
            filterBookings();
        });
    </script>
</body>
</html> 