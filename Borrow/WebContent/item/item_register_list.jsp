<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<style type="text/css">
.bgheader {
	height: 50px;
}
</style>



<div class="col-sm-12 bgheader"></div>
<div class="container" align="center">
	<br><h3>나의 빌려준 물품 목록</h3><br>	
	<!-- 	현재 날짜 변수 저장 -->
	<jsp:useBean id="currTime" class="java.util.Date" />	
	<fmt:parseNumber value="${currTime.time / (1000*60*60*24)}" integerOnly="false" var="curDate"></fmt:parseNumber>	
	<c:choose>
		<c:when test="${fn:length(requestScope.registerlist)==0}">
			<span>빌려준 물품이 없습니다!! </span>
		</c:when>
		<c:otherwise>
			<table class="table col-sm-12">
				<tr>
					<th>사진</th>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>빌린 사람(id)</th>
					<!-- <th>받은금액</th> -->
					<th>대여날짜</th>
					<th>반납날짜</th>		
					<th>반납상태</th>			
				</tr>
				<c:forEach items="${requestScope.registerlist}" var="registerdetail">
					<fmt:parseDate value="${registerdetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="strDate"></fmt:parseNumber>
					<fmt:parseDate value="${registerdetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="endDate"></fmt:parseNumber>
					<tr>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${registerdetail.itemVO.itemNo}"><img src="${pageContext.request.contextPath}/upload/${registerdetail.itemVO.picList[0]}" width="150" height="150" ></a></td>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRentDetail&rental_no=${registerdetail.rentalNo} &check=a">${registerdetail.rentalNo} </a> </td>
						<td>${registerdetail.itemVO.itemName}</td>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRegisterAllList&memberId=${registerdetail.itemVO.memberVO.id}">${registerdetail.itemVO.memberVO.id}</a></td>
						<%-- <td><fmt:formatNumber>${registerdetail.itemVO.itemPrice}</fmt:formatNumber>원 x ${endDate-strDate}일 = ${registerdetail.itemVO.itemPrice*(endDate-strDate)}원</td> --%>
						<td>${registerdetail.rentalDate}</td>
						<td>${registerdetail.returnDate}</td>
						<td>
							<c:choose>
								<c:when test="${strDate-curDate>0}">
									결제 후 대기중
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${endDate-curDate>0}">
											이용 중
										</c:when>
										<c:otherwise>
											반납완료<br>											
										</c:otherwise>
									</c:choose>								
								</c:otherwise>								
							</c:choose>						
						</td>
					</tr>
				</c:forEach>
			</table>
			<c:set var="pb" value="${requestScope.pagingBean }" />
				<div class = "col-sm-12 center">
					<ul class = "pagination">
					<c:if test = "${pb.previousPageGroup}">
						<li class="page-item">
							<a class="page-link" href= "${pageContext.request.contextPath}/front?command=ItemRegisterList&nowPage=${pb.startPageOfPageGroup-1}">&laquo;</a>
						</li>
					</c:if>
					<c:forEach begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}" var="pagenum">
						<c:choose>
							<c:when test="${pagenum==pb.nowPage}">
								 <li class="page-item active">
									<a class="page-link" href="#">${pagenum}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.contextPath}/front?command=ItemRegisterList&nowPage=${pagenum}">${pagenum}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pb.nextPageGroup}">
						<li class="page-item">
							<a class="page-link" href="${pageContext.request.contextPath}/front?command=ItemRegisterList&nowPage=${pb.endPageOfPageGroup+1}">&raquo;</a>
						</li>
					</c:if>
					</ul>
				</div>
		</c:otherwise>
	</c:choose>
</div>