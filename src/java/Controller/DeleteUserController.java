package Controller;

import DAO.DaoUser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DeleteUserController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Delete User</title>");
            out.println("<meta charset='UTF-8'>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; margin: 20px; }");
            out.println(".success { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin: 10px 0; }");
            out.println(".error { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin: 10px 0; }");
            out.println(".info { background: #d1ecf1; color: #0c5460; padding: 15px; border-radius: 5px; margin: 10px 0; }");
            out.println(".btn { padding: 10px 20px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; margin: 5px; }");
            out.println(".btn:hover { background: #c82333; }");
            out.println(".btn-secondary { background: #6c757d; }");
            out.println(".btn-secondary:hover { background: #545b62; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            
            String userID = request.getParameter("userID");
            
            out.println("<h1>Delete User</h1>");
            
            if (userID == null || userID.trim().isEmpty()) {
                out.println("<div class='error'>[ERROR] No user ID provided!</div>");
                out.println("<p>Usage: /delete-user?userID=6</p>");
            } else {
                try {
                    int userId = Integer.parseInt(userID);
                    
                    out.println("<div class='info'>[INFO] Attempting to delete user with ID: " + userId + "</div>");
                    
                    DaoUser daoUser = new DaoUser();
                    
                    // First, check if user exists
                    var user = daoUser.getUserById(userId);
                    
                    if (user == null) {
                        out.println("<div class='error'>[ERROR] User with ID " + userId + " not found!</div>");
                    } else {
                        out.println("<div class='info'>📋 User found:</div>");
                        out.println("<p><strong>Username:</strong> " + user.getUserName() + "</p>");
                        out.println("<p><strong>Full Name:</strong> " + user.getFullName() + "</p>");
                        out.println("<p><strong>Email:</strong> " + user.getEmail() + "</p>");
                        out.println("<p><strong>Is Admin:</strong> " + (user.isAdmin() ? "Yes" : "No") + "</p>");
                        
                        // Check if it's admin user
                        if (user.isAdmin()) {
                            out.println("<div class='error'>[ERROR] Cannot delete admin user!</div>");
                        } else {
                            // Confirm deletion
                            String confirm = request.getParameter("confirm");
                            
                            if ("yes".equals(confirm)) {
                                // Perform deletion
                                boolean success = daoUser.deleteUser(userId);
                                
                                if (success) {
                                    out.println("<div class='success'>✅ User successfully deleted!</div>");
                                    out.println("<p>User ID " + userId + " has been removed from the database.</p>");
                                } else {
                                    out.println("<div class='error'>[ERROR] Failed to delete user!</div>");
                                    out.println("<p>There was an error during deletion. Please try again.</p>");
                                }
                            } else {
                                // Show confirmation
                                out.println("<div class='info'>[INFO] Are you sure you want to delete this user?</div>");
                                out.println("<p>This action cannot be undone.</p>");
                                out.println("<a href='delete-user?userID=" + userId + "&confirm=yes' class='btn'>Yes, Delete User</a>");
                                out.println("<a href='admin' class='btn btn-secondary'>Cancel</a>");
                            }
                        }
                    }
                    
                } catch (NumberFormatException e) {
                    out.println("<div class='error'>[ERROR] Invalid user ID format!</div>");
                    out.println("<p>User ID must be a number.</p>");
                } catch (Exception e) {
                    out.println("<div class='error'>[ERROR] Error occurred: " + e.getMessage() + "</div>");
                    e.printStackTrace();
                }
            }
            
            out.println("<hr>");
            out.println("<p><a href='admin' class='btn btn-secondary'>Back to Admin</a></p>");
            out.println("<p><a href='home' class='btn btn-secondary'>Back to Home</a></p>");
            
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