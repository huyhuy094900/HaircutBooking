<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Duyệt yêu cầu nghỉ của nhân viên</title>
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .main-card { background: #fff; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); padding: 32px; }
        .table thead { background: #667eea; color: #fff; }
        .status-badge { font-size: 0.95rem; padding: 0.4em 1em; border-radius: 1em; }
        .status-Pending { background: #ffc107; color: #333; }
        .status-Approved { background: #28a745; color: #fff; }
        .status-Rejected { background: #dc3545; color: #fff; }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="main-card">
        <h2 class="mb-4"><i class="bi bi-person-badge"></i> Duyệt yêu cầu nghỉ của nhân viên</h2>
        <c:choose>
            <c:when test="${empty requests}">
                <div class="alert alert-info text-center">Không có yêu cầu nghỉ nào.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nhân viên</th>
                                <th>Ngày nghỉ</th>
                                <th>Lý do</th>
                                <th>Trạng thái</th>
                                <th>Người duyệt</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="req" items="${requests}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${req.staffName}</td>
                                    <td>${req.offDate}</td>
                                    <td>${req.reason}</td>
                                    <td><span class="status-badge status-${req.status}">${req.status}</span></td>
                                    <td><c:out value="${req.adminName}" default="-"/></td>
                                    <td>
                                        <c:if test="${req.status == 'Pending'}">
                                            <form action="StaffDayOffController" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="approve"/>
                                                <input type="hidden" name="request_id" value="${req.requestId}"/>
                                                <button class="btn btn-success btn-sm"><i class="bi bi-check-circle"></i> Duyệt</button>
                                            </form>
                                            <form action="StaffDayOffController" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="reject"/>
                                                <input type="hidden" name="request_id" value="${req.requestId}"/>
                                                <button class="btn btn-danger btn-sm"><i class="bi bi-x-circle"></i> Từ chối</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${req.status != 'Pending'}">
                                            <span class="text-muted">Đã xử lý</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html> 