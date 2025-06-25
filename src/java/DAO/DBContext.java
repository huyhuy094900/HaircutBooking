package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    private static final String URL = "jdbc:mysql://localhost:3306/HaircutBooking?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root"; // Thay bằng username MySQL của bạn
    private static final String PASSWORD = "123456"; // Thay bằng mật khẩu MySQL của bạn
    
    protected Connection connection;

    public DBContext() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("[SUCCESS] Database connection established successfully.");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "MySQL Driver not found", ex);
            System.out.println("[ERROR] MySQL Driver not found. Please check your MySQL installation.");
            connection = null;
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, "Database connection failed", ex);
            System.out.println("[ERROR] Database connection failed. Please check:");
            System.out.println("   - MySQL server is running");
            System.out.println("   - Database 'HaircutBooking' exists");
            System.out.println("   - Username and password are correct");
            System.out.println("   - Error: " + ex.getMessage());
            connection = null;
        }
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    public boolean isConnected() {
        return connection != null;
    }
    
    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        if (dbContext.isConnected()) {
            System.out.println("[SUCCESS] Database connection test successful!");
        } else {
            System.out.println("[ERROR] Database connection test failed!");
        }
    }
}
