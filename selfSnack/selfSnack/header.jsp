<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link href = "style.css" rel="stylesheet">
</head>
<body>
<header>
<h1 class= "head-logo"> 
<a href="main.jsp">
<img src="${pageContext.request.contextPath}/selfSnack/images/the.png" alt="로고">
Delicious Snacks Market</a></h1>
<nav class= "nav-a">
<a href = "main.jsp">HOME</a>
<a href = "productList.jsp">ProductList</a>
<a href = "cart.jsp">Cart</a>
</nav>
</header>
</body>
</html>