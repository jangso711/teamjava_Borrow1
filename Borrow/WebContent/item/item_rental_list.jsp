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
	<br><h3>나의 대여 목록</h3><br>	
	
	<c:choose>
		<c:when test="${fn:length(requestScope.rentallist)==0}">
			<span>대여하신 물품이 없습니다!! </span>
		</c:when>
		<c:otherwise>
			<table class="col-sm-12">
				<tr>
					<th>사진</th>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>등록한 사람(id)</th>
					<th>지불금액</th>
					<th>대여날짜</th>
					<th>반납날짜</th>					
				</tr>
				<c:forEach items="${requestScope.rentallist}" var="rentaldetail">
					<fmt:parseDate value="${rentaldetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
					<fmt:parseDate value="${rentaldetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
					<tr>
						<td><img src="${pageContext.request.contextPath}/upload/${rentaldetail.itemVO.picList[0]}" width="150" height="150" ></td>						
						<td>${rentaldetail.rentalNo}</td>
						<td>${rentaldetail.itemVO.itemName}</td>
						<td>${rentaldetail.itemVO.memberVO.id}</td>
						<td>${rentaldetail.itemVO.itemPrice}원 x ${endDate-strDate}일 = ${rentaldetail.itemVO.itemPrice*(endDate-strDate)}원</td>
						<td>${rentaldetail.rentalDate}</td>
						<td>${rentaldetail.returnDate}</td>
						<td><button type="button" class="btn btn_center btn_pk" onclick="location.href=
	'${pageContext.request.contextPath}/front?command=ItemEarlyReturn'">조기 반납</button></td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</div>