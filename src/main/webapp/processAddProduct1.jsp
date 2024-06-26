<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

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
	String condition = multi.getParameter("condition");

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

	String sql = "insert into product values(?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	pstmt.setString(2, name);
	pstmt.setInt(3, price);
	pstmt.setString(4, category);
	pstmt.setString(5, manufacturer);
	pstmt.setLong(6, stock);
	pstmt.setString(7, fileName);
	
	int success = pstmt.executeUpdate();
	if(success == 0)
		System.out.println("입력을 실패했어요~!");
	
	
	if (pstmt != null)
 		pstmt.close();
 	if (conn != null)
		conn.close();
	
 	if(category.equals("세트상품"))
 		response.sendRedirect("productSet.jsp");
	else if(category.equals("특가상품"))
 		response.sendRedirect("productSpecial.jsp");
	else if(category.equals("과자스낵"))
 		response.sendRedirect("productSnack.jsp");
	else if(category.equals("초콜릿껌"))
 		response.sendRedirect("productChocolate.jsp");
	else if(category.equals("라면"))
 		response.sendRedirect("productRamen.jsp");
	else if(category.equals("음료"))
 		response.sendRedirect("productDrink.jsp");
	else
		response.sendRedirect("addProduct.jsp");
%> 



