<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        #content {
            flex: 1;
        }

        #banner {
            max-width: 100%;
            height: auto; 
            margin-top: 13px;
        }

        #hotDeal {
            text-align: center; 
            font-size: 24px;
            font-weight: bold;
            margin-top: 50px;
            margin-right: 78%;
        }

        #hotDealImage {
            max-width: 100%;
            height: auto; 
            margin-top: 40px;
            margin-left: 8%;
            margin-bottom: 50px; 
        }
    </style>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <div id="content">
        <%@ include file="menu.jsp" %>
        
        <!-- 배너 사진 추가 -->
        <img id="banner" src="./resources/images/bn.png" alt="Banner Image">

        <!-- 핫딜 카테고리 내용 추가 -->
        <div id="hotDeal">인기상품</div>

        <!-- 핫딜 밑에 이미지 추가 -->
        <img id="hotDealImage" src="./resources/images/hotdeal1.jpg" alt="Hot Deal Image">
        <img id="hotDealImage" src="./resources/images/hotdeal2.jpg" alt="Hot Deal Image">
        <img id="hotDealImage" src="./resources/images/hotdeal1.jpg" alt="Hot Deal Image">
        <img id="hotDealImage" src="./resources/images/hotdeal2.jpg" alt="Hot Deal Image">
        
        <img id="hotDealImage" src="./resources/images/hotdeal1.jpg" alt="Hot Deal Image">
        <img id="hotDealImage" src="./resources/images/hotdeal2.jpg" alt="Hot Deal Image">
        <img id="hotDealImage" src="./resources/images/hotdeal1.jpg" alt="Hot Deal Image">
        <img id="hotDealImage" src="./resources/images/hotdeal2.jpg" alt="Hot Deal Image">
    </div>
    
    <footer>
        <%@ include file="footer.jsp" %>
    </footer>
</body>
</html>
