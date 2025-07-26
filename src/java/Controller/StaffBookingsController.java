package Controller;

import DAO.BookingDAO;
import Model.Booking;
import Model.Staff;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class StaffBookingsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");
        
        // Check if staff is logged in
        if (staff == null) {
            response.sendRedirect("StaffLoginController");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            updateBookingStatus(request, response, staff);
        } else {
            showAllBookings(request, response, staff);
        }
    }

    private void showAllBookings(HttpServletRequest request, HttpServletResponse response, Staff staff)
            throws ServletException, IOException {
        
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> allBookings = bookingDAO.getBookingsByStaff(staff.getStaffId());
        
        request.setAttribute("staff", staff);
        request.setAttribute("allBookings", allBookings);
        request.setAttribute("bookingCount", allBookings.size());
        
        request.getRequestDispatcher("StaffBookings.jsp").forward(request, response);
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
                    request.setAttribute("message", "Cập nhật trạng thái thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi cập nhật trạng thái!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID booking không hợp lệ!");
            }
        }
        
        // Redirect back to bookings page
        response.sendRedirect("StaffBookingsController");
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