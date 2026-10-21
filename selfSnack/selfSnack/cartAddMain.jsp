<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.SnackRepository" %>
<%
    request.setCharacterEncoding("UTF-8");

    
    String serial = request.getParameter("serial");
    String quantityStr = request.getParameter("quantity");
    
    int quantityValue = 1;
    if (quantityStr != null && !quantityStr.trim().isEmpty()){
        quantityValue = Integer.parseInt(quantityStr);
    }
    
    SnackRepository sr = new SnackRepository();
    int finalCount = 0;
    
    if (serial != null && !serial.trim().isEmpty()){
        // DB에 담고, 최종 수량(currentQuantity)을 받아와서..
        finalCount = sr.addCart(serial, quantityValue);
    }
    
    //자바스크립트 fetch가 읽을 수 있도록 숫자 출력
    out.print(finalCount);
%>