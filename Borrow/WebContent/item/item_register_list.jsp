<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<style type="text/css">
.bgheader {
	height: 160px;
}
</style>


<div class="col-sm-12 bgheader"></div>
<div class="container" align="center">
	<br><h3>나의 빌려준 물품 목록</h3><br>	
	
	<c:choose>
		<c:when test="${fn:length(requestScope.registerlist)==0}">
			<span>빌려준 물품이 없습니다!! </span>
		</c:when>
		<c:otherwise>
			<table class="col-sm-12">
				<tr>
					<th>사진</th>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>빌린 사람(id)</th>
					<th>받은금액</th>
					<th>대여날짜</th>
					<th>반납날짜</th>					
				</tr>
				<c:forEach items="${requestScope.registerlist}" var="registerdetail">
					<fmt:parseDate value="${registerdetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
					<fmt:parseDate value="${registerdetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
					<tr>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemSearchId=${registerdetail.itemVO.itemNo}"><img src="${pageContext.request.contextPath}/upload/${registerdetail.itemVO.picList[0]}" width="150" height="150" ></a></td>
						<td>${registerdetail.rentalNo}</td>
						<td>${registerdetail.itemVO.itemName}</td>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRegisterAllList&memberId=${registerdetail.itemVO.memberVO.id}">${registerdetail.itemVO.memberVO.id}</a></td>
						<td><fmt:formatNumber>${registerdetail.itemVO.itemPrice}</fmt:formatNumber>원 x ${endDate-strDate}일 = ${registerdetail.itemVO.itemPrice*(endDate-strDate)}원</td>
						<td>${registerdetail.rentalDate}</td>
						<td>${registerdetail.returnDate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</div>