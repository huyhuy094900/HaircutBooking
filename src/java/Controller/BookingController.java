package Controller;

import DAO.BookingDAO;
import DAO.DaoService;
import DAO.StaffDAO;
import DAO.NotificationDAO;
import Model.Booking;
import Model.Service;
import Model.Staff;
import Model.Shift;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class BookingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        BookingDAO bookingDAO = new BookingDAO();
        DaoService serviceDAO = new DaoService();
        StaffDAO staffDAO = new StaffDAO();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Handle null action - show booking form by default
        if (action == null || action.trim().isEmpty()) {
            showBookingForm(request, response, serviceDAO, staffDAO);
            return;
        }
        
        switch (action) {
            case "create":
                createBooking(request, response, bookingDAO, user);
                break;
            case "list":
                listUserBookings(request, response, bookingDAO, user);
                break;
            case "cancel":
                cancelBooking(request, response, bookingDAO);
                break;
            case "confirm":
                confirmBooking(request, response, bookingDAO);
                break;
            case "complete":
                completeBooking(request, response, bookingDAO);
                break;
            case "showForm":
                showBookingForm(request, response, serviceDAO, staffDAO);
                break;
            case "checkAvailability":
                checkAvailability(request, response, bookingDAO);
                break;
            case "debug":
                showDebugPage(request, response, serviceDAO, staffDAO);
                break;
            default:
                // Default action - show booking form
                showBookingForm(request, response, serviceDAO, staffDAO);
        }
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response, 
                             BookingDAO bookingDAO, User user) throws ServletException, IOException {
        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));
            Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
            String note = request.getParameter("note");
            
            // Check if there are any existing bookings for this time slot
            boolean hasConflict = bookingDAO.hasTimeSlotConflict(staffId, shiftId, bookingDate);
            
            if (hasConflict) {
                // Nạp lại dữ liệu cho dropdown
                DaoService serviceDAO = new DaoService();
                StaffDAO staffDAO = new StaffDAO();
                List<Service> services = serviceDAO.getAllActiveServices();
                List<Staff> staff = staffDAO.getActiveStaff();
                BookingDAO bookingDAO2 = new BookingDAO();
                List<Shift> availableShifts = bookingDAO2.getAllShifts();

                request.setAttribute("services", services);
                request.setAttribute("staff", staff);
                request.setAttribute("availableShifts", availableShifts);

                request.setAttribute("error", "Booking failed because the stylist already has an appointment at this time slot. Please choose another stylist or time slot.");
                request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
                return;
            }
            
            Booking booking = new Booking();
            booking.setUserId(user.getUserId());
            booking.setServiceId(serviceId);
            booking.setStaffId(staffId);
            booking.setShiftsId(shiftId);
            booking.setBookingDate(bookingDate);
            booking.setNote(note);
            booking.setStatus("Confirmed");
            
            if (bookingDAO.createBooking(booking)) {
                // Create notification for admin (optional, can be skipped if not needed)
                // ...
                request.setAttribute("success", "Booking successful! Your appointment has been confirmed.");
                request.getRequestDispatcher("BookingSuccess.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Booking failed. Please try again.");
                request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid data! Error: " + e.getMessage());
            request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
        }
    }

    private void listUserBookings(HttpServletRequest request, HttpServletResponse response, 
                                BookingDAO bookingDAO, User user) throws ServletException, IOException {
        try {
            List<Booking> bookings = bookingDAO.getBookingsByUser(user.getUserId());
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("MyBookingsSimple.jsp").forward(request, response);
        } catch (Exception e) {
            // If there's an error, show error page
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head><title>Error</title></head>");
                out.println("<body>");
                out.println("<h1>Error loading bookings</h1>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                out.println("<a href='home'>Back to Home</a>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response, 
                             BookingDAO bookingDAO) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String reason = request.getParameter("reason");
            
            if (bookingDAO.cancelBooking(bookingId, reason)) {
                request.setAttribute("success", "Booking cancelled successfully!");
            } else {
                request.setAttribute("error", "Failed to cancel booking!");
            }
            
            // Redirect back to bookings list
            response.sendRedirect("BookingController?action=list");
        } catch (Exception e) {
            request.setAttribute("error", "Invalid booking ID!");
            response.sendRedirect("BookingController?action=list");
        }
    }

    private void confirmBooking(HttpServletRequest request, HttpServletResponse response, 
                              BookingDAO bookingDAO) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            
            if (bookingDAO.updateBookingStatus(bookingId, "Confirmed")) {
                request.setAttribute("success", "Booking confirmed successfully!");
            } else {
                request.setAttribute("error", "Failed to confirm booking!");
            }
            
            response.sendRedirect("AdminBookings.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "Invalid booking ID!");
            response.sendRedirect("AdminBookings.jsp");
        }
    }

    private void completeBooking(HttpServletRequest request, HttpServletResponse response, 
                               BookingDAO bookingDAO) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            
            if (bookingDAO.updateBookingStatus(bookingId, "Completed")) {
                request.setAttribute("success", "Booking marked as completed!");
            } else {
                request.setAttribute("error", "Failed to complete booking!");
            }
            
            response.sendRedirect("AdminBookings.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "Invalid booking ID!");
            response.sendRedirect("AdminBookings.jsp");
        }
    }

    private void showBookingForm(HttpServletRequest request, HttpServletResponse response, 
                               DaoService serviceDAO, StaffDAO staffDAO) throws ServletException, IOException {
        try {
            List<Service> services = serviceDAO.getAllActiveServices();
            List<Staff> staff = staffDAO.getActiveStaff();
            BookingDAO bookingDAO = new BookingDAO();
            List<Shift> availableShifts = bookingDAO.getAllShifts();
            request.setAttribute("services", services);
            request.setAttribute("staff", staff);
            request.setAttribute("availableShifts", availableShifts);
            request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head><title>Error</title></head>");
                out.println("<body>");
                out.println("<h1>Error in BookingController</h1>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                out.println("<a href='home'>Back to Home</a>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    private void checkAvailability(HttpServletRequest request, HttpServletResponse response, 
                                 BookingDAO bookingDAO) throws ServletException, IOException {
        try {
            String bookingDateStr = request.getParameter("bookingDate");
            String serviceIdStr = request.getParameter("serviceId");
            
            // Debug info
            System.out.println("=== DEBUG CHECK AVAILABILITY ===");
            System.out.println("bookingDateStr: '" + bookingDateStr + "'");
            System.out.println("serviceIdStr: '" + serviceIdStr + "'");
            System.out.println("All parameters:");
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                System.out.println("  " + paramName + " = '" + paramValue + "'");
            }
            System.out.println("================================");
            
            // Validate parameters - only bookingDate is required
            if (bookingDateStr == null || bookingDateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Booking date is required");
            }
            
            Date bookingDate = Date.valueOf(bookingDateStr);
            int serviceId = (serviceIdStr != null && !serviceIdStr.trim().isEmpty()) ? 
                           Integer.parseInt(serviceIdStr) : 1; // Default to service 1
            
            System.out.println("Parsed values:");
            System.out.println("  bookingDate: " + bookingDate);
            System.out.println("  serviceId: " + serviceId);
            
            List<Shift> availableShifts = bookingDAO.getAvailableShifts(bookingDate, serviceId);
            request.setAttribute("availableShifts", availableShifts);
            request.setAttribute("selectedDate", bookingDate.toString());
            request.setAttribute("selectedService", serviceId);
            
            // Get selected staff from request parameter if available
            String selectedStaffParam = request.getParameter("selectedStaff");
            if (selectedStaffParam != null && !selectedStaffParam.trim().isEmpty() && !"false".equals(selectedStaffParam)) {
                request.setAttribute("selectedStaff", selectedStaffParam);
            }
            
            // Load services and staff again
            DaoService serviceDAO = new DaoService();
            StaffDAO staffDAO = new StaffDAO();
            List<Service> services = serviceDAO.getAllActiveServices();
            List<Staff> staff = staffDAO.getActiveStaff();
            
            request.setAttribute("services", services);
            request.setAttribute("staff", staff);
            
            request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Debug info
            
            // Load services and staff when there's an error
            DaoService serviceDAO = new DaoService();
            StaffDAO staffDAO = new StaffDAO();
            List<Service> services = serviceDAO.getAllActiveServices();
            List<Staff> staff = staffDAO.getActiveStaff();
            
            request.setAttribute("services", services);
            request.setAttribute("staff", staff);
            request.setAttribute("error", "Invalid date! Error: " + e.getMessage());
            request.getRequestDispatcher("BookingForm.jsp").forward(request, response);
        }
    }

    private void showDebugPage(HttpServletRequest request, HttpServletResponse response, 
                             DaoService serviceDAO, StaffDAO staffDAO) throws ServletException, IOException {
        try {
            List<Service> services = serviceDAO.getAllActiveServices();
            List<Staff> staff = staffDAO.getActiveStaff();
            BookingDAO bookingDAO = new BookingDAO();
            List<Shift> availableShifts = bookingDAO.getAllShifts();
            request.setAttribute("services", services);
            request.setAttribute("staff", staff);
            request.setAttribute("availableShifts", availableShifts);
            request.getRequestDispatcher("test_booking_debug.jsp").forward(request, response);
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head><title>Error</title></head>");
                out.println("<body>");
                out.println("<h1>Error in BookingController Debug</h1>");
                out.println("<p>Error: " + e.getMessage() + "</p>");
                out.println("<a href='home'>Ve Trang Chu</a>");
                out.println("</body>");
                out.println("</html>");
            }
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