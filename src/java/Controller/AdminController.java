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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
@WebServlet("/AdminController")
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
            } else if ("getService".equals(action)) {
                // AJAX: Lấy thông tin dịch vụ theo ID, trả về JSON
                int id = Integer.parseInt(request.getParameter("id"));
                Service service = serviceDAO.getServiceById(id);
                response.setContentType("application/json");
                response.getWriter().write(new com.google.gson.Gson().toJson(service));
                return;
            } else if ("saveService".equals(action)) {
                // AJAX: Thêm mới hoặc cập nhật dịch vụ
                StringBuilder sb = new StringBuilder();
                String line;
                try (java.io.BufferedReader reader = request.getReader()) {
                    while ((line = reader.readLine()) != null) {
                        sb.append(line);
                    }
                }
                com.google.gson.Gson gson = new com.google.gson.Gson();
                Service service = gson.fromJson(sb.toString(), Service.class);
                String msg;
                if (service.getServiceId() == 0) {
                    serviceDAO.addService(service);
                    msg = "Thêm mới thành công!";
                } else {
                    serviceDAO.updateService(service);
                    msg = "Cập nhật thành công!";
                }
                response.setContentType("text/plain");
                response.getWriter().write(msg);
                return;
            } else if ("activateService".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                serviceDAO.setServiceStatus(id, true);
                response.setContentType("text/plain");
                response.getWriter().write("Đã kích hoạt dịch vụ!");
                return;
            } else if ("deactivateService".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                serviceDAO.setServiceStatus(id, false);
                response.setContentType("text/plain");
                response.getWriter().write("Đã vô hiệu hóa dịch vụ!");
                return;
            } else if ("staff".equals(action)) {
                System.out.println("AdminController: Routing to showStaff");
                showStaff(request, response, staffDAO);
            } else if ("addStaff".equals(action)) {
                addStaff(request, response, staffDAO);
            } else if ("editStaff".equals(action)) {
                editStaff(request, response, staffDAO);
            } else if ("toggleStaffStatus".equals(action)) {
                toggleStaffStatus(request, response, staffDAO);
            } else if ("viewStaff".equals(action)) {
                viewStaff(request, response, staffDAO);
            } else {
                System.out.println("AdminController: Routing to showDashboard (default)");
                showDashboard(request, response, userDAO, serviceDAO, staffDAO, notificationDAO);
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
                             DaoUser userDAO, DaoService serviceDAO, StaffDAO staffDAO, NotificationDAO notificationDAO) 
            throws ServletException, IOException {
        
        try {
            System.out.println("AdminController: Starting showDashboard...");
            
            // Load data with error handling
            List<User> allUsers = new ArrayList<>();
            List<Service> allServices = new ArrayList<>();
            List<Staff> allStaff = new ArrayList<>();
            
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
            
            // Đã xóa toàn bộ logic tính toán activeUsers vì không còn dữ liệu booking
            // ... giữ lại các phần lấy user, service, staff, notification nếu cần ...
            
            // Calculate available staff
            int availableStaff = 0;
            for (Staff staff : allStaff) {
                if (staff.isStaffStatus()) {
                    availableStaff++;
                }
            }
            
            // Set attributes
            request.setAttribute("userCount", allUsers.size());
            request.setAttribute("serviceCount", allServices.size());
            request.setAttribute("staffCount", allStaff.size());
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
            
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("recentServices", recentServices);
            request.setAttribute("recentStaff", recentStaff);
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

            String search = request.getParameter("search");
            String status = request.getParameter("status");
            String position = request.getParameter("position");

            List<Staff> allStaff = staffDAO.getAllStaff();
            List<Staff> filteredStaff = new ArrayList<>();

            for (Staff staff : allStaff) {
                boolean match = true;
                if (search != null && !search.trim().isEmpty()) {
                    String s = search.trim().toLowerCase();
                    if (!(staff.getStaffName().toLowerCase().contains(s) || staff.getStaffEmail().toLowerCase().contains(s))) {
                        match = false;
                    }
                }
                if (status != null && !status.isEmpty()) {
                    boolean isActive = "Active".equals(status);
                    if (staff.isStaffStatus() != isActive) {
                        match = false;
                    }
                }
                if (position != null && !position.isEmpty()) {
                    if (!position.equals(staff.getStaffPosition())) {
                        match = false;
                    }
                }
                if (match) filteredStaff.add(staff);
            }

            int totalStaff = filteredStaff.size();
            int activeStaff = 0;
            int inactiveStaff = 0;
            for (Staff staff : filteredStaff) {
                if (staff.isStaffStatus()) activeStaff++;
                else inactiveStaff++;
            }

            request.setAttribute("allStaff", filteredStaff);
            request.setAttribute("staffCount", totalStaff);
            request.setAttribute("activeStaffCount", activeStaff);
            request.setAttribute("inactiveStaffCount", inactiveStaff);
            request.setAttribute("search", search);
            request.setAttribute("status", status);
            request.setAttribute("position", position);

            System.out.println("AdminController: Forwarding to AdminStaff.jsp");
            request.getRequestDispatcher("AdminStaff.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("AdminController: Error in showStaff: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Thêm mới nhân viên
    private void addStaff(HttpServletRequest request, HttpServletResponse response, StaffDAO staffDAO) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        String status = request.getParameter("status");
        Staff staff = new Staff();
        staff.setStaffName(name);
        staff.setStaffEmail(email);
        staff.setStaffPosition(position);
        staff.setStaffStatus("Active".equals(status));
        staff.setPassword("123456"); // Mặc định password
        staff.setStaffImage(""); // Mặc định không có ảnh
        staffDAO.addStaff(staff);
        response.sendRedirect("AdminController?action=staff");
    }

    // Sửa thông tin nhân viên
    private void editStaff(HttpServletRequest request, HttpServletResponse response, StaffDAO staffDAO) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String position = request.getParameter("position");
        String status = request.getParameter("status");
        try {
            if (idStr == null || idStr.isEmpty()) throw new Exception("Thiếu id nhân viên");
            int id = Integer.parseInt(idStr);
            if (name == null || name.isEmpty()) throw new Exception("Thiếu tên nhân viên");
            if (email == null || email.isEmpty()) throw new Exception("Thiếu email nhân viên");
            if (position == null) position = "";
            if (status == null) status = "Inactive";
            Staff staff = staffDAO.getStaffById(id);
            if (staff == null) throw new Exception("Không tìm thấy nhân viên với id: " + id);
            staff.setStaffName(name);
            staff.setStaffEmail(email);
            staff.setStaffPosition(position);
            staff.setStaffStatus("Active".equals(status));
            staffDAO.updateStaff(staff);
            response.sendRedirect("AdminController?action=staff");
        } catch (Exception ex) {
            System.out.println("[ERROR] editStaff: " + ex.getMessage());
            ex.printStackTrace();
            request.setAttribute("error", "Lỗi khi sửa nhân viên: " + ex.getMessage());
            showStaff(request, response, staffDAO);
        }
    }

    // Đổi trạng thái nhân viên
    private void toggleStaffStatus(HttpServletRequest request, HttpServletResponse response, StaffDAO staffDAO) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Staff staff = staffDAO.getStaffById(id);
        if (staff != null) {
            staff.setStaffStatus(!staff.isStaffStatus());
            staffDAO.updateStaff(staff);
        }
        response.sendRedirect("AdminController?action=staff");
    }

    // Xem chi tiết nhân viên
    private void viewStaff(HttpServletRequest request, HttpServletResponse response, StaffDAO staffDAO) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Staff staff = staffDAO.getStaffById(id);
        request.setAttribute("staff", staff);
        request.getRequestDispatcher("StaffDetail.jsp").forward(request, response);
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