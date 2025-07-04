package DAO;

import Model.Booking;
import Model.Service;
import Model.Staff;
import Model.Shift;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO extends DBContext {

    public boolean createBooking(Booking booking) {
        String sql = "INSERT INTO Bookings (user_id, service_id, staff_id, shifts_id, booking_date, status, note, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getServiceId());
            ps.setInt(3, booking.getStaffId());
            ps.setInt(4, booking.getShiftsId());
            ps.setDate(5, booking.getBookingDate());
            ps.setString(6, booking.getStatus() != null ? booking.getStatus() : "Pending");
            ps.setString(7, booking.getNote());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        String sql = "UPDATE Bookings SET status = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelBooking(int bookingId, String reason) {
        String sql = "UPDATE Bookings SET status = 'Canceled', note = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reason);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name as user_name, s.name as service_name, st.staff_name, sh.start_time, sh.end_time " +
                    "FROM Bookings b " +
                    "JOIN Users u ON b.user_id = u.user_id " +
                    "JOIN Services s ON b.service_id = s.service_id " +
                    "JOIN Staff st ON b.staff_id = st.staff_id " +
                    "JOIN Shifts sh ON b.shifts_id = sh.shifts_id " +
                    "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking booking = mapResultSetToBooking(rs);
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name as user_name, s.name as service_name, st.staff_name, sh.start_time, sh.end_time " +
                    "FROM Bookings b " +
                    "JOIN Users u ON b.user_id = u.user_id " +
                    "JOIN Services s ON b.service_id = s.service_id " +
                    "JOIN Staff st ON b.staff_id = st.staff_id " +
                    "JOIN Shifts sh ON b.shifts_id = sh.shifts_id " +
                    "ORDER BY b.booking_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking booking = mapResultSetToBooking(rs);
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getBookingsByDate(Date date) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name as user_name, s.name as service_name, st.staff_name, sh.start_time, sh.end_time " +
                    "FROM Bookings b " +
                    "JOIN Users u ON b.user_id = u.user_id " +
                    "JOIN Services s ON b.service_id = s.service_id " +
                    "JOIN Staff st ON b.staff_id = st.staff_id " +
                    "JOIN Shifts sh ON b.shifts_id = sh.shifts_id " +
                    "WHERE b.booking_date = ? ORDER BY sh.start_time";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, date);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking booking = mapResultSetToBooking(rs);
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public boolean isTimeSlotAvailable(int staffId, int shiftId, Date bookingDate) {
        String sql = "SELECT COUNT(*) FROM Bookings WHERE staff_id = ? AND shifts_id = ? AND booking_date = ? AND status != 'Canceled'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, shiftId);
            ps.setDate(3, bookingDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasTimeSlotConflict(int staffId, int shiftId, Date bookingDate) {
        String sql = "SELECT COUNT(*) FROM Bookings WHERE staff_id = ? AND shifts_id = ? AND booking_date = ? AND status IN ('Pending', 'Confirmed')";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, shiftId);
            ps.setDate(3, bookingDate);
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

    public List<Shift> getAvailableShifts(Date bookingDate, int serviceId) {
        List<Shift> availableShifts = new ArrayList<>();
        
        // Logic đơn giản: lấy tất cả shifts và kiểm tra từng shift xem có stylist nào available không
        // Vì Staff không có service_id, tất cả staff có thể làm tất cả services
        String sql = "SELECT DISTINCT sh.* FROM Shifts sh " +
                    "WHERE EXISTS (" +
                    "    SELECT 1 FROM Staff st " +
                    "    WHERE st.staff_status = TRUE " +
                    "    AND NOT EXISTS (" +
                    "        SELECT 1 FROM Bookings b " +
                    "        WHERE b.staff_id = st.staff_id " +
                    "        AND b.shifts_id = sh.shifts_id " +
                    "        AND b.booking_date = ? " +
                    "        AND b.status != 'Canceled'" +
                    "    )" +
                    ") ORDER BY sh.start_time";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, bookingDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Shift shift = new Shift();
                    shift.setShiftsId(rs.getInt("shifts_id"));
                    shift.setStartTime(rs.getTime("start_time"));
                    shift.setEndTime(rs.getTime("end_time"));
                    availableShifts.add(shift);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableShifts;
    }

    public List<Shift> getAllShifts() {
        List<Shift> shifts = new ArrayList<>();
        String sql = "SELECT * FROM Shifts ORDER BY start_time";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Shift shift = new Shift();
                shift.setShiftsId(rs.getInt("shifts_id"));
                shift.setStartTime(rs.getTime("start_time"));
                shift.setEndTime(rs.getTime("end_time"));
                shifts.add(shift);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shifts;
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT b.*, u.full_name as user_name, s.name as service_name, st.staff_name, sh.start_time, sh.end_time " +
                    "FROM Bookings b " +
                    "JOIN Users u ON b.user_id = u.user_id " +
                    "JOIN Services s ON b.service_id = s.service_id " +
                    "JOIN Staff st ON b.staff_id = st.staff_id " +
                    "JOIN Shifts sh ON b.shifts_id = sh.shifts_id " +
                    "WHERE b.booking_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setServiceId(rs.getInt("service_id"));
        booking.setStaffId(rs.getInt("staff_id"));
        booking.setShiftsId(rs.getInt("shifts_id"));
        booking.setBookingDate(rs.getDate("booking_date"));
        booking.setStatus(rs.getString("status"));
        booking.setNote(rs.getString("note"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Set reference objects
        User user = new User();
        user.setFullName(rs.getString("user_name"));
        booking.setUser(user);
        
        Service service = new Service();
        service.setName(rs.getString("service_name"));
        booking.setService(service);
        
        Staff staff = new Staff();
        staff.setStaffName(rs.getString("staff_name"));
        booking.setStaff(staff);
        
        Shift shift = new Shift();
        shift.setStartTime(rs.getTime("start_time"));
        shift.setEndTime(rs.getTime("end_time"));
        booking.setShift(shift);
        
        return booking;
    }

    public List<Booking> getBookingsByStatus(String status) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.full_name as user_name, s.name as service_name, st.staff_name, sh.start_time, sh.end_time " +
                    "FROM Bookings b " +
                    "JOIN Users u ON b.user_id = u.user_id " +
                    "JOIN Services s ON b.service_id = s.service_id " +
                    "JOIN Staff st ON b.staff_id = st.staff_id " +
                    "JOIN Shifts sh ON b.shifts_id = sh.shifts_id " +
                    "WHERE b.status = ? ORDER BY b.booking_date DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking booking = mapResultSetToBooking(rs);
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Method moi: kiem tra stylist co available trong khung gio va ngay cu the khong
    public boolean isStylistAvailable(int staffId, int shiftId, Date bookingDate) {
        String sql = "SELECT COUNT(*) FROM Bookings WHERE staff_id = ? AND shifts_id = ? AND booking_date = ? AND status != 'Canceled'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, shiftId);
            ps.setDate(3, bookingDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0; // Tra ve true neu khong co booking nao (available)
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method moi: lay danh sach stylist available cho mot khung gio va ngay cu the
    public List<Staff> getAvailableStylists(int shiftId, Date bookingDate, int serviceId) {
        List<Staff> availableStylists = new ArrayList<>();
        String sql = "SELECT st.* FROM Staff st " +
                    "WHERE st.staff_status = TRUE " +
                    "AND NOT EXISTS (" +
                    "    SELECT 1 FROM Bookings b " +
                    "    WHERE b.staff_id = st.staff_id " +
                    "    AND b.shifts_id = ? " +
                    "    AND b.booking_date = ? " +
                    "    AND b.status != 'Canceled'" +
                    ")";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shiftId);
            ps.setDate(2, bookingDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Staff staff = new Staff();
                    staff.setStaffId(rs.getInt("staff_id"));
                    staff.setStaffName(rs.getString("staff_name"));
                    availableStylists.add(staff);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableStylists;
    }
} 