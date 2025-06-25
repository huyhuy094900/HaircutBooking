/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.DaoService;
import Model.Service;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author sontu
 */
public class HomeController extends HttpServlet {

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
            // Check if user is admin and redirect to admin dashboard
            HttpSession session = request.getSession();
            Object userObj = session.getAttribute("user");
            
            if (userObj != null) {
                // Use reflection to check if user is admin
                try {
                    java.lang.reflect.Method isAdminMethod = userObj.getClass().getMethod("isAdmin");
                    Boolean isAdmin = (Boolean) isAdminMethod.invoke(userObj);
                    if (isAdmin != null && isAdmin) {
                        System.out.println("HomeController: Admin detected, redirecting to AdminDashboardController");
                        response.sendRedirect("AdminDashboardController");
                        return;
                    }
                } catch (Exception e) {
                    System.out.println("HomeController: Error checking admin status: " + e.getMessage());
                }
            }
            
            System.out.println("HomeController: Starting to load services...");
            
            DaoService daoService = new DaoService();
            List<Service> list3Services = new ArrayList<>();
            
            try {
                list3Services = daoService.get3Service();
                System.out.println("HomeController: Found " + list3Services.size() + " services");
            } catch (Exception e) {
                System.out.println("HomeController: Error loading services: " + e.getMessage());
                e.printStackTrace();
                // Continue with empty list instead of crashing
            }
            
            request.setAttribute("list3Services", list3Services);
            System.out.println("HomeController: Forwarding to Home.jsp");
            request.getRequestDispatcher("Home.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("HomeController: Critical error: " + e.getMessage());
            e.printStackTrace();
            
            // Fallback: show error page
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Error - HaircutBooking</title>");
                out.println("<link href='assets/vendor/bootstrap/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container mt-5'>");
                out.println("<div class='alert alert-danger'>");
                out.println("<h4>[ERROR] Loi he thong</h4>");
                out.println("<p>Khong the tai trang chu. Vui long thu lai sau.</p>");
                out.println("<p><strong>Lỗi:</strong> " + e.getMessage() + "</p>");
                out.println("<a href='Login.jsp' class='btn btn-primary'>Ve trang dang nhap</a>");
                out.println("<a href='dbtest' class='btn btn-info'>Kiểm tra database</a>");
                out.println("</div>");
                out.println("</div>");
                out.println("</body>");
                out.println("</html>");
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
