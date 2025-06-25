package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SimpleBookingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Simple Booking Controller Test</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>");
            out.println("</head>");
            out.println("<body class='bg-light'>");
            out.println("<div class='container mt-5'>");
            out.println("<div class='row justify-content-center'>");
            out.println("<div class='col-md-8'>");
            out.println("<div class='card'>");
            out.println("<div class='card-header'>");
            out.println("<h3>Simple Booking Controller Test</h3>");
            out.println("</div>");
            out.println("<div class='card-body'>");
            
            out.println("<p style='color: green;'>✅ SimpleBookingController is working!</p>");
            
            // Show all parameters
            out.println("<h5>Received Parameters:</h5>");
            java.util.Enumeration<String> paramNames = request.getParameterNames();
            if (paramNames.hasMoreElements()) {
                out.println("<ul>");
                while (paramNames.hasMoreElements()) {
                    String paramName = paramNames.nextElement();
                    String paramValue = request.getParameter(paramName);
                    out.println("<li><strong>" + paramName + ":</strong> " + paramValue + "</li>");
                }
                out.println("</ul>");
            } else {
                out.println("<p>No parameters received</p>");
            }
            
            // Show session info
            out.println("<h5>Session Info:</h5>");
            Object user = request.getSession().getAttribute("user");
            if (user != null) {
                out.println("<p style='color: green;'>✅ User logged in: " + user.toString() + "</p>");
            } else {
                out.println("<p style='color: orange;'>[INFO] No user session</p>");
            }
            
            // Test DAO objects
            out.println("<h5>Testing DAO Objects:</h5>");
            try {
                DAO.DaoService serviceDAO = new DAO.DaoService();
                out.println("<p style='color: green;'>✅ DaoService created successfully</p>");
                
                java.util.List<Model.Service> services = serviceDAO.getAllActiveServices();
                out.println("<p style='color: green;'>✅ Services loaded: " + services.size() + " services</p>");
                
            } catch (Exception e) {
                out.println("<p style='color: red;'>[ERROR] DaoService error: " + e.getMessage() + "</p>");
            }
            
            try {
                DAO.StaffDAO staffDAO = new DAO.StaffDAO();
                out.println("<p style='color: green;'>✅ StaffDAO created successfully</p>");
                
                java.util.List<Model.Staff> staff = staffDAO.getActiveStaff();
                out.println("<p style='color: green;'>✅ Staff loaded: " + staff.size() + " staff</p>");
                
            } catch (Exception e) {
                out.println("<p style='color: red;'>[ERROR] StaffDAO error: " + e.getMessage() + "</p>");
            }
            
            out.println("<hr>");
            out.println("<h5>Links:</h5>");
            out.println("<div class='d-grid gap-2'>");
            out.println("<a href='BookingController' class='btn btn-primary'>Test Original BookingController</a>");
            out.println("<a href='BookingForm.jsp' class='btn btn-info'>Go to BookingForm.jsp directly</a>");
            out.println("<a href='home' class='btn btn-secondary'>Back to Home</a>");
            out.println("</div>");
            
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js'></script>");
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