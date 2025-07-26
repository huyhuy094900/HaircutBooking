<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .admin-header { background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%); color: white; padding: 30px 0; margin-bottom: 30px; }
        .staff-table-card { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); }
        .modal-header { background: #ffc107; color: #fff; }
        .btn-action { margin-right: 5px; }
    </style>
</head>
<body>
<jsp:include page="AdminHeader.jsp"/>
<div class="admin-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="bi bi-person-badge"></i> Quản lý nhân viên</h1>
                <p class="lead mb-0">Quản lý thông tin, trạng thái và thao tác với nhân viên</p>
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
    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <!-- Thanh tìm kiếm và lọc -->
    <form id="filterForm" method="get" action="admin">
        <input type="hidden" name="action" value="staff">
        <div class="row mb-3">
            <div class="col-md-4">
                <input type="text" class="form-control" name="search" placeholder="Tìm kiếm theo tên, email..." value="${search}" onchange="document.getElementById('filterForm').submit();">
            </div>
            <div class="col-md-3">
                <select class="form-select" name="status" onchange="document.getElementById('filterForm').submit();">
                    <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả trạng thái</option>
                    <option value="Active" <c:if test="${status == 'Active'}">selected</c:if>>Active</option>
                    <option value="Inactive" <c:if test="${status == 'Inactive'}">selected</c:if>>Inactive</option>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" name="position" onchange="document.getElementById('filterForm').submit();">
                    <option value="" <c:if test="${empty position}">selected</c:if>>Tất cả vị trí</option>
                    <option value="Stylist" <c:if test="${position == 'Stylist'}">selected</c:if>>Stylist</option>
                    <option value="Manager" <c:if test="${position == 'Manager'}">selected</c:if>>Manager</option>
                    <option value="Assistant" <c:if test="${position == 'Assistant'}">selected</c:if>>Assistant</option>
                </select>
            </div>
            <div class="col-md-2 text-end">
                <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#staffModal"><i class="bi bi-plus"></i> Thêm mới</button>
            </div>
        </div>
    </form>
    <!-- Bảng danh sách nhân viên -->
    <div class="staff-table-card mb-4">
        <table class="table table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên nhân viên</th>
                    <th>Email</th>
                    <th>Vị trí</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty allStaff}">
                        <c:forEach var="staff" items="${allStaff}">
                            <tr>
                                <td>${staff.staffId}</td>
                                <td>${staff.staffName}</td>
                                <td>${staff.staffEmail}</td>
                                <td>${empty staff.staffPosition ? '—' : staff.staffPosition}</td>
                                <td>
                                    <span class="badge ${staff.staffStatus ? 'bg-success' : 'bg-danger'}">
                                        ${staff.staffStatus ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-primary btn-sm btn-action" title="Sửa" data-bs-toggle="modal" data-bs-target="#staffModal"
                                        data-id="${staff.staffId}"
                                        data-name="${fn:replace(staff.staffName, '\'', '\\\'')}" 
                                        data-email="${fn:replace(staff.staffEmail, '\'', '\\\'')}" 
                                        data-position="${staff.staffPosition != null ? fn:replace(staff.staffPosition, '\'', '\\\'') : ''}"
                                        data-status="${staff.staffStatus ? 'Active' : 'Inactive'}"
                                        onclick="editStaffFromButton(this)">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <form method="post" action="AdminController" style="display:inline">
                                        <input type="hidden" name="action" value="toggleStaffStatus">
                                        <input type="hidden" name="id" value="${staff.staffId}">
                                        <button type="submit" class="btn btn-secondary btn-sm btn-action" title="Đổi trạng thái"><i class="bi bi-arrow-repeat"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6" class="text-center text-muted">Không có nhân viên nào được tìm thấy.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
<!-- Modal Thêm/Sửa nhân viên -->
<div class="modal fade" id="staffModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staffModalTitle">Thêm nhân viên</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="staffForm" method="post" action="AdminController">
                <div class="modal-body">
                    <input type="hidden" name="action" value="addStaff">
                    <input type="hidden" name="id" id="staffId">
                    <div class="mb-3">
                        <label class="form-label">Tên nhân viên</label>
                        <input type="text" class="form-control" name="name" id="staffName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" id="staffEmail" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Vị trí</label>
                        <select class="form-select" name="position" id="staffPosition" required>
                            <option value="">Chọn vị trí</option>
                            <option value="Stylist">Stylist</option>
                            <option value="Manager">Manager</option>
                            <option value="Assistant">Assistant</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select class="form-select" name="status" id="staffStatus">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-warning" id="saveStaffBtn">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
// Hàm mở modal sửa, điền dữ liệu vào form từ data attribute
function editStaffFromButton(btn) {
    const id = btn.getAttribute('data-id');
    const name = btn.getAttribute('data-name');
    const email = btn.getAttribute('data-email');
    const position = btn.getAttribute('data-position');
    const status = btn.getAttribute('data-status');
    document.getElementById('staffModalTitle').textContent = 'Sửa nhân viên';
    document.getElementById('staffForm').action = 'AdminController';
    document.getElementById('staffForm').elements['action'].value = 'editStaff';
    document.getElementById('staffId').value = id;
    document.getElementById('staffName').value = name;
    document.getElementById('staffEmail').value = email;
    document.getElementById('staffPosition').value = position;
    document.getElementById('staffStatus').value = status;
}
// Khi bấm Thêm mới, reset form về chế độ thêm
const addBtn = document.querySelector('button[data-bs-target="#staffModal"]');
if (addBtn) {
    addBtn.addEventListener('click', function() {
        document.getElementById('staffModalTitle').textContent = 'Thêm nhân viên';
        document.getElementById('staffForm').action = 'AdminController';
        document.getElementById('staffForm').elements['action'].value = 'addStaff';
        document.getElementById('staffId').value = '';
        document.getElementById('staffName').value = '';
        document.getElementById('staffEmail').value = '';
        document.getElementById('staffPosition').value = '';
        document.getElementById('staffStatus').value = 'Active';
    });
}
</script>
</body>
</html>
