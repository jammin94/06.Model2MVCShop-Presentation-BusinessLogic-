<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script>
function fncGetProductList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();	
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listUser.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<%-- <td width="93%" class="ct_ttl01"><%=role.equals("admin")?"배송처리":"구매목록" %> </td> --%>
					<td width="93%" class="ct_ttl01">${user.role eq 'admin' ? '배송처리' : '구매목록'} </td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체  ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="100">상품명</td>
		<td class="ct_line02"></td>
		<c:if test="${user.role eq 'admin'}">
			<td class="ct_list_b" width="150">회원ID</td>
			<td class="ct_line02"></td>
		</c:if>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>

	<c:forEach var="i" items= "${list}" varStatus="status" >

	
		<tr class="ct_list_pop">
			<td align="center">
				${status.count }
			</td>
			<td></td>
			<td><a href="/getPurchase.do?tranNo=${i.tranNo }">${i.purchaseProd.prodName }</a></td>
			<c:if test="${user.role eq 'admin'}">
			<td></td>
				<td align="left">
				<a href="/getUser.do?userId=${i.buyer.userId }">${i.buyer.userId }</a>
				</td>
			</c:if>
			<td></td>
			<td align="left">${i.receiverName }</td>
			<td></td>
			<td align="left">${i.receiverPhone }</td>
			<td></td>
			<%--
				<% if(purchase.getTranCode().trim().equals("0")) {  %>
					<td align="left">현재 구매가능합니다.</td>
				<% }else if(purchase.getTranCode().trim().equals("1")){ %>
					<td align="left">현재 구매완료했습니다.</td>
				<% }else if(purchase.getTranCode().trim().equals("2")){ %>
					<td align="left">현재 배송중입니다.</td>
				<% }else { %>
					<td align="left">배송완료 했습니다.</td>
				<% } %>
			 --%>
			 
			 <c:choose>
			 	<c:when test="${i.tranCode.trim() eq '0' }">
			 		<td align="left">현재 구매가능합니다.</td>
			 	</c:when>
			 	<c:when test="${i.tranCode.trim() eq '1' }">
			 		<td align="left">현재 구매완료했습니다.</td>
			 	</c:when>
			 	<c:when test="${i.tranCode.trim() eq '2' }">
			 		<td align="left">현재 배송중입니다.</td>
			 	</c:when>
			 	<c:otherwise>
			 		<td align="left">배송완료 했습니다.</td>
			 	</c:otherwise>
			 </c:choose>
			<td>
				
			</td>
			<td align="left">
			<%--
				<% if(purchase.getTranCode().trim().equals("1")&&role.equals("user")) {  %>
					<a href="/updatePurchaseView.do?tranNo=<%=purchase.getTranNo() %>">구매 수정하기</a>
				<% } %>
			
				<% if(purchase.getTranCode().trim().equals("2")&&role.equals("user")) {  %>
					<a href="/updateTranCode.do?tranNo=<%=purchase.getTranNo() %>&tranCode=3">도착완료 확인하기</a>
				<% } %>
				
				<% if(purchase.getTranCode().trim().equals("1")&&role.equals("admin")) {  %>
					<a href="/updateTranCode.do?tranNo=<%=purchase.getTranNo() %>&tranCode=2">배송하기</a>
				<% } %>
			 --%>
			 
			 	<c:if test="${ i.tranCode.trim() eq '1' && user.role eq 'user'}">
			 		<a href="/updatePurchaseView.do?tranNo=${i.tranNo }">구매 수정하기</a>
			 	</c:if>
			 	<c:if test="${ i.tranCode.trim() eq '2' && user.role eq 'user'}">
			 		<a href="/updateTranCode.do?tranNo=${i.tranNo }&tranCode=3">도착완료 확인하기</a>
			 	</c:if>
			 	<c:if test="${ i.tranCode.trim() eq '1' && user.role eq 'admin'}">
			 		<a href="/updateTranCode.do?tranNo=${i.tranNo }&tranCode=2">배송하기</a>
			 	</c:if>
			</td>
	</c:forEach>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">

		<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<c:if test="${resultPage.currentPage>resultPage.pageUnit }">
				<a href="/listPurchase.do?page=${resultPage.endUnitPage()-1}">이전</a>
			</c:if>
			
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage }" varStatus="status" >
				<a href="/listPurchase.do?page=${status.count }">${status.count }</a>
			</c:forEach>
			
			<c:if test="${resultPage.endUnitPage<resultPage.maxPage }">
				<a href="/listPurchase.do?page=${resultPage.endUnitPage()+1}">다음</a>
			</c:if>
			
		</td>
	</tr>
</table>


</form>

</div>

</body>
</html>