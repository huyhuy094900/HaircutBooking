package DAO;

import Model.Notification;
import Model.Booking;
import Model.User;
import Model.Service;
import Model.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO extends DBContext {

    public boolean createNotification(Notification notification) {
        String sql = "INSERT INTO Notifications (title, message, type, status, created_at, related_booking_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, notification.getTitle());
            ps.setString(2, notification.getMessage());
            ps.setString(3, notification.getType());
            ps.setString(4, notification.getStatus());
            ps.setTimestamp(5, notification.getCreatedAt());
            ps.setInt(6, notification.getRelatedBookingId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE Notifications SET status = 'read', read_at = NOW() WHERE notification_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean markAllAsRead() {
        String sql = "UPDATE Notifications SET status = 'read', read_at = NOW() WHERE status = 'unread'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteNotification(int notificationId) {
        String sql = "DELETE FROM Notifications WHERE notification_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Notification> getAllNotifications() {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT n.*, b.booking_id, b.booking_date, b.status as booking_status, " +
                    "u.full_name as user_name, s.name as service_name, st.staff_name " +
                    "FROM Notifications n " +
                    "LEFT JOIN Bookings b ON n.related_booking_id = b.booking_id " +
                    "LEFT JOIN Users u ON b.user_id = u.user_id " +
                    "LEFT JOIN Services s ON b.service_id = s.service_id " +
                    "LEFT JOIN Staff st ON b.staff_id = st.staff_id " +
                    "ORDER BY n.created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Notification notification = mapResultSetToNotification(rs);
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public List<Notification> getUnreadNotifications() {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT n.*, b.booking_id, b.booking_date, b.status as booking_status, " +
                    "u.full_name as user_name, s.name as service_name, st.staff_name " +
                    "FROM Notifications n " +
                    "LEFT JOIN Bookings b ON n.related_booking_id = b.booking_id " +
                    "LEFT JOIN Users u ON b.user_id = u.user_id " +
                    "LEFT JOIN Services s ON b.service_id = s.service_id " +
                    "LEFT JOIN Staff st ON b.staff_id = st.staff_id " +
                    "WHERE n.status = 'unread' " +
                    "ORDER BY n.created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Notification notification = mapResultSetToNotification(rs);
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public List<Notification> getNotificationsByType(String type) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT n.*, b.booking_id, b.booking_date, b.status as booking_status, " +
                    "u.full_name as user_name, s.name as service_name, st.staff_name " +
                    "FROM Notifications n " +
                    "LEFT JOIN Bookings b ON n.related_booking_id = b.booking_id " +
                    "LEFT JOIN Users u ON b.user_id = u.user_id " +
                    "LEFT JOIN Services s ON b.service_id = s.service_id " +
                    "LEFT JOIN Staff st ON b.staff_id = st.staff_id " +
                    "WHERE n.type = ? " +
                    "ORDER BY n.created_at DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Notification notification = mapResultSetToNotification(rs);
                    notifications.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public int getUnreadCount() {
        String sql = "SELECT COUNT(*) FROM Notifications WHERE status = 'unread'";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Notification getNotificationById(int notificationId) {
        String sql = "SELECT n.*, b.booking_id, b.booking_date, b.status as booking_status, " +
                    "u.full_name as user_name, s.name as service_name, st.staff_name " +
                    "FROM Notifications n " +
                    "LEFT JOIN Bookings b ON n.related_booking_id = b.booking_id " +
                    "LEFT JOIN Users u ON b.user_id = u.user_id " +
                    "LEFT JOIN Services s ON b.service_id = s.service_id " +
                    "LEFT JOIN Staff st ON b.staff_id = st.staff_id " +
                    "WHERE n.notification_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, notificationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNotification(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Notification mapResultSetToNotification(ResultSet rs) throws SQLException {
        Notification notification = new Notification();
        notification.setNotificationId(rs.getInt("notification_id"));
        notification.setTitle(rs.getString("title"));
        notification.setMessage(rs.getString("message"));
        notification.setType(rs.getString("type"));
        notification.setStatus(rs.getString("status"));
        notification.setCreatedAt(rs.getTimestamp("created_at"));
        notification.setReadAt(rs.getTimestamp("read_at"));
        notification.setRelatedBookingId(rs.getInt("related_booking_id"));

        // Map related booking if exists - simplified without reference objects
        if (rs.getInt("booking_id") != 0) {
            Booking booking = new Booking();
            booking.setBookingId(rs.getInt("booking_id"));
            booking.setBookingDate(rs.getDate("booking_date"));
            booking.setStatus(rs.getString("booking_status"));
            
            // Note: We'll populate user, service, staff info separately if needed
            // For now, just set the basic booking info
            
            notification.setRelatedBooking(booking);
        }

        return notification;
    }

    // Method to create booking notification
    public boolean createBookingNotification(Booking booking, String userFullName, String serviceName, String staffName) {
        String title = "Dat lich moi";
        String message = String.format("Khach hang %s da dat lich dich vu %s voi %s vao ngay %s. Vui long kiem tra lich trung.",
                userFullName, serviceName, staffName, booking.getBookingDate());
        
        Notification notification = new Notification(title, message, "booking", booking.getBookingId());
        return createNotification(notification);
    }

    // Method to create conflict notification
    public boolean createConflictNotification(Booking booking, String userFullName, String serviceName, String staffName) {
        String title = "TRUNG LICH - Can xac nhan";
        String message = String.format("KHACH HANG %s DAT LICH TRUNG VOI LICH DA CO! Dich vu: %s, Stylist: %s, Ngay: %s. CAN XAC NHAN NGAY!",
                userFullName.toUpperCase(), serviceName, staffName, booking.getBookingDate());
        
        Notification notification = new Notification(title, message, "alert", booking.getBookingId());
        return createNotification(notification);
    }
} 