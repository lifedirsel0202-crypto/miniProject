<%@page import="java.util.ArrayList"%>
<%@page import="dao.SnackRepository"%>
<%@page import="dto.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cart</title>
<script src = "selfSnack/cart.js"></script>
</head>
<body>
<%@include file="header.jsp" %>
<button>선택삭제</button>
<button>전체삭제</button>
<h3>장바구니 목록</h3>
<table class="cart-table">
<thead>
<tr>
<th colspan="2">상품명</th>
<th>가격</th>
<th>수량</th>
</tr>
</thead>
<tbody>
	<% 
		SnackRepository sr = new SnackRepository();
		ArrayList<Snack> cartList = sr.getCartList();
		if(cartList == null || cartList.isEmpty()){%>
		<tr>
		<td colspan="4">장바구니가 비었습니다.</td>
		</tr>
	<%
	} else{
		for(Snack s :cartList){	
	%>
	<tr>
	<td><input type="checkbox"></td>
	<td><img src ="selfSnack/images/<%=s.getImage()%>"></td>
	<td><b><%= s.getProductName() %></b></td>
	<td><%=s.getQuantity() %>개</td>
	<td><button type="submit" class="addOder" formaction="sales_order.jsp">구매하기</button></td>
	<td><button>수량변경</button></td>
	</tr>
	<%}
		}%>
</tbody>

</table>
<button>전체상품 구매하기</button>
<button>선택상품 구매하기</button>


<script src="cart.js"></script>
</body>
</html>