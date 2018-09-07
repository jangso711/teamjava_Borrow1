<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-sm-2" align="center"></div>
<div class="col-sm-8" align="center">
<table class="table table-bordered  table-hover boardlist">
	<thead>
		<tr class="success" style="width:10%">
			<th style="width:2%">번호</th>
			<th style="width:8%">상품정보</th>
			<th class="title" style="width:28%">제목</th>
			<th style="width:5%">작성자</th>
			<th style="width:7%">작성일</th>
			<th style="width:3%">평점</th>
			<th style="width:3%">조회</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="rvo" items="${requestScope.rvo.list}">
			<tr style="width:10%">
				<td style="width:2%">${rvo.reviewNo}</td>
				<td style="width:8%">${rvo.rentalDetailVO.itemVO.itemName}</td>
				<td style="width:28%">
				<a href="${pageContext.request.contextPath}/front?command=ReviewPost&reviewNo=${rvo.reviewNo}">
					${rvo.reviewTitle}</a></td>
				<td style="width:5%">${rvo.memberVO.name}</td>
				<td style="width:7%">${rvo.reviewRegdate}</td>
				<td style="width:3%">${rvo.reviewGrade}</td>
				<td style="width:3%">${rvo.reviewHit}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<ul class="pagination justify-content-center">
<c:if test="${requestScope.rvo.pagingBean.previousPageGroup}">
 <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${requestScope.rvo.pagingBean.startPageOfPageGroup-1}">&laquo;</a></li> 
</c:if>
<c:forEach begin="${requestScope.rvo.pagingBean.startPageOfPageGroup}"
	end="${requestScope.rvo.pagingBean.endPageOfPageGroup}" var="pagenum">
	<c:choose>
	<c:when test="${requestScope.rvo.pagingBean.nowPage!=pagenum}">											
		<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${pagenum}">${pagenum}</a></li>
		</c:when>
		<c:otherwise>
		<li class="page-item active"><a class="page-link" href="#">${pagenum}</a></li>
		</c:otherwise>
		</c:choose>
</c:forEach>
<c:if test="${requestScope.rvo.pagingBean.nextPageGroup}">
 <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${requestScope.rvo.pagingBean.endPageOfPageGroup+1}">&raquo;</a></li>  
</c:if>
</ul>
</div>