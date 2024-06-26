<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>

<%@ include file="dbconn.jsp"%>

<%
    try {
        String id = request.getParameter("id");
        if (id == null || id.trim().equals("")) {
            response.sendRedirect("products.jsp");
            return;
        }

        // 이미 dbconn.jsp에서 선언된 Connection 객체를 사용
        // PreparedStatement pstmt = null; // 주석 처리 또는 삭제
        // ResultSet rs = null; // 주석 처리 또는 삭제

        try {
            String sql = "SELECT * FROM product WHERE p_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            Product product = null;

            if (rs.next()) {
                product = new Product();
                product.setUnitPrice(Integer.parseInt(rs.getString("p_unitprice")));
                product.setName(rs.getString("p_name"));
                product.setProductId(rs.getString("p_id"));
                // 나머지 필요한 정보를 설정해줄 수 있습니다.
            }

            ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
            if (cartList != null) {
                for (int i = 0; i < cartList.size(); i++) {
                    Product goodsQnt = cartList.get(i);
                    if (goodsQnt.getProductId().equals(id)) {
                        cartList.remove(goodsQnt);
                        break;
                    }
                }
            }

            response.sendRedirect("cart.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
