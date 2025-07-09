package Controller;

import DAO.StaffDAO;
import Model.Staff;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class StaffLoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            doLogin(request, response);
        } else if ("logout".equals(action)) {
            doLogout(request, response);
        } else {
            // Show login form
            request.getRequestDispatcher("StaffLogin.jsp").forward(request, response);
        }
    }

    private void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        StaffDAO staffDAO = new StaffDAO();
        Staff staff = staffDAO.checkLogin(email, password);
        
        if (staff != null) {
            // Login successful
            HttpSession session = request.getSession();
            session.setAttribute("staff", staff);
            session.setAttribute("staffId", staff.getStaffId());
            session.setAttribute("staffName", staff.getStaffName());
            
            // Redirect to today's bookings
            response.sendRedirect("StaffDashboardController?action=viewTodayBookings");
        } else {
            // Login failed
            request.setAttribute("error", "Email hoac mat khau khong dung!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("StaffLogin.jsp").forward(request, response);
        }
    }

    private void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("StaffLogin.jsp");
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