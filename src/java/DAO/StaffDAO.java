package DAO;

import Model.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO extends DBContext {

    public Staff checkLogin(String email, String password) {
        String sql = "SELECT * FROM Staff WHERE staff_email = ? AND password = ? AND staff_status = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addStaff(Staff staff) {
        String sql = "INSERT INTO Staff (staff_name, staff_email, password, staff_image, staff_status, staff_position) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getStaffEmail());
            ps.setString(3, staff.getPassword());
            ps.setString(4, staff.getStaffImage());
            ps.setBoolean(5, staff.isStaffStatus());
            ps.setString(6, staff.getStaffPosition());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStaff(Staff staff) {
        String sql = "UPDATE Staff SET staff_name = ?, staff_email = ?, staff_image = ?, staff_position = ?, staff_status = ? WHERE staff_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getStaffEmail());
            ps.setString(3, staff.getStaffImage());
            ps.setString(4, staff.getStaffPosition());
            ps.setBoolean(5, staff.isStaffStatus());
            ps.setInt(6, staff.getStaffId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(int staffId, String newPassword) {
        String sql = "UPDATE Staff SET password = ? WHERE staff_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, staffId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean activateStaff(int staffId) {
        String sql = "UPDATE Staff SET staff_status = TRUE WHERE staff_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deactivateStaff(int staffId) {
        String sql = "UPDATE Staff SET staff_status = FALSE WHERE staff_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM Staff ORDER BY staff_name";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                staffList.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public List<Staff> getActiveStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM Staff WHERE staff_status = TRUE ORDER BY staff_name";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                staffList.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public Staff getStaffById(int staffId) {
        String sql = "SELECT * FROM Staff WHERE staff_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStaff(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Staff WHERE staff_email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Staff> getStaffByService(int serviceId) {
        // This would require a Staff_Services junction table
        // For now, return all active staff
        return getActiveStaff();
    }

    public int getStaffBookingCount(int staffId) {
        String sql = "SELECT COUNT(*) FROM Bookings WHERE staff_id = ? AND status = 'Completed'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setStaffId(rs.getInt("staff_id"));
        staff.setStaffName(rs.getString("staff_name"));
        staff.setStaffEmail(rs.getString("staff_email"));
        staff.setPassword(rs.getString("password"));
        staff.setStaffImage(rs.getString("staff_image"));
        staff.setCreatedAt(rs.getTimestamp("created_at"));
        staff.setStaffStatus(rs.getBoolean("staff_status"));
        staff.setStaffPosition(rs.getString("staff_position"));
        return staff;
    }
} 