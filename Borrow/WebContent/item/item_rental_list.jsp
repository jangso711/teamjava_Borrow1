<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style type="text/css">
.bgheader {
	height: 160px;
}
</style>


<div class="col-sm-12 bgheader"></div>
<div class="container" align="center">
	<c:choose>
		<c:when test="${fn:length(requestScope.rentallist)==0}">
			<span>대여하신 물품이 없습니다!! </span>
		</c:when>
		<c:otherwise>
			<table class="col-sm-12">
				<tr>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>등록한 사람(id)</th>
					<th>대여날짜</th>
					<th>반납날짜</th>
				</tr>
				<c:forEach items="${requestScope.rentallist}" var="rentaldetail">
					<tr>
						<td>${rentaldetail.rentalNo}</td>
						<td>${rentaldetail.itemVO.itemName}</td>
						<td>${rentaldetail.itemVO.memberVO.id}</td>
						<td>${rentaldetail.rentalDate}</td>
						<td>${rentaldetail.returnDate}</td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</div>