<%@page import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>

<%@ include file="dbconn.jsp" %>

<%

	String memberId = (String) session.getAttribute("sessionId");

	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("newDeliveryName");
	String phone = request.getParameter("newDeliveryPhone");
	String address = request.getParameter("newDeliveryAddress");
    try {
        // MEMBER 테이블에서 ID를 가져오기
        

        // 가져온 ID를 INSERT 문에 사용
        String insertQuery = "INSERT INTO Delivery (d_id, u_id, d_name, d_phone, d_address) VALUES (DELIVERY_SEQ.NEXTVAL, ?, ?, ?, ?)";

		pstmt = conn.prepareStatement(insertQuery);
		
		pstmt.setString(1, memberId);
		pstmt.setString(2, name);
		pstmt.setString(3, phone);
		pstmt.setString(4, address);
		
		int success = pstmt.executeUpdate();
		if(success == 0)
			System.out.println("입력을 실패했어요~!");


    } catch (Exception e) {
        // 예외 처리
        e.printStackTrace();
    }
%>

<script>
    // 페이지 이동 함수
    function moveToPlaceOrder() {
        // placeOrder.jsp로 이동
        location.href = './placeOrder.jsp';
    }

    // moveToPlaceOrder 함수를 호출하는 부분
    moveToPlaceOrder();
</script>
