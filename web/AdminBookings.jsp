<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt lịch - Admin Dashboard</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); min-height: 100vh; }
        .admin-header { background: linear-gradient(135deg, #20c997 0%, #0dcaf0 100%); color: white; padding: 40px 0; margin-bottom: 30px; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .admin-header h1 { font-weight: 700; font-size: 2.5rem; margin-bottom: 10px; }
        .admin-header .lead { font-size: 1.1rem; opacity: 0.9; }
        .stats-card { background: white; border-radius: 20px; padding: 32px 24px; min-width: 220px; box-shadow: 0 8px 32px rgba(13,202,240,0.10), 0 1.5px 6px rgba(0,0,0,0.04); border: 1.5px solid #e6f4ea; margin-bottom: 16px; text-align: center; }
        .stats-card .icon-badge { display: flex; align-items: center; justify-content: center; width: 56px; height: 56px; border-radius: 50%; background: linear-gradient(135deg, #e6f4ea 0%, #f0fff7 100%); margin: 0 auto 12px auto; }
        .stats-card i { font-size: 2rem !important; }
        .stats-card h3 { font-size: 2.2rem; margin: 10px 0 8px 0; font-weight: 700; color: #222; }
        .stats-card p { font-size: 1.05rem; color: #666; margin-bottom: 0; letter-spacing: 0.01em; }
        .search-box { background: white; border-radius: 15px; padding: 25px; margin-bottom: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .booking-card { background: white; border-radius: 20px; padding: 30px; margin-bottom: 25px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); border: none; }
        .table thead th { background: #20c997; color: white; font-weight: 600; }
        .badge { padding: 8px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        .btn-group .btn { border-radius: 8px; margin: 0 2px; padding: 8px 12px; font-size: 0.85rem; transition: all 0.3s ease; }
        .btn-group .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
        .btn-light { background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border: none; border-radius: 12px; color: #222; font-weight: 600; padding: 12px 20px; transition: all 0.3s ease; }
        .btn-light:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
        .empty-state { text-align: center; padding: 60px 20px; color: #6c757d; }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; color: #dee2e6; }
        .empty-state h4 { margin-bottom: 10px; color: #495057; }
        @media (max-width: 768px) { .admin-header h1 { font-size: 2rem; } .table-responsive { border-radius: 15px; } }
    </style>
</head>
<body>
<jsp:include page="AdminHeader.jsp"/>
<!-- Admin Header -->
<div class="admin-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="bi bi-calendar-check"></i> Quản lý đặt lịch</h1>
                <p class="lead mb-0">Quản lý các lịch đặt, xác nhận, hủy và xem chi tiết đặt lịch của khách hàng</p>
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
    <!-- Statistics -->
    <div class="d-flex justify-content-center gap-4 mb-4 flex-wrap">
        <div class="stats-card">
            <div class="icon-badge"><i class="bi bi-calendar-check" style="color: #20c997;"></i></div>
            <h3>${bookingCount}</h3>
            <p>Tổng đặt lịch</p>
        </div>
        <div class="stats-card">
            <div class="icon-badge"><i class="bi bi-hourglass-split" style="color: #ffc107;"></i></div>
            <h3>${pendingBookingCount}</h3>
            <p>Chờ xác nhận</p>
        </div>
        <div class="stats-card">
            <div class="icon-badge"><i class="bi bi-check-circle" style="color: #198754;"></i></div>
            <h3>${confirmedBookingCount}</h3>
            <p>Đã xác nhận</p>
        </div>
        <div class="stats-card">
            <div class="icon-badge"><i class="bi bi-cash-coin" style="color: #fd7e14;"></i></div>
            <h3><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/> VND</h3>
            <p>Tổng doanh thu</p>
        </div>
    </div>
    <!-- Search and Filter -->
    <div class="search-box">
        <div class="row">
            <div class="col-md-4 mb-2">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm theo tên khách, dịch vụ, nhân viên...">
                </div>
            </div>
            <div class="col-md-3 mb-2">
                <select class="form-select" id="statusFilter">
                    <option value="">Tất cả trạng thái</option>
                    <option value="Pending">Chờ xác nhận</option>
                    <option value="Confirmed">Đã xác nhận</option>
                    <option value="Completed">Hoàn thành</option>
                    <option value="Cancelled">Đã hủy</option>
                </select>
            </div>
            <div class="col-md-3 mb-2">
                <select class="form-select" id="serviceFilter">
                    <option value="">Tất cả dịch vụ</option>
                    <c:forEach items="${allServices}" var="service">
                        <option value="${service.serviceId}">${service.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-2 mb-2">
                <select class="form-select" id="staffFilter">
                    <option value="">Tất cả nhân viên</option>
                    <c:forEach items="${allStaff}" var="staff">
                        <option value="${staff.staffId}">${staff.staffName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <!-- Bookings Table -->
    <div class="booking-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4><i class="bi bi-table"></i> Danh sách đặt lịch</h4>
            <div>
                <span class="badge bg-primary">${bookingCount} đặt lịch</span>
            </div>
        </div>
        <c:if test="${empty allBookings}">
            <div class="empty-state">
                <i class="bi bi-calendar-x"></i>
                <h4>Không có đặt lịch nào</h4>
                <p>Danh sách đặt lịch hiện tại đang trống.</p>
            </div>
        </c:if>
        <c:if test="${not empty allBookings}">
            <div class="table-responsive">
                <table class="table table-hover" id="bookingsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Khách hàng</th>
                            <th>Dịch vụ</th>
                            <th>Nhân viên</th>
                            <th>Ngày đặt</th>
                            <th>Ca</th>
                            <th>Trạng thái</th>
                            <th>Tổng tiền</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allBookings}" var="booking">
                            <tr class="booking-row"
                                data-status="${booking.status}"
                                data-service="${booking.service != null ? booking.service.name : ''}"
                                data-staff="${booking.staff != null ? booking.staff.staffName : ''}">
                                <td><span class="badge bg-secondary">#${booking.bookingId}</span></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-person-circle me-2"></i>
                                        <span>${booking.user != null ? booking.user.fullName : 'N/A'}</span>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-info">${booking.service != null ? booking.service.name : 'N/A'}</span>
                                </td>
                                <td>
                                    <span class="badge bg-dark">${booking.staff != null ? booking.staff.staffName : 'N/A'}</span>
                                </td>
                                <td>
                                    <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark">${booking.shift != null ? booking.shift.shiftName : 'N/A'}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.status eq 'Pending'}">
                                            <span class="badge bg-warning text-dark">${booking.status}</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'Confirmed'}">
                                            <span class="badge bg-primary">${booking.status}</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'Completed'}">
                                            <span class="badge bg-success">${booking.status}</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'Cancelled'}">
                                            <span class="badge bg-danger">${booking.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${booking.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${booking.totalPrice}" type="number" groupingUsed="true"/> VND
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <button class="btn btn-sm btn-info" title="Xem chi tiết" data-bs-toggle="modal" data-bs-target="#bookingDetailModal" onclick="showBookingDetail(${booking.bookingId})">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                        <c:if test="${booking.status eq 'Pending'}">
                                            <button class="btn btn-sm btn-success" title="Xác nhận" onclick="confirmBooking(${booking.bookingId})">
                                                <i class="bi bi-check-circle"></i>
                                            </button>
                                            <button class="btn btn-sm btn-danger" title="Hủy" onclick="cancelBooking(${booking.bookingId})">
                                                <i class="bi bi-x-circle"></i>
                                            </button>
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
<!-- Booking Detail Modal -->
<div class="modal fade" id="bookingDetailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chi tiết đặt lịch</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="bookingDetailContent">
                <!-- Nội dung chi tiết sẽ được load bằng JS -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
// TODO: Thêm JS filter, search, showBookingDetail, confirmBooking, cancelBooking nếu cần
</script>
</body>
</html> 