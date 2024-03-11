<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>
<%
    String productId = request.getParameter("id");

    String sql = "select * from product where p_id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, productId);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        // 상품이 존재하는 경우에만 삭제 진행
        sql = "delete from product where p_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productId);
        pstmt.executeUpdate();
    } else {
        out.println("일치하는 상품이 없습니다");
    }

    // 자원 해제
    if (rs != null) {
        rs.close(); 
    }
    if (pstmt != null) {
        pstmt.close();
    }
    if (conn != null) {
        conn.close();
    }

    // 삭제 후 editProduct.jsp로 리다이렉트
    response.sendRedirect("editProduct.jsp?edit=delete");
%>
