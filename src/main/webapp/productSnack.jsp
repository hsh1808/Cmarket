<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>상품 목록</title>
</head>
<body>
    <%@ include file="menu.jsp" %>
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">과자, 스낵</h1>
        </div>
    </div>
    <div class="container">
        <div class="row" align="center">
            <%@ include file="dbconn.jsp"%>
            <%
            try {
            	String sql = "select * from product where p_category = '과자스낵'";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                while (rs.next()) {
            %>
            <div class="col-md-3">
                <img src="./upload2/<%=rs.getString("p_fileName")%>" style="width: 100%">
                <h3><%=rs.getString("p_name")%></h3>
                <p><%=rs.getString("p_UnitPrice")%>원</p>
                <a href="./product.jsp?id=<%=rs.getString("p_id")%>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;></a>
            </div>
            <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // 자원 해제
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            }
            %>
        </div>
        <hr>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
