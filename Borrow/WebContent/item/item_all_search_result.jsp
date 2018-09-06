<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<style>
h4 {
	font-weight: bold;
}

.bgheader {
	height: 50px;
}

.target {
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap: break-word;
	line-height: 1.2em;
	height: 3.6em;
}
</style>

<div class="col-sm-12 bgheader"></div>

<!-- Page Content -->
<div class="container">
	<h3> 전체 상품 목록 </h3><br>
	<form action="front">
		<input type="hidden" name="command" value="ItemRegisterAllList">
		id로 상품 검색<input type="text" name="memberId" required="required">
		<input type="submit" value="검색">
	</form>
	<br>
	<div class="row">		
		<c:forEach items="${requestScope.allItemList }" var="allItemList">
			<c:set
				value="${pageContext.request.contextPath }/front?command=ItemDetail&itemNo=${allItemList.itemNo}"
				var="detailurl"></c:set>

			<!-- 180905 MIRI 내가 등록한 상품은 보여주지 않기 -->
			<c:if test="${not (sessionScope.user.id == allItemList.memberVO.id)}">
				<div class="col-lg-4 portfolio-item">
					<div class="card h-100">
						<a href="${detailurl}"><img class="card-img-top"
							src="${pageContext.request.contextPath}/upload/${allItemList.picList[0]}"
							width="500" height="250" alt=""></a>
						<div class="card-body">
							<h4 class="card-title">
								<a href="${detailurl }">${allItemList.itemName }</a>
							</h4>
							<p class="card-text">
							<pre class="target">${allItemList.itemExpl }</pre>
							<fmt:formatNumber>${allItemList.itemPrice }</fmt:formatNumber>
							원
							</p>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
	<!-- /.row -->

	<!-- Pagination -->
	<ul class="pagination justify-content-center pagination">
		<c:set value="${requestScope.pagingBean }" var="pb"></c:set>
		<!-- PrevPage -->
		<c:choose>
			<c:when test="${pb.previousPageGroup }">
				<li class="page-item"><a class="page-link" 
					href="${pageContext.request.contextPath }/front?command=ItemAllSearch&pageNum=${pb.startPageOfPageGroup-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span> <span
					class="sr-only">Previous</span>
				</a></li>&nbsp;&nbsp;
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="page-link" aria-label="Previous"> 
				<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span></a></li>&nbsp;&nbsp;
			</c:otherwise>
		</c:choose>
		<!-- PageNum -->
		<c:forEach begin="${pb.startPageOfPageGroup}"
			end="${pb.endPageOfPageGroup}" var="pageNum">
			<c:choose>
				<c:when test="${pb.nowPage == pageNum }">
					<li class="active"><a class="page-link-active">${pageNum }</a></li>&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
					<li><a class="page-link"
						href="${pageContext.request.contextPath }/front?command=ItemAllSearch&pageNum=${pageNum }">${pageNum }</a></li>&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<!-- NextPage -->
		<c:choose>
			<c:when test="${pb.nextPageGroup }">
				<li class="page-item"><a class="page-link" 
					href="${pageContext.request.contextPath }/front?command=ItemAllSearch&pageNum=${pb.endPageOfPageGroup+1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
					class="sr-only">Next</span>
				</a></li>&nbsp;&nbsp;
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="page-link" aria-label="Next"> 
				<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span></a></li>&nbsp;&nbsp;
			</c:otherwise>
		</c:choose>
	</ul>
</div>
