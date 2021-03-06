<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.btn_pk {
	background-color: #f6cac9;
	height: 30px;
	margin: 10px;
	
}
h3{
	
	padding-top: 20px;
	padding-bottom:20px;
	font-weight: bold;
	text-align:center;
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

</style>
<div class="col-sm-12 bgheader" align="center"><h3>후기 검색 게시판</h3></div>
<div class="col-sm-4"></div>
<div class="col-sm-8" align="center">
<form action="front">

		<input type="hidden" name="command" value="ReviewFindItemName">
		<input type="text" name="itemName" required="required" placeholder="상품 이름으로 검색" style="height:30px; width: 300px;">
		<input type="submit" value="검색" class="btn btn_pk">
	</form>
	</div>
<div class="col-sm-2"></div>
<div class="col-sm-8" align="center">
<table class="table table-bordered table-hover boardlist">
	<thead>
		<tr class="success table-danger" style="width:10%">
			<th style="width:2%">번호</th>
			<th style="width:8%">상품정보</th>
			<th class="title" style="width:28%">제목</th>
			<th style="width:7%">작성일</th>
			<th style="width:4%">평점</th>
			<th style="width:4%">조회</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="rvo" items="${requestScope.rvo.list}">
			<tr style="width:10%">
				<td style="width:2%">${rvo.reviewNo}</td>
				<td style="width:8%">
				<a href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${rvo.rentalDetailVO.itemVO.itemNo}">
				${rvo.rentalDetailVO.itemVO.itemName}</a></td>
				<td style="width:28%">
				<a href="${pageContext.request.contextPath}/front?command=ReviewPostByReviewNo&reviewNo=${rvo.reviewNo}">
					${rvo.reviewTitle}</a></td>
				<td style="width:7%">${rvo.reviewRegdate}</td>
				<td style="width:3%">${rvo.reviewGrade}</td>
				<td style="width:3%">${rvo.reviewHit}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<ul class="pagination justify-content-center">
<c:if test="${requestScope.rvo.pagingBean.previousPageGroup}">
 <li class="page-item"><a class="page-link" href="front?command=ReviewList&pageNo=${requestScope.rvo.pagingBean.startPageOfPageGroup-1}">&laquo;</a></li> 
</c:if>
<c:forEach begin="${requestScope.rvo.pagingBean.startPageOfPageGroup}"
	end="${requestScope.rvo.pagingBean.endPageOfPageGroup}" var="pagenum">
	<c:choose>
	<c:when test="${requestScope.rvo.pagingBean.nowPage!=pagenum}">	
		<li class="page-item"><a class="page-link" href="front?command=ReviewList&pageNo=${pagenum}">${pagenum}</a></li>
		</c:when>
		<c:otherwise>
		<li class="page-item active"><a class="page-link" href="#">${pagenum}</a></li>
		</c:otherwise>
		</c:choose>
</c:forEach>
<c:if test="${requestScope.rvo.pagingBean.nextPageGroup}">
 <li class="page-item"><a class="page-link" href="front?command=ReviewList&pageNo=${requestScope.rvo.pagingBean.endPageOfPageGroup+1}">&raquo;</a></li>  
</c:if>
</ul>
</div>
<div class="col-sm-2"></div>
<div class="col-sm-12 bgfooter"></div>