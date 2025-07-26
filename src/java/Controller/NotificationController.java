// Controller for admin notifications.
package Controller;

import DAO.NotificationDAO;
import Model.Notification;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

public class NotificationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isAdmin()) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String action = request.getParameter("action");
        NotificationDAO notificationDAO = new NotificationDAO();
        if (action == null || action.equals("list")) {
            List<Notification> notifications = notificationDAO.getAllNotifications();
            int unreadCount = notificationDAO.getUnreadCount();
            
            // Sort notifications by creation date (newest first)
            notifications.sort((n1, n2) -> n2.getCreatedAt().compareTo(n1.getCreatedAt()));
            
            request.setAttribute("notifications", notifications);
            request.setAttribute("unreadCount", unreadCount);
            request.getRequestDispatcher("AdminNotifications.jsp").forward(request, response);
        } else if (action.equals("markAsRead")) {
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));
            boolean success = notificationDAO.markAsRead(notificationId);
            response.setContentType("text/plain");
            response.getWriter().write(success ? "success" : "error");
        } else if (action.equals("delete")) {
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));
            boolean success = notificationDAO.deleteNotification(notificationId);
            response.setContentType("text/plain");
            response.getWriter().write(success ? "success" : "error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 