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
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author sontu
 */
public class LoginController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // Debug information
            System.out.println("Login attempt - Email: " + email);
            
            DaoUser daoUser = new DaoUser();
            User u = daoUser.checkLogin(email, password); // Lấy user từ DB
            
            if (u == null) {
                System.out.println("Login failed - Invalid credentials");
                request.setAttribute("mess", "Tài khoản hoặc mật khẩu chưa chính xác");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            } else if (!u.isUserStatus()) {
                System.out.println("Login failed - User banned");
                request.setAttribute("mess", "Tài khoản đã bị cấm!");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
                return;
            }
            
            // Login successful
            System.out.println("Login successful - User: " + u.getFullName() + ", Is Admin: " + u.isAdmin());
            
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            
            // Redirect based on user type
            if (u.isAdmin()) {
                System.out.println("Redirecting admin to AdminController");
                response.sendRedirect("admin");
            } else {
                System.out.println("Redirecting user to home");
                response.sendRedirect("home");
            }
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
