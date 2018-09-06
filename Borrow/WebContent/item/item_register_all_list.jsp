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
	<h3>${memberId}님의 상품 목록</h3>
	<br>
	<form action="front">
		<input type="hidden" name="command" value="ItemRegisterAllList">
		id로 상품 검색<input type="text" name="memberId" required="required">
		<input type="submit" value="검색">
	</form>
	<br>
	<div class="row">
		<c:choose>
			<c:when test="${empty requestScope.allItemList }">
				${memberId}님의 등록상품은 존재하지 않습니다!!	
			</c:when>
			<c:otherwise>
				<c:forEach items="${requestScope.allItemList }" var="allItemList">
					<c:set
						value="${pageContext.request.contextPath }/front?command=ItemDetail&itemNo=${allItemList.itemNo}"
						var="detailurl"></c:set>
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
							</div>
						</div>
					</div>
				</c:forEach>
	</div>
	<!-- /.row -->

	<!-- Pagination -->
	<ul class="pagination justify-content-center">

		<c:set value="${requestScope.pagingBean }" var="pb"></c:set>
		<li class="page-item"><a class="page-link" href="#"
			aria-label="Previous"> <span aria-hidden="true">&laquo;</span> <span
				class="sr-only">Previous</span>
		</a></li>

		<c:forEach begin="${pb.startPageOfPageGroup}"
			end="${pb.endPageOfPageGroup}" var="pageNo">
			<li class="active"><a class="page-link" href="#">${pageNo }</a></li>
		</c:forEach>

		<li class="page-item"><a class="page-link" href="#"
			aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
				class="sr-only">Next</span>
		</a></li>

	</ul>
</div>
</c:otherwise>
</c:choose>
<!-- /.container -->