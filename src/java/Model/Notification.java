package Model;

import java.sql.Timestamp;

public class Notification {
    private int notificationId;
    private String title;
    private String message;
    private String type; // "booking", "system", "alert"
    private String status; // "unread", "read"
    private Timestamp createdAt;
    private Timestamp readAt;
    private int relatedBookingId; // ID của booking liên quan (nếu có)
    private int userId;
    private String content;
    
    // Reference objects
    private Booking relatedBooking;
    
    public Notification() {
        this.status = "unread";
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }
    
    public Notification(String title, String message, String type) {
        this();
        this.title = title;
        this.message = message;
        this.type = type;
    }
    
    public Notification(String title, String message, String type, int relatedBookingId) {
        this(title, message, type);
        this.relatedBookingId = relatedBookingId;
    }

    // Getters and Setters
    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getReadAt() {
        return readAt;
    }

    public void setReadAt(Timestamp readAt) {
        this.readAt = readAt;
    }

    public int getRelatedBookingId() {
        return relatedBookingId;
    }

    public void setRelatedBookingId(int relatedBookingId) {
        this.relatedBookingId = relatedBookingId;
    }

    public Booking getRelatedBooking() {
        return relatedBooking;
    }

    public void setRelatedBooking(Booking relatedBooking) {
        this.relatedBooking = relatedBooking;
    }

    public void setUserId(int userId) { this.userId = userId; }
    public int getUserId() { return userId; }
    public void setContent(String content) { this.content = content; }
    public String getContent() { return content; }
    
    // Helper methods
    public boolean isUnread() {
        return "unread".equals(this.status);
    }
    
    public boolean isRead() {
        return "read".equals(this.status);
    }
    
    public String getTimeAgo() {
        if (createdAt == null) return "";
        
        long now = System.currentTimeMillis();
        long diff = now - createdAt.getTime();
        
        long seconds = diff / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;
        
        if (days > 0) {
            return days + " ngay truoc";
        } else if (hours > 0) {
            return hours + " gio truoc";
        } else if (minutes > 0) {
            return minutes + " phut truoc";
        } else {
            return "Vua xong";
        }
    }
} 