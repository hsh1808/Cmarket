<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%> 
<%
	Connection conn = null;	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "c##Cmarket";
		String password = "c##Cmarket1234";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, password);
		System.out.println("데이터베이스 연결이 성공되었습니다.");
		
	} catch (SQLException ex) {
		out.println("데이터베이스 연결이 실패되었습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	}
		
%>