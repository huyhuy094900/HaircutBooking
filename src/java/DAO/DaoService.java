/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author sontu
 */
public class DaoService extends DBContext {

    public List<Service> getAllActiveServices() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Services WHERE service_status = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Service s = new Service();
                s.setServiceId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setDuration(rs.getInt("duration"));
                s.setPrice(rs.getBigDecimal("price"));
                s.setImage(rs.getString("image"));
                s.setServiceStatus(rs.getBoolean("service_status"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> get3Service() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Services WHERE service_status = 1 LIMIT 3";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Service s = new Service();
                s.setServiceId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setDuration(rs.getInt("duration"));
                s.setPrice(rs.getBigDecimal("price"));
                s.setImage(rs.getString("image"));
                s.setServiceStatus(rs.getBoolean("service_status"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> getAllService() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM Services";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Service s = new Service();
                s.setServiceId(rs.getInt("service_id"));
                s.setName(rs.getString("name"));
                s.setDescription(rs.getString("description"));
                s.setDuration(rs.getInt("duration"));
                s.setPrice(rs.getBigDecimal("price"));
                s.setImage(rs.getString("image"));
                s.setServiceStatus(rs.getBoolean("service_status"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Service getServiceById(int serviceId) {
        String sql = "SELECT * FROM Services WHERE service_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Service s = new Service();
                    s.setServiceId(rs.getInt("service_id"));
                    s.setName(rs.getString("name"));
                    s.setDescription(rs.getString("description"));
                    s.setDuration(rs.getInt("duration"));
                    s.setPrice(rs.getBigDecimal("price"));
                    s.setImage(rs.getString("image"));
                    s.setServiceStatus(rs.getBoolean("service_status"));
                    s.setCreatedAt(rs.getTimestamp("created_at"));
                    return s;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addService(Service service) {
        String sql = "INSERT INTO Services (name, description, duration, price, image, service_status, created_at) VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getName());
            ps.setString(2, service.getDescription());
            ps.setInt(3, service.getDuration());
            ps.setBigDecimal(4, service.getPrice());
            ps.setString(5, service.getImage()); // Nếu không có image, có thể để null
            ps.setBoolean(6, service.isServiceStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateService(Service service) {
        String sql = "UPDATE Services SET name=?, description=?, duration=?, price=?, image=?, service_status=? WHERE service_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, service.getName());
            ps.setString(2, service.getDescription());
            ps.setInt(3, service.getDuration());
            ps.setBigDecimal(4, service.getPrice());
            ps.setString(5, service.getImage());
            ps.setBoolean(6, service.isServiceStatus());
            ps.setInt(7, service.getServiceId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void setServiceStatus(int id, boolean status) {
        String sql = "UPDATE Services SET service_status=? WHERE service_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}