<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>

<%-- 데이터 소스 설정 --%>
<sql:setDataSource var="dataSource"
    url="jdbc:oracle:thin:@localhost:1521:xe"
    driver="oracle.jdbc.driver.OracleDriver" 
    user="c##Cmarket" password="c##Cmarket1234" />

<%-- 나머지 코드 --%>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>배송 주소 선택</title>
</head>
<body>
    <!-- 메뉴를 포함한 페이지 상단 부분 -->
    <jsp:include page="menu.jsp" />

    <!-- 페이지 헤더 부분 -->
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">배송 주소 선택</h1>
        </div>
    </div>

    <!-- 주문 정보 입력 폼 -->
    <div class="container col-8 alert alert-info">
        <form action="./processDeliver.jsp" method="post">
            <!-- 기존 배송 주소 선택 -->
            <div class="form-group">
                <label for="deliverySelect">기존 배송 주소 선택</label>
                <select class="form-control" id="deliverySelect" name="selectedDelivery">
                    <option value="">-- 기존 주소를 선택하세요 --</option>
                    
                    <!-- SQL 쿼리를 실행하여 회원의 배송 주소를 가져오기 -->
                    <sql:query dataSource="${dataSource}" var="resultSet">
                        SELECT * FROM MEMBER WHERE ID=?
                        <sql:param value="${sessionId}" />
                    </sql:query>

                    <!-- 가져온 주소를 옵션으로 추가 -->
                    <c:forEach var="row" items="${resultSet.rows}">
                        <c:if test="${not empty row.address}">
                            <option value="${row.address}">
                                ${row.name} - ${row.address}
                            </option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>

            <!-- 새로운 배송 주소 입력 -->
            <div class="form-group">
                <label for="newDeliveryName">새로운 배송 주소 입력</label>
                <input type="text" class="form-control" id="newDeliveryName" name="newDeliveryName" placeholder="성명" required>
            </div>
            <div class="form-group">
                <label for="newDeliveryPhone">전화번호</label>
                <input type="text" class="form-control" id="newDeliveryPhone" name="newDeliveryPhone" placeholder="전화번호" required>
            </div>
            <div class="form-group">
                <label for="newDeliveryAddress">주소</label>
                <input type="text" class="form-control" id="newDeliveryAddress" name="newDeliveryAddress" placeholder="주소" required>
            </div>

            <!-- 주문 완료 버튼 -->
            <button type="submit" class="btn btn-primary">주문 완료</button>
        </form>   
    </div> 

</body>
</html>
