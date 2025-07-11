package DAO;

import Model.StaffDayOffRequest;
import java.sql.*;
import java.util.*;

public class StaffDayOffRequestDAO extends DBContext {
    public boolean createRequest(StaffDayOffRequest req) {
        String sql = "INSERT INTO StaffDayOffRequests (staff_id, off_date, reason) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, req.getStaffId());
            ps.setDate(2, new java.sql.Date(req.getOffDate().getTime()));
            ps.setString(3, req.getReason());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    public List<StaffDayOffRequest> getRequestsByStaff(int staffId) {
        List<StaffDayOffRequest> list = new ArrayList<>();
        String sql = "SELECT * FROM StaffDayOffRequests WHERE staff_id = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    public List<StaffDayOffRequest> getAllRequests() {
        List<StaffDayOffRequest> list = new ArrayList<>();
        String sql = "SELECT r.*, s.staff_name, u.full_name as admin_name FROM StaffDayOffRequests r LEFT JOIN Staff s ON r.staff_id=s.staff_id LEFT JOIN Users u ON r.reviewed_by=u.user_id ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    public StaffDayOffRequest getRequestById(int requestId) {
        String sql = "SELECT * FROM StaffDayOffRequests WHERE request_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, requestId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
    public boolean updateStatus(int requestId, String status, int adminId) {
        String sql = "UPDATE StaffDayOffRequests SET status=?, reviewed_at=NOW(), reviewed_by=? WHERE request_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, adminId);
            ps.setInt(3, requestId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    private StaffDayOffRequest map(ResultSet rs) throws SQLException {
        StaffDayOffRequest r = new StaffDayOffRequest();
        r.setRequestId(rs.getInt("request_id"));
        r.setStaffId(rs.getInt("staff_id"));
        r.setOffDate(rs.getDate("off_date"));
        r.setReason(rs.getString("reason"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setReviewedAt(rs.getTimestamp("reviewed_at"));
        r.setReviewedBy((Integer)rs.getObject("reviewed_by"));
        try { r.setStaffName(rs.getString("staff_name")); } catch(Exception ex){}
        try { r.setAdminName(rs.getString("admin_name")); } catch(Exception ex){}
        return r;
    }
} 