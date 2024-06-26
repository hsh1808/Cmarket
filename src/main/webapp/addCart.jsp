<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>

<%@ include file="dbconn.jsp"%>

<%
    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        response.sendRedirect("products.jsp");
        return;
    }

    try {
        String sql = "SELECT * FROM product WHERE p_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        ArrayList<Product> goodsList = new ArrayList<Product>(); // 밖에서 초기화

        if (rs.next()) {
            Product product = new Product();
            product.setUnitPrice(Integer.parseInt(rs.getString("p_unitprice")));
            product.setName(rs.getString("p_name"));
            product.setProductId(rs.getString("p_id"));

            goodsList.add(product); // 첫 번째 결과 추가

            String anotherSql = "SELECT * FROM product WHERE p_id = ?";
            pstmt = conn.prepareStatement(anotherSql);
            pstmt.setString(1, id);
            ResultSet ra = pstmt.executeQuery();

            while (ra.next()) {
                Product p1 = new Product();
                p1.setCategory(ra.getString("p_category"));
                p1.setManufacturer(ra.getString("p_manufacturer"));
                p1.setUnitsInStock(Long.parseLong(ra.getString("p_unitsinstock")));

                goodsList.add(p1); // 나머지 결과 추가
            }
        }

        Product goods = new Product();
        for (int i = 0; i < goodsList.size(); i++) {
            goods = goodsList.get(i);
            if (goods.getProductId().equals(id)) {
                break;
            }
        }

        ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
        if (cartList == null) {
            cartList = new ArrayList<Product>();
            session.setAttribute("cartlist", cartList);
        }

        int cnt = 0;
        Product goodsQnt = new Product();
        for (int i = 0; i < cartList.size(); i++) {
            goodsQnt = cartList.get(i);
            if (goodsQnt.getProductId().equals(id)) {
                cnt++;
                int orderQuantity = goodsQnt.getQuantity() + 1;
                goodsQnt.setQuantity(orderQuantity);
            }
        }

        if (cnt == 0) {
            goods.setQuantity(1);
            cartList.add(goods);
        }

        response.sendRedirect("product.jsp?id=" + id);
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
%>
