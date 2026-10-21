<%@page import="java.util.ArrayList"%>
<%@page import="dao.SnackRepository"%>
<%@page import="dto.Snack"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	SnackRepository repo = new SnackRepository();
	ArrayList<Snack> bestList = repo.getBestProducts();
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Self-Snack_Market</title>
<link href = "style.css" rel="stylesheet">
</head>
<body>
<%@include file="header.jsp" %>
<main>
<div class= "main-container">
<section class="best-section"><!-- best3이라는 하나의 구역이라는 의미를 전달하기위해 -->
<h2 class="topTitle">Best TOP3</h2>
<div class="B-product-List">
	<% 
		if(bestList !=null && !bestList.isEmpty()){
			for(Snack s:bestList){
	%>
	<div class ="product-card">
		<a href="productList.jsp?serial=<%=s.getSerial()%>" class="product-link">
			<img src="selfSnack/images/<%=s.getImage()%>" alt="<%=s.getProductName()%>">
			<div class="PB-Name"><%=s.getProductName()%></div>
			<div class="PB-Pirce"><%=String.format("%,d", s.getPrice())%>원</div>
								<!-- 상품 가격 숫자를 3자리마다 보기좋게 (,) 찍어주는 자바코드 -->
		</a>
<!--  장바구니 버튼 추가 -->
<div class="cart-btn-action">
	<!-- form을 완전히 제거하고, 버튼 클릭 시 자바스크립트 함수를 직접 호출! -->
	<button type="button" class="addBtn" title="장바구니 쏙!" onclick="insertCart('<%=s.getSerial()%>', event)">
		<img src="selfSnack/images/shopping-cart.png" alt="장바구니 쏙!">
	</button>
</div>
	</div>
	
	<%}
			}else {%>
		<p>등록된 상품이 없습니다.</p>
	
	<%
	}
	%>
	</div>
</section>
</div>
</main>
<script src="cart.js"></script>
</body>
</html>