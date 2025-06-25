package Controller;

import DAO.BookingDAO;
import Model.Shift;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AvailabilityController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            
            BookingDAO bookingDAO = new BookingDAO();
            List<Shift> availableShifts = bookingDAO.getAvailableShifts(bookingDate, serviceId);
            
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(availableShifts);
            
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid date or service\"}");
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