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
import java.util.List;

public class NotificationController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        NotificationDAO notificationDAO = new NotificationDAO();
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is admin
        if (user == null || !user.isAdmin()) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        if (action == null || action.trim().isEmpty()) {
            listNotifications(request, response, notificationDAO);
            return;
        }
        
        switch (action) {
            case "list":
                listNotifications(request, response, notificationDAO);
                break;
            case "markAsRead":
                markAsRead(request, response, notificationDAO);
                break;
            case "markAllAsRead":
                markAllAsRead(request, response, notificationDAO);
                break;
            case "delete":
                deleteNotification(request, response, notificationDAO);
                break;
            case "getUnreadCount":
                getUnreadCount(request, response, notificationDAO);
                break;
            case "getUnreadNotifications":
                getUnreadNotifications(request, response, notificationDAO);
                break;
            default:
                listNotifications(request, response, notificationDAO);
        }
    }

    private void listNotifications(HttpServletRequest request, HttpServletResponse response, 
                                 NotificationDAO notificationDAO) throws ServletException, IOException {
        try {
            List<Notification> notifications = notificationDAO.getAllNotifications();
            int unreadCount = notificationDAO.getUnreadCount();
            
            request.setAttribute("notifications", notifications);
            request.setAttribute("unreadCount", unreadCount);
            request.getRequestDispatcher("AdminNotifications.jsp").forward(request, response);
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head><title>Lỗi</title></head>");
                out.println("<body>");
                out.println("<h1>Lỗi khi tải thông báo</h1>");
                out.println("<p>Lỗi: " + e.getMessage() + "</p>");
                out.println("<a href='admin'>Ve Dashboard</a>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }

    private void markAsRead(HttpServletRequest request, HttpServletResponse response, 
                          NotificationDAO notificationDAO) throws ServletException, IOException {
        try {
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));
            
            if (notificationDAO.markAsRead(notificationId)) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            response.getWriter().write("error");
        }
    }

    private void markAllAsRead(HttpServletRequest request, HttpServletResponse response, 
                             NotificationDAO notificationDAO) throws ServletException, IOException {
        try {
            if (notificationDAO.markAllAsRead()) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            response.getWriter().write("error");
        }
    }

    private void deleteNotification(HttpServletRequest request, HttpServletResponse response, 
                                  NotificationDAO notificationDAO) throws ServletException, IOException {
        try {
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));
            
            if (notificationDAO.deleteNotification(notificationId)) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            response.getWriter().write("error");
        }
    }

    private void getUnreadCount(HttpServletRequest request, HttpServletResponse response, 
                              NotificationDAO notificationDAO) throws ServletException, IOException {
        try {
            int unreadCount = notificationDAO.getUnreadCount();
            response.getWriter().write(String.valueOf(unreadCount));
        } catch (Exception e) {
            response.getWriter().write("0");
        }
    }

    private void getUnreadNotifications(HttpServletRequest request, HttpServletResponse response, 
                                      NotificationDAO notificationDAO) throws ServletException, IOException {
        try {
            List<Notification> unreadNotifications = notificationDAO.getUnreadNotifications();
            
            // Return JSON response
            response.setContentType("application/json;charset=UTF-8");
            StringBuilder json = new StringBuilder();
            json.append("[");
            
            for (int i = 0; i < unreadNotifications.size(); i++) {
                Notification notification = unreadNotifications.get(i);
                json.append("{");
                json.append("\"id\":").append(notification.getNotificationId()).append(",");
                json.append("\"title\":\"").append(escapeJson(notification.getTitle())).append("\",");
                json.append("\"message\":\"").append(escapeJson(notification.getMessage())).append("\",");
                json.append("\"type\":\"").append(notification.getType()).append("\",");
                json.append("\"timeAgo\":\"").append(escapeJson(notification.getTimeAgo())).append("\",");
                json.append("\"relatedBookingId\":").append(notification.getRelatedBookingId());
                json.append("}");
                
                if (i < unreadNotifications.size() - 1) {
                    json.append(",");
                }
            }
            
            json.append("]");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            response.getWriter().write("[]");
        }
    }

    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
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