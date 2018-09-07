<%@page import="org.kosta.borrow.model.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- colspan 수정하지 마세요 -->
<style>
.bg_gr{
 	background-color: #e0e0e0;
 	font-size:20px;
 	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#FFFFFF;
 text-align: center;
}
.bg_gr:hover{
	 background-color: #f6cac9;
	 font-size:20px;
	 font-weight:bold;
	 text-shadow: 0 0 2px #000;
	 color:#FFFFFF;
	  text-align: center;
}
h3{
	
	padding-top: 140px;
	font-weight: bold;
	text-align:center;
	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#A9D0F5;

}
.success{
	font-weight:bold;
}
.bgheader {
	height: 80px;
}
.bgfooter {
	height: 80px;
}
table{
	text-align: center;
}
pre{
	text-align:left;
}
</style>

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
<table class="table table-bordered boardlist">

		<tr class="success table-danger" style="width:10%">
			<td style="width:5%">글번호 </td>
			<td scope="row" style="width:8%">상품정보</td>
			<td scope="row" class="title" style="width:28%">제목 </td>
			<td scope="row" style="width:7%">작성자</td>
			<td scope="row" style="width:10%">작성일</td>
			<td scope="row" style="width:5%">평점</td>
			<td scope="row" style="width:5%">조회</td>
		</tr>
		<tr>
			<td>${requestScope.rvo.reviewNo}</td>
			<td><a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${rvo.rentalDetailVO.itemVO.itemNo}">
				${rvo.rentalDetailVO.itemVO.itemName}</a></td>
			<td>${requestScope.rvo.reviewTitle} </td>
			<td>${requestScope.rvo.memberVO.id}</td>
			<td>${requestScope.rvo.reviewRegdate}</td>
			<td>${requestScope.rvo.reviewGrade}</td>
			<td>${requestScope.rvo.reviewHit}</td>
		</tr>

			<tr style="height:300px" style="width:100px">
				<td colspan="1">내용</td>
				<td colspan="6" style="width:10%" style="text-align:left">
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
			 <hr>
			 <div class="col-sm-2" align="center"></div>
			 <div class="col-sm-8 mypagecontent" align="center">
			 <table>
			 	<tr>
				 	<td><button type="button" class="btn bg_gr" style="WIDTH: 80pt; HEIGHT: 40pt;" onclick="deleteReview()">삭제</button></td>
				 	<td><button type="button" class="btn bg_gr" style="WIDTH: 80pt; HEIGHT: 40pt;" onclick="updateReview()">수정</button></td>
			 	</tr>
			 </table>
			 </div>
			 <div class="col-sm-2" align="center"></div>
			 </c:if>
<form id="deleteReviewForm"action="${pageContext.request.contextPath}/front"method="post">
	<input type="hidden" name="command" value="ReviewDelete">
	<input type="hidden" name="reviewNo" value="${requestScope.rvo.reviewNo}">
	<input type="hidden" name="itemNo" value="${requestScope.rvo.rentalDetailVO.itemVO.itemNo}">
</form>
	
	
	