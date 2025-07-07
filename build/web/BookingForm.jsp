<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đặt Lịch Cắt Tóc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .booking-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .form-control.is-invalid, .form-select.is-invalid {
            border-color: #dc3545;
        }
        .form-control.is-valid, .form-select.is-valid {
            border-color: #198754;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
        .btn-submit {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        .btn-submit:disabled {
            opacity: 0.6;
            transform: none;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card booking-card">
                <div class="card-header bg-primary text-white text-center">
                    <h4 class="mb-0"><i class="bi bi-calendar-check me-2"></i>Đặt Lịch Cắt Tóc</h4>
                </div>
                <div class="card-body p-4">
                    <!-- Server-side error messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle me-2"></i>
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle me-2"></i>
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <form id="bookingForm" action="BookingController" method="post" novalidate>
                        <input type="hidden" name="action" value="create">
                        
                        <!-- Service -->
                        <div class="mb-3">
                            <label for="serviceId" class="form-label">
                                <i class="bi bi-scissors me-1"></i>Dịch Vụ <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" name="serviceId" id="serviceId" required>
                                <option value="">-- Chọn Dịch Vụ --</option>
                                <c:forEach var="service" items="${services}">
                                    <option value="${service.serviceId}" 
                                            ${param.serviceId == service.serviceId ? 'selected' : ''}>
                                        ${service.name} (${service.price}₫, ${service.duration} phút)
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="error-message" id="serviceId-error">Vui lòng chọn dịch vụ</div>
                        </div>
                        
                        <!-- Staff -->
                        <div class="mb-3">
                            <label for="staffId" class="form-label">
                                <i class="bi bi-person me-1"></i>Thợ Cắt <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" name="staffId" id="staffId" required>
                                <option value="">-- Chọn Thợ Cắt --</option>
                                <c:forEach var="staffMember" items="${staff}">
                                    <option value="${staffMember.staffId}"
                                            ${param.staffId == staffMember.staffId ? 'selected' : ''}>
                                        ${staffMember.staffName}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="error-message" id="staffId-error">Vui lòng chọn thợ cắt</div>
                        </div>
                        
                        <!-- Date -->
                        <div class="mb-3">
                            <label for="bookingDate" class="form-label">
                                <i class="bi bi-calendar me-1"></i>Ngày <span class="text-danger">*</span>
                            </label>
                            <input type="date" class="form-control" name="bookingDate" id="bookingDate" 
                                   value="${param.bookingDate}" required>
                            <div class="error-message" id="bookingDate-error">Vui lòng chọn ngày</div>
                        </div>
                        
                        <!-- Shift -->
                        <div class="mb-3">
                            <label for="shiftId" class="form-label">
                                <i class="bi bi-clock me-1"></i>Giờ Hẹn <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" name="shiftId" id="shiftId" required>
                                <option value="">-- Chọn Giờ Hẹn --</option>
                                <c:forEach var="shift" items="${availableShifts}">
                                    <option value="${shift.shiftsId}"
                                            ${param.shiftId == shift.shiftsId ? 'selected' : ''}>
                                        ${shift.startTime} - ${shift.endTime}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="error-message" id="shiftId-error">Vui lòng chọn giờ hẹn</div>
                        </div>
                        
                        <!-- Note -->
                        <div class="mb-4">
                            <label for="note" class="form-label">
                                <i class="bi bi-chat-text me-1"></i>Ghi Chú (tùy chọn)
                            </label>
                            <textarea class="form-control" name="note" id="note" rows="3" 
                                      placeholder="Yêu cầu đặc biệt hoặc ghi chú...">${param.note}</textarea>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-submit w-100" id="submitBtn">
                            <i class="bi bi-check-circle me-2"></i>Xác Nhận Đặt Lịch
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('bookingForm');
    const submitBtn = document.getElementById('submitBtn');
    
    // Set minimum date to today
    const today = new Date().toISOString().split('T')[0];
    const dateInput = document.getElementById('bookingDate');
    dateInput.min = today;
    
    // If no date is set, set to today
    if (!dateInput.value) {
        dateInput.value = today;
    }
    
    // Real-time validation
    const requiredFields = ['serviceId', 'staffId', 'bookingDate', 'shiftId'];
    
    requiredFields.forEach(fieldId => {
        const field = document.getElementById(fieldId);
        const errorDiv = document.getElementById(fieldId + '-error');
        
        field.addEventListener('blur', function() {
            validateField(field, errorDiv);
        });
        
        field.addEventListener('input', function() {
            if (field.classList.contains('is-invalid')) {
                validateField(field, errorDiv);
            }
        });
    });
    
    function validateField(field, errorDiv) {
        const isValid = field.value.trim() !== '';
        
        if (isValid) {
            field.classList.remove('is-invalid');
            field.classList.add('is-valid');
            errorDiv.style.display = 'none';
        } else {
            field.classList.remove('is-valid');
            field.classList.add('is-invalid');
            errorDiv.style.display = 'block';
        }
        
        updateSubmitButton();
    }
    
    function updateSubmitButton() {
        const allValid = requiredFields.every(fieldId => {
            const field = document.getElementById(fieldId);
            return field.value.trim() !== '';
        });
        
        submitBtn.disabled = !allValid;
    }
    
    // Form submission with enhanced validation
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Clear previous validation states
        requiredFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            const errorDiv = document.getElementById(fieldId + '-error');
            field.classList.remove('is-valid', 'is-invalid');
            errorDiv.style.display = 'none';
        });
        
        // Validate all fields
        let isValid = true;
        requiredFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            const errorDiv = document.getElementById(fieldId + '-error');
            
            if (field.value.trim() === '') {
                field.classList.add('is-invalid');
                errorDiv.style.display = 'block';
                isValid = false;
            } else {
                field.classList.add('is-valid');
            }
        });
        
        if (isValid) {
            // Show loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang Xử Lý...';
            
            // Submit form
            form.submit();
        } else {
            // Scroll to first error
            const firstError = document.querySelector('.is-invalid');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstError.focus();
            }
        }
    });
    
    // Auto-save form data to localStorage
    const formInputs = form.querySelectorAll('input, select, textarea');
    formInputs.forEach(input => {
        input.addEventListener('change', function() {
            const formData = new FormData(form);
            const data = {};
            for (let [key, value] of formData.entries()) {
                data[key] = value;
            }
            localStorage.setItem('bookingFormData', JSON.stringify(data));
        });
    });
    
    // Restore form data from localStorage
    const savedData = localStorage.getItem('bookingFormData');
    if (savedData) {
        const data = JSON.parse(savedData);
        Object.keys(data).forEach(key => {
            const field = form.querySelector(`[name="${key}"]`);
            if (field && !field.value) {
                field.value = data[key];
                // Trigger validation
                const errorDiv = document.getElementById(key + '-error');
                if (errorDiv) {
                    validateField(field, errorDiv);
                }
            }
        });
    }
    
    // Clear saved data on successful submission
    window.addEventListener('beforeunload', function() {
        if (document.querySelector('.alert-success')) {
            localStorage.removeItem('bookingFormData');
        }
    });
});
</script>
</body>
</html> 