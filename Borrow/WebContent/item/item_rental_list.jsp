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

<script type="text/javascript">
	$(document).ready(function(){
		$(".rentalCancel").click(function(){
			$.ajax({
			type:"post",
			url:"${pageContext.request.contextPath}/front",
			data:"command=rentalCancel&rentalNo="+$(this).parent().find(".rNo").val()+"&point="+$(this).parent().find(".point").val(),
			success : function(result){
				alert('대여취소 성공!! 반환 포인트:'+result);
				location.reload(true);
				
				/* if(result=="ok"){					
					
					location.reload(true);
				}else{
					alert("대여취소를 할 수 없습니다");
					location.reload(true);
				} */
			}
			});//ajax
		});//click
		
		$(".returnbtn").click(function() {
			 $.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/front",
				data:$(this).parent().serialize(),
				success : function(result){
					if(result=="ok"){
						alert("반납 완료");
						location.reload(true);					
					}else{
						alert("반납 실패");
						location.reload(true);
					}
				}				
			});			 			
		});
		
	
		
		
		
	});//ready
	function reviewForm(rentalNo){
		$("#reviewViewForm").find("#rentalNo").val(rentalNo);
		$("#reviewViewForm").submit();
	}


</script>


<div class="col-sm-12 bgheader"></div>
<div class="container" align="center">
	<br><h3>내가 대여한 목록</h3><br>	
<div class="row">
<div class="col-sm-2"></div>
<div class="col-sm-8"></div>
<!-- 	현재 날짜 변수 저장 -->
	<jsp:useBean id="currTime" class="java.util.Date" />	
	<fmt:parseNumber value="${currTime.time / (1000*60*60*24)}" integerOnly="false" var="curDate"></fmt:parseNumber>		
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
					<!-- <th>지불금액</th> -->
					<th>대여날짜</th>
					<th>반납날짜</th>		
					<th>반납상태</th>			
				</tr>
				<c:forEach items="${requestScope.rentallist}" var="rentaldetail">
					<fmt:parseDate value="${rentaldetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="strDate"></fmt:parseNumber>
					<fmt:parseDate value="${rentaldetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="endDate"></fmt:parseNumber>					
					<tr>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${rentaldetail.itemVO.itemNo}"><img src="${pageContext.request.contextPath}/upload/${rentaldetail.itemVO.picList[0]}" width="150" height="150" ></a></td>						
						<%-- 2018-09-04 대여상세 링크 추가 --%>
						<td><a href="${pageContext.request.contextPath}/front?command=ItemRentDetail&rental_no=${rentaldetail.rentalNo} &check=a">${rentaldetail.rentalNo}</a></td>
						
						<td>${rentaldetail.itemVO.itemName}</td>
						
						<%-- <td><fmt:formatNumber>${rentaldetail.itemVO.itemPrice}</fmt:formatNumber>원 x ${endDate-strDate}일 = <fmt:formatNumber>${rentaldetail.itemVO.itemPrice*(endDate-strDate)}</fmt:formatNumber>원</td> --%>
						<td >${rentaldetail.rentalDate}</td>
						<td>${rentaldetail.returnDate}</td>
						<td>												
							<c:choose>
								<c:when test="${strDate-curDate>0}">
									<input type="button" value="대여취소" class="rentalCancel btn btn_center btn_pk">
									<input type="hidden" class="rNo" value="${rentaldetail.rentalNo}">									
									<input type="hidden" class="point" value="${rentaldetail.totalPayment}">
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${endDate-curDate>0}">
											<form class="earlyReturnForm">
												<input type="hidden" name="command" value="ItemEarlyReturn">
												<input type="hidden" name="rentalNo" value="${rentaldetail.rentalNo}">
												<input type="button" class="returnbtn btn btn_center btn_pk" value="반납하기" id="${rentaldetail.rentalNo}">
											</form>	
										</c:when>
										<c:otherwise>
											반납완료<br>
											<c:choose>
												<c:when test="${rentaldetail.review_status==1}">
													후기 작성 완료<br>
													<a href="${pageContext.request.contextPath}/front?command=ReviewPostByRentalNo&rentalNo=${rentaldetail.rentalNo}" style="color:blue;">내 후기 보러가기</a>													
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn_center btn_pk" onclick="reviewForm(${rentaldetail.rentalNo})">후기 작성하기</button>																						
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>								
								</c:otherwise>								
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
						
			<c:set var="pb" value="${requestScope.pagingBean}" />
				<div class="col-sm-12 center" align="center">					
						<ul class="pagination justify-content-center">
						<c:if test="${pb.previousPageGroup }">
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/front?command=ItemRentalList&nowPage=${pb.startPageOfPageGroup-1}">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pb.startPageOfPageGroup}"
							end="${pb.endPageOfPageGroup}" var="pagenum">
							<c:choose>
								<c:when test="${pagenum==pb.nowPage}">
									<li class="page-item active"><a class="page-link" href="#">${pagenum}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link"
										href="${pageContext.request.contextPath}/front?command=ItemRentalList&nowPage=${pagenum}">${pagenum}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pb.nextPageGroup }">
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/front?command=ItemRentalList&nowPage=${pb.endPageOfPageGroup+1}">&raquo;</a></li>
						</c:if>
					</ul>				
			</div>
			
		</c:otherwise>
	</c:choose>
</div>
<form id="reviewViewForm"action="${pageContext.request.contextPath }/front"method="post">
<input type="hidden"name="command"value="ReviewRegisterForm">
<input type="hidden"name="rentalNo"id="rentalNo">
</form>