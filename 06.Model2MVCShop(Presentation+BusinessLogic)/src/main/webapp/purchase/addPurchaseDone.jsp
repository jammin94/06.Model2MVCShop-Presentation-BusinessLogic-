<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="com.model2.mvc.service.domain.*" %>
    
    
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=0" method="post">

다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td><%= request.getParameter("prodNo") %></td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td><%= request.getParameter("buyerId") %></td>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>	
			<%=request.getParameter("paymentOption")%></td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td><%=request.getParameter("receiverName")%></td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td><%=request.getParameter("receiverPhone")%></td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td><%=request.getParameter("receiverAddr")%></td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td><%=request.getParameter("receiverRequest")%></td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td><%=request.getParameter("receiverDate")%></td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>