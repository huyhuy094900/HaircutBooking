import DAO.DaoService;
import DAO.StaffDAO;
import Model.Service;
import Model.Staff;
import java.util.List;

public class TestDatabaseData {
    public static void main(String[] args) {
        System.out.println("=== Testing Database Connection and Data ===");
        
        try {
            // Test Services
            System.out.println("\n--- Testing Services ---");
            DaoService serviceDAO = new DaoService();
            List<Service> services = serviceDAO.getAllActiveServices();
            
            if (services != null && !services.isEmpty()) {
                System.out.println("Found " + services.size() + " services:");
                for (Service service : services) {
                    System.out.println("  - " + service.getName() + " ($" + service.getPrice() + ")");
                }
            } else {
                System.out.println("No services found in database");
            }
            
            // Test Staff
            System.out.println("\n--- Testing Staff ---");
            StaffDAO staffDAO = new StaffDAO();
            List<Staff> staff = staffDAO.getActiveStaff();
            
            if (staff != null && !staff.isEmpty()) {
                System.out.println("Found " + staff.size() + " staff members:");
                for (Staff staffMember : staff) {
                    System.out.println("  - " + staffMember.getStaffName() + " (" + staffMember.getStaffEmail() + ")");
                }
            } else {
                System.out.println("No staff found in database");
            }
            
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("\n=== Test Complete ===");
    }
} 