<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
.bgheader {
	height: 50px;
}
th,td{
	padding-left: 50px;
	padding-right:50px;
}
tr{
	border-top:1px solid #e0e0e0;
	border-bottom:1px solid #e0e0e0;
}
table{
	border-top:2px solid #e0e0e0;
	border-bottom:2px solid #e0e0e0;
	margin : 0 auto;
}


.listContent{
	padding-top:10px;
	padding-bottom:10px;
	height:450px;
	text-align:center;
}
</style>

<div class="col-sm-12 listContent">
	<br><h3>나의 빌려준 물품 목록</h3><br>	
	
	<!-- 	현재 날짜 변수 저장 -->
	<jsp:useBean id="currTime" class="java.util.Date" />	
	<fmt:parseNumber value="${currTime.time / (1000*60*60*24)}" integerOnly="false" var="curDate"></fmt:parseNumber>	
	<c:choose>
		<c:when test="${fn:length(requestScope.registerlist)==0}">
			<h6 style="color:red;">빌려준 물품이 없습니다!!</h6>
		</c:when>
		<c:otherwise>
			<table cellpadding="10">
				<!--
				<tr>
					<th>사진</th>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>빌린 사람(id)</th>
					<th>받은금액</th> 
					<th>대여날짜</th>
					<th>반납날짜</th>		
					<th>반납상태</th>			
				</tr>
				-->
				<c:forEach items="${requestScope.registerlist}" var="registerdetail" varStatus="info">
					<fmt:parseDate value="${registerdetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="strDate"></fmt:parseNumber>
					<fmt:parseDate value="${registerdetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="endDate"></fmt:parseNumber>
					<tr class="topTr">
					<td rowspan="5">${info.count }</td>
					<td rowspan="5"><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${registerdetail.itemVO.itemNo}"><img src="${pageContext.request.contextPath}/upload/${registerdetail.itemVO.picList[0]}" width="150" height="150" ></a></td>		
						<th>거래번호</th>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRentDetail&rental_no=${registerdetail.rentalNo} &check=a">${registerdetail.rentalNo} </a> </td>
						</tr>
						<tr>
						<td>상품명</td>
						<td>${registerdetail.itemVO.itemName}</td>
						</tr>
						<tr>
						<th>빌린 사람(id)</th>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRegisterAllList&memberId=${registerdetail.itemVO.memberVO.id}">${registerdetail.itemVO.memberVO.id}</a></td>
						</tr>
						<tr>
						<td>대여기간</td>
						<th>${registerdetail.rentalDate}~${registerdetail.returnDate}</th>
						</tr>
						<tr id="bottomTr">
						<td>현재상태</td>
							<th><c:choose>
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
											<c:choose>
												<c:when test="${registerdetail.review_status==1}">													
													<a href="${pageContext.request.contextPath}/front?command=ReviewPostByRentalNo&rentalNo=${registerdetail.rentalNo}" style="color:blue;">사용자 후기 보러가기</a>													
												</c:when>
												<c:otherwise>
													사용자가 아직 후기 작성안함															
												</c:otherwise>			
											</c:choose>																															
										</c:otherwise>
									</c:choose>								
								</c:otherwise>								
							</c:choose>	
							</th>					
						</tr>
					
			<tr> 
				<td colspan=4><div style="margin:10px"></div></td> 
			</tr> 
					
				</c:forEach>
			</table>
			<c:set var="pb" value="${requestScope.pagingBean }" />
			</div>
				<div class = "col-sm-12 center">
					<ul class = "pagination justify-content-center">
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
				
		</c:otherwise>
	</c:choose>
</div>