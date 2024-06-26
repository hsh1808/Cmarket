<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>

<%
    request.setCharacterEncoding("UTF-8");

    String cartId = session.getId();

    String shipping_cartId = "";
    String shipping_name = "";
    String shipping_phone = "";
    String shipping_addressName = "";

    // 새로운 주소 입력 여부 확인
    boolean isNewAddress = false;
    String deliveryOption = request.getParameter("deliveryOption");
    if (deliveryOption != null && deliveryOption.equals("new")) {
        isNewAddress = true;
    }

    // member 테이블 또는 delivery 테이블에서 정보를 불러오기
    String memberId = (String) session.getAttribute("sessionId");
    try {
        String selectQuery;
        if (isNewAddress) {
            // delivery 테이블에서 정보 가져오기
            selectQuery = "SELECT * FROM DELIVERY WHERE d_ID=?";
        } else {
            // member 테이블에서 정보 가져오기
            selectQuery = "SELECT * FROM MEMBER WHERE ID=?";
        }

        try (Connection conn = ((DataSource) pageContext.findAttribute("dataSource")).getConnection();
             PreparedStatement pstmt = conn.prepareStatement(selectQuery)) {
            pstmt.setString(1, isNewAddress ? cartId : memberId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    shipping_name = rs.getString("name");
                    shipping_phone = rs.getString("phone");
                    shipping_addressName = rs.getString("address");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            Cookie thisCookie = cookies[i];
            String n = thisCookie.getName();
            if (n.equals("Shipping_cartId"))
                shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
        }
    }
%>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>주문 정보</title>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">주문 정보</h1>
        </div>
    </div>

    <div class="container col-8 alert alert-info">
        <div class="text-center ">
            <h1>영수증</h1>
        </div>
        <div class="row justify-content-between">
            <div class="col-4" align="left">
                <strong>배송 주소</strong> <br> 성명 : <%=shipping_name%><br> 
                전화번호 : <%=shipping_phone%><br>
                주소 : <%=shipping_addressName%>
            </div>
        </div>
        <div>
            <table class="table table-hover">           
            <tr>
                <th class="text-center">상품</th>
                <th class="text-center">수량</th>
                <th class="text-center">가격</th>
                <th class="text-center">소계</th>
            </tr>
            <%
                int sum = 0;
                ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
                if (cartList == null)
                    cartList = new ArrayList<Product>();
                for (int i = 0; i < cartList.size(); i++) { // 상품리스트 하나씩 출력하기
                    Product product = cartList.get(i);
                    int total = product.getUnitPrice() * product.getQuantity();
                    sum = sum + total;
            %>
            <tr>
                <td class="text-center"><em><%=product.getPname()%> </em></td>
                <td class="text-center"><%=product.getQuantity()%></td>
                <td class="text-center"><%=product.getUnitPrice()%>원</td>
                <td class="text-center"><%=total%>원</td>
            </tr>
            <%
                }
            %>
            <tr>
                <td> </td>
                <td> </td>
                <td class="text-right"> <strong>총액: </strong></td>
                <td class="text-center text-danger"><strong><%=sum%> </strong></td>
            </tr>
            </table>
            
            <a href="./ShippingInfo.jsp?cartId=<%=shipping_cartId%>" class="btn btn-secondary" role="button"> 이전 </a>
            <a href="./thankCustomer.jsp"  class="btn btn-success" role="button"> 주문 완료 </a>
            <a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>            
        </div>
    </div>    
</body>
</html>
