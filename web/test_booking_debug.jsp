<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Booking Debug</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4>Test Booking Debug</h4>
                    </div>
                    <div class="card-body">
                        <h5>Session Info:</h5>
                        <p><strong>User:</strong> ${sessionScope.user.fullName}</p>
                        <p><strong>User ID:</strong> ${sessionScope.user.userId}</p>
                        
                        <h5>Available Services:</h5>
                        <c:forEach var="service" items="${services}">
                            <div class="mb-2">
                                <strong>ID:</strong> ${service.serviceId} | 
                                <strong>Name:</strong> ${service.name} | 
                                <strong>Price:</strong> ${service.price}₫
                            </div>
                        </c:forEach>
                        
                        <h5>Available Staff:</h5>
                        <c:forEach var="staff" items="${staff}">
                            <div class="mb-2">
                                <strong>ID:</strong> ${staff.staffId} | 
                                <strong>Name:</strong> ${staff.staffName}
                            </div>
                        </c:forEach>
                        
                        <h5>Available Shifts:</h5>
                        <c:forEach var="shift" items="${availableShifts}">
                            <div class="mb-2">
                                <strong>ID:</strong> ${shift.shiftsId} | 
                                <strong>Time:</strong> ${shift.startTime} - ${shift.endTime}
                            </div>
                        </c:forEach>
                        
                        <hr>
                        
                        <h5>Test Booking Form:</h5>
                        <form action="BookingController" method="post" id="testForm">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="mb-3">
                                <label class="form-label">Service ID:</label>
                                <input type="number" name="serviceId" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Staff ID:</label>
                                <input type="number" name="staffId" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Shift ID:</label>
                                <input type="number" name="shiftId" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Booking Date:</label>
                                <input type="date" name="bookingDate" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Note:</label>
                                <textarea name="note" class="form-control" rows="2"></textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">Test Create Booking</button>
                        </form>
                        
                        <hr>
                        
                        <div class="mt-3">
                            <a href="BookingController" class="btn btn-secondary">Go to Real Booking Form</a>
                            <a href="home" class="btn btn-outline-secondary">Back to Home</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-fill form with first available options
        document.addEventListener('DOMContentLoaded', function() {
            const serviceInput = document.querySelector('input[name="serviceId"]');
            const staffInput = document.querySelector('input[name="staffId"]');
            const shiftInput = document.querySelector('input[name="shiftId"]');
            const dateInput = document.querySelector('input[name="bookingDate"]');
            
            // Set today's date
            const today = new Date().toISOString().split('T')[0];
            dateInput.value = today;
            
            // Set default values if available
            if (serviceInput && document.querySelector('.mb-2 strong:contains("ID:")')) {
                const firstServiceId = document.querySelector('.mb-2').textContent.match(/ID:\s*(\d+)/)[1];
                serviceInput.value = firstServiceId;
            }
            
            if (staffInput && document.querySelectorAll('.mb-2').length > 1) {
                const staffElements = document.querySelectorAll('.mb-2');
                const firstStaffId = staffElements[1].textContent.match(/ID:\s*(\d+)/)[1];
                staffInput.value = firstStaffId;
            }
            
            if (shiftInput && document.querySelectorAll('.mb-2').length > 2) {
                const shiftElements = document.querySelectorAll('.mb-2');
                const firstShiftId = shiftElements[2].textContent.match(/ID:\s*(\d+)/)[1];
                shiftInput.value = firstShiftId;
            }
        });
    </script>
</body>
</html> 