package Controller;

import DAO.BookingDAO;
import DAO.StaffDAO;
import DAO.NotificationDAO;
import Model.Booking;
import Model.Staff;
import Model.Notification;
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
                // Da xoa kiem tra booking thuoc ve staff vi khong con ham getBookingById
                boolean success = bookingDAO.updateBookingStatus(bookingId, newStatus);
                
                if (success) {
                    // Create notification for admin when booking is completed
                    if ("Completed".equals(newStatus)) {
                        createCompletionNotification(bookingId, staff);
                    }
                    
                    request.setAttribute("message", "Cap nhat trang thai thanh cong!");
                } else {
                    request.setAttribute("error", "Co loi xay ra khi cap nhat trang thai!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID booking khong hop le!");
            }
        }
        
        // Redirect back to dashboard
        response.sendRedirect("StaffDashboardController");
    }
    
    private void createCompletionNotification(int bookingId, Staff staff) {
        try {
            NotificationDAO notificationDAO = new NotificationDAO();
            BookingDAO bookingDAO = new BookingDAO();
            
            // Get booking details
            Booking booking = bookingDAO.getBookingById(bookingId);
            if (booking != null) {
                String title = "Dich vu hoan thanh";
                String content = String.format(
                    "Staff %s da hoan thanh dich vu '%s' cho khach hang %s (Booking #%d)",
                    staff.getStaffName(),
                    booking.getService().getName(),
                    booking.getUser().getFullName(),
                    bookingId
                );
                
                // Create notification for admin (user_id = 1 is admin)
                Notification notification = new Notification();
                notification.setUserId(1); // Admin user
                notification.setTitle(title);
                notification.setContent(content);
                notification.setType("completion");
                notification.setStatus("unread");
                notification.setRelatedBookingId(bookingId);
                
                notificationDAO.createNotification(notification);
            }
        } catch (Exception e) {
            System.err.println("Error creating completion notification: " + e.getMessage());
        }
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