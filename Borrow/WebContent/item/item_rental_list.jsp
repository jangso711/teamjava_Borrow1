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
	margin:0 auto;	/*테이블 중간 정렬*/
}
.listContent{
	padding-top:10px;
	padding-bottom:10px;
	min-height: 500px;
	height: auto;
	text-align:center;
}
.center{
	padding-top:20px;
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
<div class="col-sm-12 listContent">
	<br><h3>빌린 물품 목록</h3><br>	
<!--현재 날짜 변수 저장 -->
	<jsp:useBean id="currTime" class="java.util.Date" />	
	<fmt:parseNumber value="${currTime.time / (1000*60*60*24)}" integerOnly="false" var="curDate"></fmt:parseNumber>		
	<c:choose>
		<c:when test="${fn:length(requestScope.rentallist)==0}">
			<h6 style="color:red;">대여하신 물품이 없습니다!!</h6>
		</c:when>
		<c:otherwise>
			<table cellpadding="10">
<!-- 				<tr>
					<th>사진</th>
					<th>거래번호</th>
					<th>아이템명</th>
					<th>등록한 사람(id)</th>
					<th>지불금액</th>
					<th>대여날짜</th>
					<th>반납날짜</th>		
					<th>반납상태</th>			
				</tr> -->
				<c:forEach items="${requestScope.rentallist}" var="rentaldetail" varStatus="info">
					<fmt:parseDate value="${rentaldetail.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="strDate"></fmt:parseNumber>
					<fmt:parseDate value="${rentaldetail.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="false" var="endDate"></fmt:parseNumber>					
					<tr class="topTr">
					<td rowspan="4">${info.count }</td>
					<td rowspan="4"><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${rentaldetail.itemVO.itemNo}"><img src="${pageContext.request.contextPath}/upload/${rentaldetail.itemVO.picList[0]}" width="150" height="150" ></a></td>						
					<td>거래번호</td>
					<th><a href="${pageContext.request.contextPath}/front?command=ItemRentDetail&rental_no=${rentaldetail.rentalNo} &check=a">${rentaldetail.rentalNo}</a></th>
					</tr>
					<tr>
					<td>상품명</td>
					<th>${rentaldetail.itemVO.itemName}</th>
					</tr>
					<tr>
					<td>대여기간</td>
					<th>${rentaldetail.rentalDate}~${rentaldetail.returnDate}</th>
					</tr>
					<tr id="bottomTr">
					<td>현재상태</td>
					<th><c:choose>
								<c:when test="${strDate-curDate>0}">
									결제완료&nbsp;&nbsp;<input type="button" value="대여취소" class="rentalCancel btn btn_center btn_pk">
									<input type="hidden" class="rNo" value="${rentaldetail.rentalNo}">									
									<input type="hidden" class="point" value="${rentaldetail.totalPayment}">
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${endDate-curDate>0}">
											<form class="earlyReturnForm">
												<input type="hidden" name="command" value="ItemEarlyReturn">
												<input type="hidden" name="rentalNo" value="${rentaldetail.rentalNo}">
												대여중&nbsp;&nbsp;<input type="button" class="returnbtn btn btn_center btn_pk" value="반납하기" id="${rentaldetail.rentalNo}">
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
							</c:choose></th>
					</tr>
					<tr>
					<td colspan=4><div style="margin:10px"></div></td> 
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