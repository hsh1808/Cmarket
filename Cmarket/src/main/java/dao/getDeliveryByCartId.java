package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Delivery;

public class getDeliveryByCartId {

    private static getDeliveryByCartId instance = new getDeliveryByCartId();

    private getDeliveryByCartId() {
    }

    public static getDeliveryByCartId getInstance() {
        return instance;
    }

    public Delivery getDeliveryByCartId(String cartId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Delivery delivery = null;

        try {
            // 데이터베이스 연결 코드
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String user = "c##Cmarket";
            String password = "c##Cmarket1234";

            // JDBC 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // 데이터베이스 연결
            conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT * FROM Delivery WHERE d_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cartId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                delivery = new Delivery();
                delivery.setD_id(rs.getString("d_id"));
                delivery.setD_name(rs.getString("d_name"));
                delivery.setD_phone(rs.getString("d_phone"));
                delivery.setD_address(rs.getString("d_address"));
                // 필요한 다른 정보를 설정하세요
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // 리소스 해제 코드
            closeResources(conn, pstmt, rs);
        }

        return delivery;
    }
    // 추가적인 배송 정보 관련 기능을 작성할 수 있습니다.

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
