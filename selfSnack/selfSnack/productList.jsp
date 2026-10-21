<%@page import="java.util.ArrayList"%>
<%@page import="dao.SnackRepository"%>
<%@page import="dto.Snack"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SnackRepository repo = new SnackRepository();
	ArrayList<Snack> productList = repo.getAllProducts();
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product List</title>
</head>
<body>
<%@include file="header.jsp" %>
<main>
	<div class="list-container">
		<h2 class="topTitle">판매상품 List</h2>
		<div class="P-ListBox">
		<%
			if(productList != null && !productList.isEmpty()){
				for(Snack s : productList){
				%>
		<div class="PL-card">
			<a href="productDetail.jsp?serial=<%=s.getSerial()%>" class="product-link">
				<img src="selfSnack/images/<%=s.getImage()%>" alt="<%=s.getProductName() %>">
				<div class="PL-Name"><%=s.getProductName() %></div>
				<div class="PL-Price"><%=String.format("%,d", s.getPrice())%>원</div>
			</a>
		</div>
		<%
			}
		}else{
		%>
		<p>등록된 상품이 없습니다.</p>
		<%
		}
		%>
		</div>
	</div>
</main>
</body>
</html>