package Controller;

import DAO.BookingDAO;
import DAO.DaoUser;
import DAO.DaoService;
import DAO.StaffDAO;
import DAO.NotificationDAO;
import Model.Booking;
import Model.User;
import Model.Service;
import Model.Staff;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;

public class AdminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            System.out.println("AdminController: Action = " + action);
            System.out.println("AdminController: User = " + (user != null ? user.getFullName() : "null"));
            
            if (user == null || !user.isAdmin()) {
                System.out.println("AdminController: User not admin, redirecting to login");
                response.sendRedirect("Login.jsp");
                return;
            }
            
            // Initialize DAOs
            BookingDAO bookingDAO = new BookingDAO();
            DaoUser userDAO = new DaoUser();
            DaoService serviceDAO = new DaoService();
            StaffDAO staffDAO = new StaffDAO();
            NotificationDAO notificationDAO = new NotificationDAO();
            
            // Route to appropriate method
            if ("users".equals(action)) {
                System.out.println("AdminController: Routing to showUsers");
                showUsers(request, response, userDAO);
            } else if ("services".equals(action)) {
                System.out.println("AdminController: Routing to showServices");
                showServices(request, response, serviceDAO);
            } else if ("staff".equals(action)) {
                System.out.println("AdminController: Routing to showStaff");
                showStaff(request, response, staffDAO);
            } else if ("bookings".equals(action)) {
                System.out.println("AdminController: Routing to showBookings");
                showBookings(request, response, bookingDAO, userDAO, serviceDAO, staffDAO);
            } else {
                System.out.println("AdminController: Routing to showDashboard (default)");
                showDashboard(request, response, bookingDAO, userDAO, serviceDAO, staffDAO, notificationDAO);
            }
            
        } catch (Exception e) {
            System.out.println("AdminController: Critical error: " + e.getMessage());
            e.printStackTrace();
            
            // Show error page
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Admin Controller Error</title>");
                out.println("<link href='assets/vendor/bootstrap/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container mt-5'>");
                out.println("<div class='alert alert-danger'>");
                out.println("<h4>[ERROR] Loi Admin Controller</h4>");
                out.println("<p>Khong the tai trang. Vui long thu lai sau.</p>");
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
                             BookingDAO bookingDAO, DaoUser userDAO, DaoService serviceDAO, StaffDAO staffDAO, NotificationDAO notificationDAO) 
            throws ServletException, IOException {
        
        try {
            System.out.println("AdminController: Starting showDashboard...");
            
            // Load data with error handling
            List<Booking> allBookings = new ArrayList<>();
            List<Booking> pendingBookings = new ArrayList<>();
            List<Booking> completedBookings = new ArrayList<>();
            List<User> allUsers = new ArrayList<>();
            List<Service> allServices = new ArrayList<>();
            List<Staff> allStaff = new ArrayList<>();
            
            try {
                allBookings = bookingDAO.getAllBookings();
                System.out.println("AdminController: Loaded " + allBookings.size() + " bookings");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading bookings: " + e.getMessage());
            }
            
            try {
                pendingBookings = bookingDAO.getBookingsByStatus("Pending");
                System.out.println("AdminController: Loaded " + pendingBookings.size() + " pending bookings");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading pending bookings: " + e.getMessage());
            }
            
            try {
                completedBookings = bookingDAO.getBookingsByStatus("Completed");
                System.out.println("AdminController: Loaded " + completedBookings.size() + " completed bookings");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading completed bookings: " + e.getMessage());
            }
            
            try {
                allUsers = userDAO.getAllUsers();
                System.out.println("AdminController: Loaded " + allUsers.size() + " users");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading users: " + e.getMessage());
            }
            
            try {
                allServices = serviceDAO.getAllService();
                System.out.println("AdminController: Loaded " + allServices.size() + " services");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading services: " + e.getMessage());
            }
            
            try {
                allStaff = staffDAO.getAllStaff();
                System.out.println("AdminController: Loaded " + allStaff.size() + " staff");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading staff: " + e.getMessage());
            }
            
            // Calculate statistics
            int totalBookings = allBookings.size();
            int pendingCount = pendingBookings.size();
            int completedCount = completedBookings.size();
            int totalUsers = allUsers.size();
            int totalServices = allServices.size();
            int totalStaff = allStaff.size();
            
            // Calculate revenue
            double totalRevenue = 0.0;
            for (Booking booking : completedBookings) {
                if (booking.getService() != null && booking.getService().getPrice() != null) {
                    totalRevenue += booking.getService().getPrice().doubleValue();
                }
            }
            
            // Calculate active users
            int activeUsers = 0;
            java.util.Date thirtyDaysAgo = new java.util.Date(System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000));
            for (User user : allUsers) {
                for (Booking booking : allBookings) {
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
            request.setAttribute("bookingCount", totalBookings);
            request.setAttribute("userCount", totalUsers);
            request.setAttribute("serviceCount", totalServices);
            request.setAttribute("staffCount", totalStaff);
            request.setAttribute("pendingBookings", pendingCount);
            request.setAttribute("completedBookings", completedCount);
            request.setAttribute("totalRevenue", String.format("%.0f", totalRevenue));
            request.setAttribute("activeUsers", activeUsers);
            request.setAttribute("availableStaff", availableStaff);
            
            // Load unread notification count
            try {
                int unreadCount = notificationDAO.getUnreadCount();
                request.setAttribute("unreadNotificationCount", unreadCount);
                System.out.println("AdminController: Loaded " + unreadCount + " unread notifications");
            } catch (Exception e) {
                System.out.println("AdminController: Error loading notifications: " + e.getMessage());
                request.setAttribute("unreadNotificationCount", 0);
            }
            
            // Set recent data
            List<User> recentUsers = allUsers.size() > 5 ? allUsers.subList(0, 5) : allUsers;
            List<Service> recentServices = allServices.size() > 5 ? allServices.subList(0, 5) : allServices;
            List<Staff> recentStaff = allStaff.size() > 5 ? allStaff.subList(0, 5) : allStaff;
            List<Booking> recentBookings = allBookings.size() > 5 ? allBookings.subList(0, 5) : allBookings;
            
            request.setAttribute("recentBookings", recentBookings);
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("recentServices", recentServices);
            request.setAttribute("recentStaff", recentStaff);
            request.setAttribute("allBookings", allBookings);
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("allServices", allServices);
            request.setAttribute("allStaff", allStaff);
            
            System.out.println("AdminController: Forwarding to AdminDashboard.jsp");
            request.getRequestDispatcher("AdminDashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminController: Error in showDashboard: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response,
                          DaoUser userDAO) throws ServletException, IOException {
        
        try {
            System.out.println("AdminController: Starting showUsers...");
            
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
            
            System.out.println("AdminController: Forwarding to AdminUsers.jsp");
            request.getRequestDispatcher("AdminUsers.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminController: Error in showUsers: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showServices(HttpServletRequest request, HttpServletResponse response,
                             DaoService serviceDAO) throws ServletException, IOException {
        
        try {
            System.out.println("AdminController: Starting showServices...");
            
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
            
            System.out.println("AdminController: Forwarding to AdminServices.jsp");
            request.getRequestDispatcher("AdminServices.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminController: Error in showServices: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showStaff(HttpServletRequest request, HttpServletResponse response,
                          StaffDAO staffDAO) throws ServletException, IOException {
        
        try {
            System.out.println("AdminController: Starting showStaff...");
            
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
            
            System.out.println("AdminController: Forwarding to AdminStaff.jsp");
            request.getRequestDispatcher("AdminStaff.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminController: Error in showStaff: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    private void showBookings(HttpServletRequest request, HttpServletResponse response,
                            BookingDAO bookingDAO, DaoUser userDAO, DaoService serviceDAO, StaffDAO staffDAO) 
            throws ServletException, IOException {
        
        try {
            System.out.println("AdminController: Starting showBookings...");
            
            List<Booking> allBookings = bookingDAO.getAllBookings();
            List<User> allUsers = userDAO.getAllUsers();
            List<Service> allServices = serviceDAO.getAllService();
            List<Staff> allStaff = staffDAO.getAllStaff();
            
            // Calculate statistics
            int totalBookings = allBookings.size();
            int pendingBookings = 0;
            int confirmedBookings = 0;
            double totalRevenue = 0.0;
            
            for (Booking booking : allBookings) {
                if ("Pending".equals(booking.getStatus())) pendingBookings++;
                else if ("Confirmed".equals(booking.getStatus())) confirmedBookings++;
                
                if (booking.getService() != null && booking.getService().getPrice() != null) {
                    totalRevenue += booking.getService().getPrice().doubleValue();
                }
            }
            
            request.setAttribute("allBookings", allBookings);
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("allServices", allServices);
            request.setAttribute("allStaff", allStaff);
            request.setAttribute("bookingCount", totalBookings);
            request.setAttribute("pendingBookingCount", pendingBookings);
            request.setAttribute("confirmedBookingCount", confirmedBookings);
            request.setAttribute("totalRevenue", String.format("%.2f", totalRevenue));
            
            System.out.println("AdminController: Forwarding to AdminBookings.jsp");
            request.getRequestDispatcher("AdminBookings.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("AdminController: Error in showBookings: " + e.getMessage());
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