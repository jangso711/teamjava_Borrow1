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
<!-- 	현재 날짜 변수 저장 -->
	<jsp:useBean id="currTime" class="java.util.Date" />	
	<fmt:parseNumber value="${currTime.time / (1000*60*60*24)}" integerOnly="false" var="curDate"></fmt:parseNumber>	
	현재 시간${curDate}<br>
	
	<fmt:parseDate value="2018-09-04" var="aaa" pattern="yyyy-MM-dd"/>
	<fmt:parseNumber value="${aaa.time / (1000*60*60*24)}" integerOnly="false" var="aaa"></fmt:parseNumber>
	9월4일 00시 ${aaa}<br>
	<fmt:parseDate value="2018-09-05" var="bbb" pattern="yyyy-MM-dd"/>
	<fmt:parseNumber value="${bbb.time / (1000*60*60*24)}" integerOnly="false" var="bbb"></fmt:parseNumber>
	9월5일 00시 ${bbb}<br>
	${curDate-aaa }
	${bbb-aaa}
	
	
	<c:choose>
		<c:when test="${fn:length(requestScope.rentallist)==0}">
			<span>대여하신 물품이 없습니다!! </span>
		</c:when>
		<c:otherwise>
			<table class="table col-sm-12">
				<tr>
					<th>사진</th>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>등록한 사람(id)</th>
					<th>지불금액</th>
					<th>대여날짜</th>
					<th>반납날짜</th>		
					<th>반납상태</th>			
				</tr>
				<c:forEach items="${requestScope.rentallist}" var="rentaldetail">
					<fmt:parseDate value="${rentaldetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseDate value="${rentaldetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<tr>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${rentaldetail.itemVO.itemNo}"><img src="${pageContext.request.contextPath}/upload/${rentaldetail.itemVO.picList[0]}" width="150" height="150" ></a></td>						
						<%-- 2018-09-04 대여상세 링크 추가 --%>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRentDetail&rental_no=${rentaldetail.rentalNo} &check=a">${rentaldetail.rentalNo}</a></td>
						<td>${rentaldetail.itemVO.itemName}</td>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRegisterAllList&memberId=${rentaldetail.itemVO.memberVO.id}">${rentaldetail.itemVO.memberVO.id}</a></td>
						<td><fmt:formatNumber>${rentaldetail.itemVO.itemPrice}</fmt:formatNumber>원 x ${endDate-strDate}일 = <fmt:formatNumber>${rentaldetail.itemVO.itemPrice*(endDate-strDate)}</fmt:formatNumber>원</td>
						<td>${rentaldetail.rentalDate}</td>
						<td>${rentaldetail.returnDate}</td>
						<td>					
							<%-- <c:choose>
								<c:when test="${endDate-strDate}">
								
								</c:when>
							<button type="button" class="btn btn_center btn_pk" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemEarlyReturn&rentalNo=${rentaldetail.rentalNo}'">반납하기</button></td>
							</c:choose> --%>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</div>