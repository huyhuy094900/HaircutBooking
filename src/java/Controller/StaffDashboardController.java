package Controller;

import DAO.BookingDAO;
import DAO.StaffDAO;
import Model.Booking;
import Model.Staff;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class StaffDashboardController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            
            HttpSession session = request.getSession();
            Staff staff = (Staff) session.getAttribute("staff");
            
            // Check if staff is logged in
            if (staff == null) {
                request.setAttribute("error", "Phiên đăng nhập đã hết hạn hoặc chưa đăng nhập. Vui lòng đăng nhập lại!");
                request.getRequestDispatcher("StaffLogin.jsp").forward(request, response);
                return;
            }
            
            String action = request.getParameter("action");
            
            if (action == null || action.trim().isEmpty()) {
                showDashboard(request, response, staff);
            } else if ("viewBookings".equals(action)) {
                showBookings(request, response, staff);
            } else if ("viewTodayBookings".equals(action)) {
                showTodayBookings(request, response, staff);
            } else if ("updateStatus".equals(action)) {
                updateBookingStatus(request, response, staff);
            } else {
                showDashboard(request, response, staff);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, Staff staff)
            throws ServletException, IOException {
        // Redirect to today's bookings instead of showing StaffDashboard.jsp
        response.sendRedirect("StaffDashboardController?action=viewTodayBookings");
    }

    private void showBookings(HttpServletRequest request, HttpServletResponse response, Staff staff)
            throws ServletException, IOException {
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> allBookings = bookingDAO.getBookingsByStaff(staff.getStaffId());
        if (allBookings == null) {
            allBookings = new java.util.ArrayList<>();
        }
        request.setAttribute("staff", staff);
        request.setAttribute("allBookings", allBookings);
        request.setAttribute("bookingCount", allBookings.size());
        request.getRequestDispatcher("StaffBookings.jsp").forward(request, response);
    }

    private void showTodayBookings(HttpServletRequest request, HttpServletResponse response, Staff staff)
            throws ServletException, IOException {
        
        BookingDAO bookingDAO = new BookingDAO();
        
        // Get today's date
        java.util.Date today = new java.util.Date();
        Date todayDate = new Date(today.getTime());
        
        List<Booking> todayBookings = bookingDAO.getBookingsByStaffAndDate(staff.getStaffId(), todayDate);
        
        request.setAttribute("staff", staff);
        request.setAttribute("todayBookings", todayBookings);
        request.setAttribute("bookingCount", todayBookings.size());
        request.setAttribute("todayDate", todayDate);
        
        request.getRequestDispatcher("StaffTodayBookings.jsp").forward(request, response);
    }

    private void updateBookingStatus(HttpServletRequest request, HttpServletResponse response, Staff staff)
            throws ServletException, IOException {
        
        String bookingIdStr = request.getParameter("bookingId");
        String newStatus = request.getParameter("status");
        
        if (bookingIdStr != null && newStatus != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bookingDAO = new BookingDAO();
                
                // Verify this booking belongs to the logged-in staff
                Booking booking = bookingDAO.getBookingById(bookingId);
                if (booking != null && booking.getStaffId() == staff.getStaffId()) {
                    boolean success = bookingDAO.updateBookingStatus(bookingId, newStatus);
                    if (success) {
                        request.setAttribute("message", "Cập nhật trạng thái thành công!");
                    } else {
                        request.setAttribute("error", "Có lỗi xảy ra khi cập nhật trạng thái!");
                    }
                } else {
                    request.setAttribute("error", "Ban khong co quyen cap nhat booking nay!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID booking không hợp lệ!");
            }
        }
        
        // Redirect back to dashboard
        response.sendRedirect("StaffDashboardController");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
} 