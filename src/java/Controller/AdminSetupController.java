package Controller;

import DAO.DaoUser;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminSetupController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        DaoUser daoUser = new DaoUser();
        
        if ("setup".equals(action)) {
            // Check if any admin exists
            if (daoUser.checkIfAdminExists()) {
                request.setAttribute("error", "Admin already exists!");
                request.getRequestDispatcher("AdminSetup.jsp").forward(request, response);
                return;
            }
            
            // Create first admin
            String userName = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String birthDate = request.getParameter("birthDate");
            String address = request.getParameter("address");
            
            User admin = new User();
            admin.setUserName(userName);
            admin.setPassword(password); // In production, hash this!
            admin.setEmail(email);
            admin.setFullName(fullName);
            admin.setPhone(phone);
            admin.setGender(gender);
            admin.setBirthDate(java.sql.Date.valueOf(birthDate));
            admin.setAddress(address);
            admin.setAdmin(true);
            admin.setUserStatus(true);
            
            if (daoUser.registerUser(admin)) {
                request.setAttribute("success", "Admin account created successfully! You can now login.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to create admin account!");
                request.getRequestDispatcher("AdminSetup.jsp").forward(request, response);
            }
        } else {
            // Show setup form
            request.getRequestDispatcher("AdminSetup.jsp").forward(request, response);
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