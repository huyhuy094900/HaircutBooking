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

public class TestLoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Test Login Debug</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h2>Test Login Debug</h2>");
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            out.println("<p><strong>Received parameters:</strong></p>");
            out.println("<p>Email: " + (email != null ? email : "NULL") + "</p>");
            out.println("<p>Password: " + (password != null ? password : "NULL") + "</p>");
            
            if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
                out.println("<p style='color: red;'>Missing email or password</p>");
                out.println("<p><a href='Login.jsp'>Back to Login</a></p>");
                out.println("</body></html>");
                return;
            }
            
            out.println("<p><strong>Testing database connection...</strong></p>");
            
            try {
                DaoUser daoUser = new DaoUser();
                out.println("<p style='color: green;'>DaoUser created successfully</p>");
                
                out.println("<p><strong>Checking login...</strong></p>");
                User u = daoUser.checkLogin(email, password);
                
                if (u == null) {
                    out.println("<p style='color: red;'>Login failed - Invalid credentials</p>");
                    out.println("<p>Email: " + email + "</p>");
                    out.println("<p>Password: " + password + "</p>");
                } else {
                    out.println("<p style='color: green;'>Login successful!</p>");
                    out.println("<p><strong>User details:</strong></p>");
                    out.println("<p>ID: " + u.getUserId() + "</p>");
                    out.println("<p>Name: " + u.getFullName() + "</p>");
                    out.println("<p>Email: " + u.getEmail() + "</p>");
                    out.println("<p>Is Admin: " + u.isAdmin() + "</p>");
                    out.println("<p>Status: " + u.isUserStatus() + "</p>");
                    
                    if (!u.isUserStatus()) {
                        out.println("<p style='color: red;'>User is banned!</p>");
                    } else {
                        out.println("<p style='color: green;'>User is active</p>");
                        
                        // Test session
                        HttpSession session = request.getSession();
                        session.setAttribute("user", u);
                        out.println("<p style='color: green;'>Session created</p>");
                        
                        // Test redirect
                        if (u.isAdmin()) {
                            out.println("<p>Would redirect to: /admin</p>");
                            out.println("<p><a href='admin'>Go to Admin Dashboard</a></p>");
                        } else {
                            out.println("<p>Would redirect to: /home</p>");
                            out.println("<p><a href='home'>Go to Home</a></p>");
                        }
                    }
                }
                
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
            
            out.println("<hr>");
            out.println("<p><a href='Login.jsp'>Back to Login</a></p>");
            out.println("<p><a href='test_users.jsp'>Check Users</a></p>");
            out.println("</body>");
            out.println("</html>");
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