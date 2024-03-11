<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	System.out.println("sessionId: " + sessionId); // 콘솔에 출력
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light bg-white">
    <div class="container-fluid">
        <a class="navbar-brand" href="<c:url value="/home.jsp"/>"
           style="font-size: 30px; margin-right: 120px; margin-top: 5px">WebMarket</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
                data-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active"><a class="nav-link"
                                              href="<c:url value="/productSet.jsp"/>"
                                               style="margin-right: 40px; font-weight: bold;">세트상품</a></li>
                <li class="nav-item active"><a class="nav-link"
                                                href="<c:url value="/productSpecial.jsp"/>"
                                               style="margin-right: 40px; font-weight: bold;">특가상품</a></li>
                <li class="nav-item active"><a class="nav-link"
                                                href="<c:url value="/productSnack.jsp"/>"
                                               style="margin-right: 40px; font-weight: bold;">과자,스낵</a></li>
                <li class="nav-item active"><a class="nav-link"
                                                href="<c:url value="/productChocolate.jsp"/>"
                                               style="margin-right: 40px; font-weight: bold;">초콜릿,껌</a></li>
                <li class="nav-item active"><a class="nav-link"
                                                href="<c:url value="/productRamen.jsp"/>"
                                               style="margin-right: 40px; font-weight: bold;">라면</a></li>
                <li class="nav-item active"><a class="nav-link"
                                                href="<c:url value="/productDrink.jsp"/>"
                                               style="margin-right: 120px; font-weight: bold;">음료</a></li>
            </ul>
			<form class="d-flex" style="margin-right: 5px;">
				<input class="form-control me-sm-2" type="search"
					placeholder="Search">
				<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
			</form>

			<ul class="navbar-nav ml-auto">
				<c:choose>
					<c:when test="${empty sessionScope.sessionId}">
						<li class="nav-item active"><a class="nav-link"
							href="./member/loginMember.jsp" style="margin-right: 5px;">로그인</a></li>
						<li class="nav-item active"><a class="nav-link"
							href="./member/addMember.jsp" style="margin-right: 5px;">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<c:if test="${sessionScope.sessionId eq 'admin'}">
							<!-- 'admin'인 경우에만 상품 등록 메뉴를 보여줌 -->
							<li class="nav-item active"><a class="nav-link"
								href="./addProduct.jsp" style="margin-right: 5px;">상품 등록</a></li>
							<li class="nav-item active"><a class="nav-link"
								href="./editProduct.jsp?edit=update" style="margin-right: 5px;">상품 수정</a></li>
							<li class="nav-item active"><a class="nav-link" 
								href="./editProduct.jsp?edit=delete" style="margin-right: 5px;">상품 삭제</a></li>
						</c:if>
						
						<li style="padding-top: 7px; color: white">[${sessionScope.sessionId}님]</li>
						<li class="nav-item active"><a class="nav-link"
							href="/Cmarket/member/logoutMember.jsp"
							style="margin-right: 5px;">로그아웃</a></li>
							
						<!-- 'admin'이 아닌 경우에만 회원 수정과 장바구니 메뉴를 보여줌 -->
						<c:if test="${sessionScope.sessionId ne 'admin'}">
							<li class="nav-item active"><a class="nav-link"
								href="/Cmarket/member/updateMember.jsp"
								style="margin-right: 5px;">회원 수정</a></li>
							<li class="nav-item active"><a class="nav-link"
								href="<c:url value='/cart.jsp'/>"
								style="margin-right: 5px;">장바구니</a></li>
							<li class="nav-item active"><a class="nav-link"
								href="<c:url value='/orderConfirmation.jsp'/>"
								style="margin-right: 5px;">주문확인</a></li>
						</c:if>
					</c:otherwise>
				</c:choose>

				<li class="nav-item active"><a class="nav-link"
                                            href="<c:url value='/BoardListAction.do?pageNum=1'/>">고객센터</a></li>
            </ul>
        </div>
    </div>
</nav>
