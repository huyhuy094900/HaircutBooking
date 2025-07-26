package DAO;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            DBContext db = new DBContext(); // tạo đối tượng
            Connection conn = db.getConnection(); // goi phuong thuc

            if (conn != null) {
                System.out.println("✅ Kết nối MySQL thành công từ DBContext!");
            } else {
                System.out.println("Ket noi that bai.");
            }

        } catch (Exception e) {
            System.out.println("Loi khi ket noi: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
