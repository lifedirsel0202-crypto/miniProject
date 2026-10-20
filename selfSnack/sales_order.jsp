<%@page import="dao.SnackRepository"%>
<%@page import="dto.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	// 전달받은 파라미터(상품시리얼 번호와 수량) 추출
	String serial = request.getParameter("serial");
	String qtyStr = request.getParameter("quantity");
	int quantity = (qtyStr != null && !qtyStr.isEmpty()) ? Integer.parseInt(qtyStr) : 1 ;
	SnackRepository sr = new SnackRepository();
	Snack snack = sr.getProductBySerial(serial);
	
	int totalPrice = (snack !=null) ? snack.getPrice() * quantity : 0;

	if(serial != null && !serial.isEmpty()){
		sr.insertOrder(serial, quantity, totalPrice);
	}
	// db에서 해당 상품 조화
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제내역</title>
</head>
<body>
<%@include file="header.jsp" %>
<div class = "container">
<h2>주문 내역</h2>
<div class = "order-box"></div>
<% if(snack != null){ %>
<table class="order-box" >
<thead>
<tr>
	<th></th>
	<th>상품번호</th>
	<th>상품명</th>
	<th>가 격</th>
	<th>구매수량</th>
	<th>총결제금액</th>
</tr>
</thead>
<tbody>
<tr>
	<td><img src="selfSnack/images/<%=snack.getImage()%>" alt="<%=snack.getProductName()%>"></td>
	<td><%=snack.getSerial() %></td>
	<td><%=snack.getProductName() %></td>
	<td><%=String.format("%,d", snack.getPrice())%>원</td>
	<td><%=quantity%>개</td>
	<td><strong><%=String.format("%,d", totalPrice)%>원</strong></td>
</tr>
<% } else {%>
<tr>
<td colspan="6"> 주문내역이 존재 하지 않거나 상품 정보를 찾을 수 없습니다.</td>
</tr>
<% } %>
</tbody>
</table>
</div>
</body>
</html>