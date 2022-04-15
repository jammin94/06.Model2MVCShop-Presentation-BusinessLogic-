<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script>
function fncGetPurchaseList(currentPage){
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();	
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listPurchase.do" method="post">

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

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			
			 <c:choose>
		 		<c:when test="${search.searchCondition =='0' || search.searchCondition == null}">
		 			<option value="0" selected>상품번호</option>
		 			<option value="1">상품명</option>
		 			<option value="2">상품가격</option>
		 		</c:when>
		
		 		<c:when test="${search.searchCondition =='1'}">
		 			<option value="0">상품번호</option>
		 			<option value="1" selected>상품명</option>
		 			<option value="2">상품가격</option>
		 		</c:when>
		 		
		 		<c:when test="${search.searchCondition =='2'}">
		 			<option value="0">상품번호</option>
		 			<option value="1">상품명</option>
		 			<option value="2" selected>상품가격</option>
		 		</c:when>

			 </c:choose>
			 
			</select>
			<input 	type="text" name="searchKeyword"  value="${! empty search.searchKeyword ? search.searchKeyword : "" }"
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetPurchaseList(1);">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			
			</table>
			<td align="left">
		<input type="radio" id="Desc" name="Order" value="Desc">
		<label for="Desc">가격 높은순</label>
		<input type="radio" id="Asc" name="Order" value="Asc">
		<label for="Asc">가격 낮은순</label>
	</td>
		</td>
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
		<td class="ct_line02"></td>
	</tr>
	<tr>
		<td colspan="13" bgcolor="808285" height="1"></td>
	</tr>

	<c:forEach var="i" items= "${list}" varStatus="status" >

	
		<tr class="ct_list_pop">
			<td align="center">
				${status.count }
			</td>
			<td></td>
			<td><a href="/getPurchase.do?tranNo=${i.tranNo }">${i.purchaseProd.prodNo }</a></td>
			<c:if test="${user.role eq 'admin'}">
			<td></td>
				<td align="left">
				<a href="/getUser.do?userId=${i.buyer.userId }">${i.buyer.userId }</a>
				</td>
			</c:if>
			<td align="left"></td>
			<td align="left">${i.receiverName }</td>
			<td></td>
			<td align="left">${i.receiverPhone }</td>
			<td></td>
			 
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
			 
			 	<c:if test="${ i.tranCode.trim() eq '1' && user.role eq 'user'}">
			 		<a href="/updatePurchaseView.do?tranNo=${i.tranNo }">구매 상세정보 수정하기</a>
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
		<td colspan="13" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">

		<input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<c:if test="${resultPage.currentPage>resultPage.pageUnit }">
				<a href="javascript:fncGetPurchaseList('${resultPage.currentPage-1}')">이전</a>
			</c:if>
			
			<c:forEach var="i" begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage }" varStatus="status" >
				<a href="javascript:fncGetPurchaseList('${i }');">${i }</a> 
			</c:forEach>
			
			<c:if test="${resultPage.endUnitPage<resultPage.maxPage }">
				<a href="javascript:fncGetPurchaseList('${resultPage.endUnitPage+1}')">다음</a>
			</c:if>
			
		</td>
	</tr>
</table>


</form>

</div>

</body>
</html>