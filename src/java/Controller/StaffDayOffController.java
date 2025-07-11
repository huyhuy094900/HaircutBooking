// Nếu gặp lỗi import javax.servlet.* không resolve được:
// 1. Đảm bảo đã add đúng thư viện servlet-api.jar vào classpath (thường nằm trong thư mục lib hoặc do server cung cấp)
// 2. Nếu dùng Jakarta EE 9+ thì đổi lại thành jakarta.servlet.*
// 3. Nếu vẫn lỗi, kiểm tra cấu hình IDE/project.
package Controller;

import DAO.StaffDayOffRequestDAO;
import DAO.BookingDAO;
import DAO.NotificationDAO;
import Model.StaffDayOffRequest;
import Model.Booking;
import Model.Notification;
import Model.User;
import Model.Staff;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

public class StaffDayOffController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        StaffDayOffRequestDAO dao = new StaffDayOffRequestDAO();
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        if (user.isAdmin()) {
            // Admin xem danh sách yêu cầu nghỉ
            List<StaffDayOffRequest> requests = dao.getAllRequests();
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("AdminStaffDayOffRequests.jsp").forward(request, response);
        } else {
            // Staff xem yêu cầu đã gửi
            List<StaffDayOffRequest> requests = dao.getRequestsByStaff(user.getUserId());
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("StaffDayOffRequests.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        StaffDayOffRequestDAO dao = new StaffDayOffRequestDAO();
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String action = request.getParameter("action");
        if (action == null) {
            // Staff gửi yêu cầu nghỉ
            String offDate = request.getParameter("off_date");
            String reason = request.getParameter("reason");
            StaffDayOffRequest req = new StaffDayOffRequest();
            req.setStaffId(user.getUserId());
            req.setOffDate(Date.valueOf(offDate));
            req.setReason(reason);
            dao.createRequest(req);
            response.sendRedirect("StaffDashboardController?action=viewTodayBookings&msg=sent");
        } else if (action.equals("approve") || action.equals("reject")) {
            // Admin duyệt hoặc từ chối
            int requestId = Integer.parseInt(request.getParameter("request_id"));
            String status = action.equals("approve") ? "Approved" : "Rejected";
            dao.updateStatus(requestId, status, user.getUserId());
            StaffDayOffRequest req = dao.getRequestById(requestId);
            if (status.equals("Approved")) {
                // Tự động hủy booking, gửi notification cho user
                BookingDAO bookingDAO = new BookingDAO();
                NotificationDAO notiDAO = new NotificationDAO();
                java.sql.Date sqlDate = new java.sql.Date(req.getOffDate().getTime());
                List<Booking> bookings = bookingDAO.getBookingsByStaffAndDate(req.getStaffId(), sqlDate);
                for (Booking b : bookings) {
                    bookingDAO.cancelBookingWithNote(b.getBookingId(), "Thợ bận, vui lòng đổi ngày hoặc chọn thợ khác");
                    // Gửi notification cho user
                    Notification n = new Notification();
                    n.setUserId(b.getUser().getUserId());
                    n.setTitle("Lịch hẹn bị hủy do thợ bận");
                    n.setContent("Lịch hẹn của bạn với " + b.getStaff().getStaffName() + " vào ngày " + req.getOffDate() + " đã bị hủy do thợ bận. Vui lòng đặt lại lịch hoặc chọn thợ khác.");
                    n.setType("alert");
                    n.setStatus("unread");
                    n.setRelatedBookingId(b.getBookingId());
                    notiDAO.createNotification(n);
                }
                // Gửi notification cho staff
                Notification nStaff = new Notification();
                nStaff.setUserId(req.getStaffId());
                nStaff.setTitle("Yêu cầu nghỉ đã được duyệt");
                nStaff.setContent("Yêu cầu nghỉ ngày " + req.getOffDate() + " của bạn đã được duyệt.");
                nStaff.setType("system");
                nStaff.setStatus("unread");
                notiDAO.createNotification(nStaff);
            } else {
                // Gửi notification cho staff khi bị từ chối
                NotificationDAO notiDAO = new NotificationDAO();
                Notification nStaff = new Notification();
                nStaff.setUserId(req.getStaffId());
                nStaff.setTitle("Yêu cầu nghỉ bị từ chối");
                nStaff.setContent("Yêu cầu nghỉ ngày " + req.getOffDate() + " của bạn đã bị từ chối.");
                nStaff.setType("system");
                nStaff.setStatus("unread");
                notiDAO.createNotification(nStaff);
            }
            response.sendRedirect("StaffDayOffController");
        }
    }
} 