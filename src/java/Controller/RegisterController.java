/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.DaoUser;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

/**
 *
 * @author sontu
 */
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Get parameters
            String userName = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String dob = request.getParameter("DOB");
            String gender = request.getParameter("gender");
            
            System.out.println("RegisterController: Processing registration...");
            System.out.println("Username: " + userName);
            System.out.println("Email: " + email);
            System.out.println("FullName: " + fullName);
            
            // Validation
            if (userName == null || userName.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                dob == null || dob.trim().isEmpty() ||
                gender == null || gender.trim().isEmpty()) {
                
                request.setAttribute("mess", "Vui long dien day du thong tin!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            
            // Trim whitespace
            userName = userName.trim();
            password = password.trim();
            email = email.trim();
            fullName = fullName.trim();
            phone = phone.trim();
            gender = gender.trim();
            
            DaoUser daoUser = new DaoUser();
            
            // Check if username exists
            if (daoUser.checkUserName(userName)) {
                System.out.println("RegisterController: Username already exists");
                request.setAttribute("mess", "Tài khoản này đã tồn tại!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            
            // Check if email exists
            if (daoUser.checkEmail(email)) {
                System.out.println("RegisterController: Email already exists");
                request.setAttribute("mess", "Email này đã được sử dụng!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            
            // Convert gender values
            String genderValue = gender;
            if ("man".equals(gender)) {
                genderValue = "Male";
            } else if ("woman".equals(gender)) {
                genderValue = "Female";
            } else if ("other".equals(gender)) {
                genderValue = "Other";
            }
            
            // Convert date string to Date object
            Date birthDate = null;
            try {
                birthDate = Date.valueOf(dob);
            } catch (Exception e) {
                System.out.println("RegisterController: Invalid date format: " + dob);
                request.setAttribute("mess", "Ngày sinh không hợp lệ!");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
                return;
            }
            
            // Create User object
            User newUser = new User();
            newUser.setUserName(userName);
            newUser.setPassword(password);
            newUser.setEmail(email);
            newUser.setFullName(fullName);
            newUser.setPhone(phone);
            newUser.setGender(genderValue);
            newUser.setBirthDate(birthDate);
            newUser.setAdmin(false);
            newUser.setUserStatus(true);
            
            // Register user
            boolean success = daoUser.registerUser(newUser);
            
            if (success) {
                System.out.println("RegisterController: Registration successful");
                request.setAttribute("mess", "Dang ky thanh cong! Vui long dang nhap.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                System.out.println("RegisterController: Registration failed");
                request.setAttribute("mess", "Dang ky that bai! Vui long thu lai.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            System.out.println("RegisterController: Error during registration: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("mess", "Có lỗi xảy ra! Vui lòng thử lại.");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
