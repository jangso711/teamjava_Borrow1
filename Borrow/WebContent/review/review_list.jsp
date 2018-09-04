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
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12" align="center">
<table class="table table-bordered  table-hover boardlist">
	<thead>
		<tr class="success">
			<th>번호</th>
			<th class="title">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="rvo" items="${requestScope.rvo.list}">
			<tr>
				<td>${rvo.reviewNo}</td>
				<td>
				<a href="${pageContext.request.contextPath}/front?command=ReviewPost&ReviewNo=${rvo.reviewNo}">
					${rvo.reviewTitle}</a></td>
				<td>${rvo.memberVO.name}</td>
				<td>${rvo.reviewRegdate}</td>
				<td>${rvo.reviewHit}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${requestScope.rvo.pagingBean.previousPageGroup}">
<ul class="pagination">
 <li><a href="front?command=List&pageNo=${requestScope.rvo.pagingBean.startPageOfPageGroup-1}">&laquo;</a></li> 
</ul>
</c:if>
<c:forEach begin="${requestScope.rvo.pagingBean.startPageOfPageGroup}"
	end="${requestScope.rvo.pagingBean.endPageOfPageGroup}" var="pagenum">
	<ul class="pagination">
	<c:choose>
	<c:when test="${requestScope.rvo.pagingBean.nowPage!=pagenum}">	
		<li><a href="front?command=List&pageNo=${pagenum}">${pagenum}</a></li>
		</c:when>
		<c:otherwise>
		<li class="active"><a href="#">${pagenum}</a></li>
		</c:otherwise>
		</c:choose>
	</ul>	
</c:forEach>
<c:if test="${requestScope.rvo.pagingBean.nextPageGroup}">
<ul class="pagination">
 <li><a href="front?command=List&pageNo=${requestScope.rvo.pagingBean.endPageOfPageGroup+1}">&raquo;</a></li>  
</ul>
</c:if>
</div>
<div class="col-sm-12 bgfooter"></div>