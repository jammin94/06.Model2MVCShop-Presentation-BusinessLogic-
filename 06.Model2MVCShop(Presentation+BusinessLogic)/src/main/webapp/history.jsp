<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.model2.mvc.service.product.impl.ProductServiceImpl"%>
<%@page import="com.model2.mvc.service.product.ProductService"%>
<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>

<title>열어본 상품 보기</title>

</head>
<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>
<%
	ProductService productService = new ProductServiceImpl();
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	String history = null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("history")) {
				history = cookie.getValue();
			}
		}
		if (history != null) {
			String[] h = history.split("!");
			for (int i = 0; i < h.length; i++) {
				if (!h[i].equals("null")) {
					
%>
<a href="/getProduct.do?prodNo=<%=h[i]%>&menu=search"
	target="rightFrame"><%=productService.getProduct(Integer.parseInt(h[i])).getProdName()%></a>
<br>
<%
				}
			}
		}
	}
%>

</body>
</html>