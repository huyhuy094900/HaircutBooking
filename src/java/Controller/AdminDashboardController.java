package Controller;

import DAO.BookingDAO;
import DAO.DaoUser;
import DAO.DaoService;
import DAO.StaffDAO;
import Model.Booking;
import Model.User;
import Model.Service;
import Model.Staff;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.io.PrintWriter;

public class AdminDashboardController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            System.out.println("AdminDashboardController: Action = " + action);
            System.out.println("AdminDashboardController: User = " + (user != null ? user.getFullName() : "null"));
            
            if (user == null || !user.isAdmin()) {
                System.out.println("AdminDashboardController: User not admin, redirecting to login");
                response.sendRedirect("Login.jsp");
                return;
            }
            
            // Initialize DAOs
            BookingDAO bookingDAO = new BookingDAO();
            DaoUser userDAO = new DaoUser();
            DaoService serviceDAO = new DaoService();
            StaffDAO staffDAO = new StaffDAO();
            
            // Route to appropriate method
            if ("users".equals(action)) {
                System.out.println("AdminDashboardController: Routing to showUsers");
                showUsers(request, response, userDAO);
            } else if ("services".equals(action)) {
                System.out.println("AdminDashboardController: Routing to showServices");
                showServices(request, response, serviceDAO);
            } else if ("staff".equals(action)) {
                System.out.println("AdminDashboardController: Routing to showStaff");
                showStaff(request, response, staffDAO);
            } else {
                System.out.println("AdminDashboardController: Routing to showDashboard (default)");
                showDashboard(request, response, userDAO, serviceDAO, staffDAO);
            }
            
        } catch (Exception e) {
            System.out.println("AdminDashboardController: Critical error: " + e.getMessage());
            e.printStackTrace();
            
            // Show error page
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Admin Dashboard Error</title>");
                out.println("<link href='assets/vendor/bootstrap/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container mt-5'>");
                out.println("<div class='alert alert-danger'>");
                out.println("<h4>[ERROR] Loi Admin Dashboard</h4>");
                out.println("<p>Khong the tai dashboard. Vui long thu lai sau.</p>");
                out.println("<a href='home' class='btn btn-primary'>Ve trang chu</a>");
                out.println("<a href='logout' class='btn btn-danger'>Dang xuat</a>");
                out.println("</div>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response,
                             DaoUser userDAO, DaoService serviceDAO, StaffDAO staffDAO) 
            throws ServletException, IOException {
        
        try {
            System.out.println("AdminDashboardController: Starting showDashboard...");
            
            // Load data with error handling
            List<User> allUsers = new ArrayList<>();
            List<Service> allServices = new ArrayList<>();
            List<Staff> allStaff = new ArrayList<>();
            
            try {
                allUsers = userDAO.getAllUsers();
                System.out.println("AdminDashboardController: Loaded " + allUsers.size() + " users");
            } catch (Exception e) {
                System.out.println("AdminDashboardController: Error loading users: " + e.getMessage());
            }
            
            try {
                allServices = serviceDAO.getAllService();
                System.out.println("AdminDashboardController: Loaded " + allServices.size() + " services");
            } catch (Exception e) {
                System.out.println("AdminDashboardController: Error loading services: " + e.getMessage());
            }
            
            try {
                allStaff = staffDAO.getAllStaff();
                System.out.println("AdminDashboardController: Loaded " + allStaff.size() + " staff");
            } catch (Exception e) {
                System.out.println("AdminDashboardController: Error loading staff: " + e.getMessage());
            }
            
            // Calculate statistics
            int totalUsers = allUsers.size();
            int totalServices = allServices.size();
            int totalStaff = allStaff.size();
            
            // Da xoa toan bo logic lay booking cho admin vi khong con ham getAllBookings/getBookingsByStatus
            // ... giữ lại các phần lấy user, service, staff nếu cần ...
            
            // Calculate active users
            int activeUsers = 0;
            java.util.Date thirtyDaysAgo = new java.util.Date(System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000));
            for (User user : allUsers) {
                for (Booking booking : new ArrayList<Booking>()) { // Placeholder for bookings, as they are no longer fetched here
                    if (booking.getUser() != null && booking.getUser().getUserId() == user.getUserId()) {
                        if (booking.getBookingDate() != null && booking.getBookingDate().after(thirtyDaysAgo)) {
                            activeUsers++;
                            break;
                        }
                    }
                }
            }
            
            // Calculate available staff
            int availableStaff = 0;
            for (Staff staff : allStaff) {
                if (staff.isStaffStatus()) {
                    availableStaff++;
                }
            }
            
            // Set attributes
            request.setAttribute("userCount", totalUsers);
            request.setAttribute("serviceCount", totalServices);
            request.setAttribute("staffCount", totalStaff);
            request.setAttribute("activeUsers", activeUsers);
            request.setAttribute("availableStaff", availableStaff);
            
            // Set recent data
            List<User> recentUsers = allUsers.size() > 5 ? allUsers.subList(0, 5) : allUsers;
            List<Service> recentServices = allServices.size() > 5 ? allServices.subList(0, 5) : allServices;
            List<Staff> recentStaff = allStaff.size() > 5 ? allStaff.subList(0, 5) : allStaff;
            List<Booking> recentBookings = new ArrayList<Booking>(); // Placeholder for bookings, as they are no longer fetched here
            
            request.setAttribute("recentBookings", recentBookings);
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("recentServices", recentServices);
            request.setAttribute("recentStaff", recentStaff);
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("allServices", allServices);
            request.setAttribute("allStaff", allStaff);
            
            System.out.println("AdminDashboardController: Forwarding to AdminDashboard.jsp");
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminDashboardController: Error in showDashboard: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response,
                          DaoUser userDAO) throws ServletException, IOException {
        
        try {
            System.out.println("AdminDashboardController: Starting showUsers...");
            
            List<User> allUsers = userDAO.getAllUsers();
            
            // Calculate statistics
            int totalUsers = allUsers.size();
            int activeUsers = 0;
            int inactiveUsers = 0;
            int adminUsers = 0;
            
            for (User user : allUsers) {
                if (user.isUserStatus()) activeUsers++;
                else inactiveUsers++;
                if (user.isAdmin()) adminUsers++;
            }
            
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("userCount", totalUsers);
            request.setAttribute("activeUserCount", activeUsers);
            request.setAttribute("inactiveUserCount", inactiveUsers);
            request.setAttribute("adminCount", adminUsers);
            
            System.out.println("AdminDashboardController: Forwarding to AdminUsers.jsp");
            request.getRequestDispatcher("AdminUsers.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminDashboardController: Error in showUsers: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showServices(HttpServletRequest request, HttpServletResponse response,
                             DaoService serviceDAO) throws ServletException, IOException {
        
        try {
            System.out.println("AdminDashboardController: Starting showServices...");
            
            List<Service> allServices = serviceDAO.getAllService();
            
            // Calculate statistics
            int totalServices = allServices.size();
            int activeServices = 0;
            int inactiveServices = 0;
            double totalRevenue = 0.0;
            
            for (Service service : allServices) {
                if (service.isServiceStatus()) activeServices++;
                else inactiveServices++;
                if (service.getPrice() != null) {
                    totalRevenue += service.getPrice().doubleValue();
                }
            }
            
            request.setAttribute("allServices", allServices);
            request.setAttribute("serviceCount", totalServices);
            request.setAttribute("activeServiceCount", activeServices);
            request.setAttribute("inactiveServiceCount", inactiveServices);
            request.setAttribute("totalRevenue", String.format("%.2f", totalRevenue));
            
            System.out.println("AdminDashboardController: Forwarding to AdminServices.jsp");
            request.getRequestDispatcher("AdminServices.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminDashboardController: Error in showServices: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showStaff(HttpServletRequest request, HttpServletResponse response,
                          StaffDAO staffDAO) throws ServletException, IOException {
        
        try {
            System.out.println("AdminDashboardController: Starting showStaff...");
            
            List<Staff> allStaff = staffDAO.getAllStaff();
            
            // Calculate statistics
            int totalStaff = allStaff.size();
            int activeStaff = 0;
            int inactiveStaff = 0;
            
            for (Staff staff : allStaff) {
                if (staff.isStaffStatus()) activeStaff++;
                else inactiveStaff++;
            }
            
            request.setAttribute("allStaff", allStaff);
            request.setAttribute("staffCount", totalStaff);
            request.setAttribute("activeStaffCount", activeStaff);
            request.setAttribute("inactiveStaffCount", inactiveStaff);
            
            System.out.println("AdminDashboardController: Forwarding to AdminStaff.jsp");
            request.getRequestDispatcher("AdminStaff.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminDashboardController: Error in showStaff: " + e.getMessage());
            e.printStackTrace();
            throw e;
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