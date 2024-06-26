package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Delivery;

public class DeliveryRepository {

    private static DeliveryRepository instance = new DeliveryRepository();

    private DeliveryRepository() {
    }

    public static DeliveryRepository getInstance() {
        return instance;
    }

    // 데이터베이스 연결 메서드
    private Connection getConnection() throws SQLException {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String user = "c##Cmarket";
        String password = "c##Cmarket1234";

        return DriverManager.getConnection(url, user, password);
    }

    // 회원의 배송 주소 목록 가져오기
    public ArrayList<Delivery> getDeliveryListByMemberId(String memberId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Delivery> deliveryList = new ArrayList<>();

        try {
            // 데이터베이스 연결 코드
            conn = getConnection();

            String sql = "SELECT * FROM Delivery WHERE member_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Delivery delivery = new Delivery();
                delivery.setD_id(rs.getString("d_id"));
                delivery.setD_name(rs.getString("d_name"));
                delivery.setD_phone(rs.getString("d_phone"));
                delivery.setD_address(rs.getString("d_address"));
                // U_ID 추가
                delivery.setU_id(rs.getString("u_id"));
                // 필요한 다른 정보를 설정하세요

                deliveryList.add(delivery);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return deliveryList;
    }

    // 다른 메서드들 생략...

    // 리소스 해제 메서드
    private void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
