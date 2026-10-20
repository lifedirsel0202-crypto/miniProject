<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.SnackRepository"%>
<%
	String serial = request.getParameter("serial");
	
	SnackRepository sr= new SnackRepository();
	if (serial != null && !serial.trim().isEmpty()){
		sr.insertCart(serial);
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 담기</title>
<script>
	window.onload = function(){
		let result= confirm("장바구니에 상품이 담겼습니다.\n장바구니로 이동하시겠습니까?");
		if(result){
			location.href = "cart.jsp";
		}else{
			history.back();
		}
	};
</script>
</head>
<body>
</body>
</html>
