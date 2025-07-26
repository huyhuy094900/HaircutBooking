package Controller;

import DAO.BookingDAO;
import Model.Booking;
import Model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminBookingController")
public class AdminBookingController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isAdmin()) {
            response.sendRedirect("Login.jsp");
            return;
        }
        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> allBookings = bookingDAO.getAllBookings();
        request.setAttribute("allBookings", allBookings);
        request.getRequestDispatcher("AdminBookingManager.jsp").forward(request, response);
    }
} 