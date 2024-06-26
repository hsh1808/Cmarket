<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%
	String filename = "";
	//	String realFolder = "C:\\upload"; //웹 어플리케이션상의 절대 경로
	String realFolder = getServletContext().getRealPath("/") + "upload2";
	System.out.println(realFolder);
	
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 5 * 1024 * 1024; //최대 업로드될 파일의 크기5Mb

	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType,
			new DefaultFileRenamePolicy());
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");

	Integer price;

	if (unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);

	long stock;

	if (unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);

	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);	

	
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			if (fileName != null) {
				sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_fileName=? WHERE p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, manufacturer);
				pstmt.setString(4, category);
				pstmt.setLong(5, stock);
				pstmt.setString(6, fileName);
				pstmt.setString(7, productId);
				pstmt.executeUpdate();
			} else {
				sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, WHERE p_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setInt(2, price);
				pstmt.setString(3, manufacturer);
				pstmt.setString(4, category);
				pstmt.setLong(5, stock);
				pstmt.setString(6, productId);
				pstmt.executeUpdate();
			}
		}
	if (rs != null)
		rs.close();
 	if (pstmt != null)
 		pstmt.close();
 	if (conn != null)
		conn.close();

	response.sendRedirect("editProduct.jsp?edit=update");
%>


