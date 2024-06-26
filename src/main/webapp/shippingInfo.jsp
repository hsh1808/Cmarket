<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dto.Member"%>
<%@ page import="dao.MemberRepository"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="dto.Delivery"%>
<%@ page import="dao.DeliveryRepository"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 사용자가 선택한 장바구니의 ID
    String cartId = request.getParameter("cartId");

    // 회원 정보를 DB에서 가져오는 메서드
    String memberId = (String) session.getAttribute("memberId");
    MemberRepository memberRepository = MemberRepository.getInstance();
    Member member = memberRepository.getMemberById(memberId);

    // 배송 정보를 DB에서 가져오는 메서드
    DeliveryRepository deliveryRepository = DeliveryRepository.getInstance();
    Delivery delivery = deliveryRepository.getDeliveryByCartId(cartId);
%>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>주문 확인</title>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <div class="jumbotron">
        <div class="container">
            <h1 class="display-3">주문 확인</h1>
        </div>
    </div>

    <div class="container col-8 alert alert-info">
        <div class="text-center">
            <h1>주문 내역 확인</h1>
        </div>

        <div class="row justify-content-between">
            <div class="col-6" align="left">
                <strong>회원 정보</strong> <br>
                이름 : <%= member.getName() %> <br>
                주소 : <%= member.getAddress() %> <br>
                전화번호 : <%= member.getPhone() %> <br>
            </div>
        </div>

        <hr>

        <div class="row justify-content-between">
            <div class="col-6" align="left">
                <strong>배송 정보</strong> <br>
                성명 : <%= delivery.getD_name() %> <br>
                주소 : <%= delivery.getD_address() %> <br>
                전화번호 : <%= delivery.getD_phone() %> <br>
            </div>
        </div>

        <hr>

        <h3>주문 상세 내역</h3>
        <table class="table table-hover">
            <tr>
                <th>상품</th>
                <th>가격</th>
                <th>수량</th>
                <th>소계</th>
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
                <td><%= product.getName() %></td>
                <td><%= product.getUnitPrice() %></td>
                <td><%= product.getQuantity() %></td>
                <td><%= total %></td>
            </tr>
            <%
                }
            %>
            <tr>
                <td></td>
                <td></td>
                <td><strong>총액</strong></td>
                <td><%= sum %></td>
            </tr>
        </table>

        <hr>

        <table width="100%">
            <tr>
                <td align="right"><a href="./thankCustomer.jsp" class="btn btn-success">주문 완료</a></td>
                <td align="right"><a href="./checkOutCancelled.jsp" class="btn btn-secondary">취소</a></td>
            </tr>
        </table>
    </div>
</body>
</html>
