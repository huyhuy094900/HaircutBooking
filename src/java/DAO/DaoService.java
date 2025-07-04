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
}