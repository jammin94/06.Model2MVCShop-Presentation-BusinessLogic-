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

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<td><%= request.getParameter("prodNo") %></td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td><%= request.getParameter("buyerId") %></td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>	
			<%=request.getParameter("paymentOption")%></td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td><%=request.getParameter("receiverName")%></td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td><%=request.getParameter("receiverPhone")%></td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td><%=request.getParameter("receiverAddr")%></td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td><%=request.getParameter("receiverRequest")%></td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td><%=request.getParameter("receiverDate")%></td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>