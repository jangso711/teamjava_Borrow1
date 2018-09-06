<%@page import="org.kosta.borrow.model.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.btn_pk {
	background-color: #f6cac9;
	height: 45px;
	margin: 10px;
	
}
h3{
	
	padding-top: 140px;
	font-weight: bold;
	text-align:center;
	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#A9D0F5;

}

.bgheader {
	height: 80px;
}
.bgfooter {
	height: 80px;
}
</style>
<%
Cookie cookie=new Cookie("hit", "reviewNo");
%>
<script type="text/javascript">
function sendList(){
	location.href="${pageContext.request.contextPath}/index.jsp";
}
function deleteReview(){
	if(confirm("후기를 삭제하시겠습니까?")){
		$("#deleteReviewForm").submit();		//180905 SOJEONG 수정
	}
}
function updateReview(){
	if(confirm("후기를 수정하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/front?command=ReviewUpdateForm&reviewNo=${requestScope.rvo.reviewNo}";
	}
}
</script>

<div class="col-sm-12 bgheader"></div>
<div class="col-sm-2" align="center"></div>
<div class="col-sm-8" align="center">
<table class="table table-hover boardlist">

		<tr style="width:10%">
			<td style="width:5%">글번호 </td>
			<td style="width:8%">상품정보</td>
			<td style="width:28%">제목 </td>
			<td style="width:5%">작성자</td>
			<td style="width:7%">작성일</td>
			<td style="width:5%">작성일</td>
			<td style="width:5%">조회수</td>
		</tr>
		<tr>
			<td>${requestScope.rvo.reviewNo}</td>
			<td>${requestScope.rvo.rentalDetailVO.itemVO.itemName}</td>
			<td>${requestScope.rvo.reviewTitle} </td>
			<td>${requestScope.rvo.memberVO.id}</td>
			<td>${requestScope.rvo.reviewRegdate}</td>
			<td>${requestScope.rvo.reviewGrade}</td>
			<td>${requestScope.rvo.reviewHit}</td>
		</tr>

			<tr style="height:300px">
				<td colspan="7" style="width:10%">
				<pre>${requestScope.rvo.reviewContent}</pre>
				</td>
			</tr>

	</table>
	</div>
	<div class="col-sm-2" align="center"></div>
	<c:if test="${requestScope.rvo.memberVO.id==sessionScope.user.id}">
			 <form name="deleteForm" action="${pageContext.request.contextPath}/front" method="post">
			 	<input type="hidden" name="command" value="DeleteReview">
			 	<input type="hidden" name="reviewNo" value="${requestScope.rvo.reviewNo}">
			 </form>
			 <button type="button" class="btn" onclick="deleteReview()">삭제</button>
			 <button type="button" class="btn" onclick="updateReview()">수정</button>
			 </c:if>
<form id="deleteReviewForm"action="${pageContext.request.contextPath}/front"method="post">
	<input type="hidden" name="command" value="ReviewDelete">
	<input type="hidden" name="reviewNo" value="${requestScope.rvo.reviewNo}">
	<input type="hidden" name="itemNo" value="${requestScope.rvo.rentalDetailVO.itemVO.itemNo}">
</form>
	
	
	