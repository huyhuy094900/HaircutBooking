package DAO;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            DBContext db = new DBContext(); // tạo đối tượng
            Connection conn = db.getConnection(); // gọi phương thức

            if (conn != null) {
                System.out.println("✅ Kết nối MySQL thành công từ DBContext!");
            } else {
                System.out.println("❌ Kết nối thất bại.");
            }

        } catch (Exception e) {
            System.out.println("❌ Lỗi khi kết nối: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
