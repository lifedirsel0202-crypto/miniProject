<%@page import="java.util.ArrayList"%>
<%@page import="dao.SnackRepository"%>
<%@page import="dto.Snack"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String serial = request.getParameter("serial");
	
	SnackRepository repo = new SnackRepository();
	Snack snack = repo.getProductBySerial(serial);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보</title>
<link href="style.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="detail-container">
		<h2 class="detail-title"> 제품 상세정보</h2>
	<div class="dTop-box">
	<%
		if(snack != null){%>
			<img src="selfSnack/images/<%=snack.getImage()%>" alt="<%=snack.getProductName()%>">
			<div class="detail-info">
				<h2><%=snack.getProductName()%></h2>
				<span>가격 : <%=snack.getPrice() %></span>
			
		<form action="" method="post">
	<div class= "Dquantity-box">
  		 <input type="hidden" name="serial" value="<%= snack.getSerial() %>"> <!-- 어떤상품인지 알려주기위한 hidden input -->
    <!-- 수량 조절 및 입력 박스 (id와 name을 모두 quantity로 유지) -->
      		  <button type="button" id="minusBtn">-</button>
      	  <input type="number" id="quantity" name="quantity" value="1" min="1">
       		 <button type="button" id="plusBtn">+</button>
    </div>
    <!-- type="submit"으로 바꾸면 버튼을 누를 때 자동으로 서버로 전송됩니다 -->
    	<button type="submit" class="addCart" formaction="cartAddDetail.jsp">장바구니 담기</button>
    	<button type="submit" class="addOder" formaction="sales_order.jsp">구매하기</button>
		</form>
		</div>	
		</div>
			<table class="info-table">
			<tr>
			<th class = "info-th">제품명</th>
			<td class = "info-td"><%=snack.getProductName() %></td>
			</tr>
			<tr>
			<th class = "info-th">식품 유형</th>
			<td class = "info-td"><%=snack.getFood_type() %></td>
			</tr>
			<tr>
			<th class = "info-th">원재료명</th>
			<td class = "info-td"><%=snack.getIngredient() %></td>
			</tr>
			<tr>
			<th class = "info-th">소비기한</th>
			<td class = "info-td">후면표기일까지</td>
			</tr>
			<tr>
			<th class = "info-th">포장재질</th>
			<td class = "info-td">폴리스포필렌</td>
			</tr>
			</table>

		<%
		}
		%>
</div>
<script src="cart.js"></script>
</body>
</html>