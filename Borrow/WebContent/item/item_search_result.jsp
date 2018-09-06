<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	word-wrap:break-word; 
	line-height: 1.2em;
	height: 3.6em;
}
</style>
<div class="col-sm-12 bgheader"></div>
<!-- Page Content -->
<div class="container">
	<div class="row">
			<!-- 180903 MIRI 검색어와 일치하는 상품이 없을 시 alert 띄우고 메인화면으로 이동 -->
				<c:choose>
					<c:when test="${empty requestScope.itemSearchList  }">
						<script>
							alert("검색하신 '${param.searchtext}'에 해당하는 상품이 없습니다.");
							location.href="${pageContext.request.contextPath }/front?command=Main";
						</script>					
					</c:when>
				<c:otherwise>
					<c:forEach items="${requestScope.itemSearchList }" var="itemSearchList">
						<c:set value="${pageContext.request.contextPath }/front?command=ItemDetail&itemNo=${itemSearchList.itemNo}"
						var="detailurl"></c:set>
						<!-- 180905 MIRI 내가 등록한 상품은 보여주지 않기 -->
						<c:if test="${not (sessionScope.user.id == itemSearchList.memberVO.id)}">
						<div class="col-lg-4 portfolio-item">
							<div class="card h-100">
								<a href="${detailurl}"><img class="card-img-top"
									src="${pageContext.request.contextPath }/upload/${itemSearchList.picList[0]}"
									width="500" height="250"></a>
								<div class="card-body">
									<h4 class="card-title"> <a href="${detailurl }">${itemSearchList.itemName }</a> </h4>
									<p class="card-text"><pre class="target">${itemSearchList.itemExpl }</pre>
										<fmt:formatNumber>${itemSearchList.itemPrice }</fmt:formatNumber>원
									</p>
								</div>
							</div>
						</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
	</div>
	<!-- /.row -->

	<!-- Pagination -->
	<ul class="pagination justify-content-center pagination">
		<c:set value="${requestScope.pagingBean }" var="pb"></c:set>
		<!-- PrevPage -->
			<c:if test="${pb.previousPageGroup }">
				<li class="page-item"><a class="page-link" 
					href="${pageContext.request.contextPath }/front?command=ItemSearch&searchtext=${param.searchtext}&pageNum=${pb.startPageOfPageGroup-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span> <span
					class="sr-only">Previous</span>
				</a></li>&nbsp;&nbsp;
			</c:if>
		<!-- PageNum -->
		<c:forEach begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}" var="pageNum">
			<c:choose>
				<c:when test="${pb.nowPage == pageNum }">
					<li class="active"><a class="page-link-active">${pageNum }</a></li>&nbsp;&nbsp;
				</c:when>
				<c:otherwise>
					<li><a class="page-link"
						href="${pageContext.request.contextPath }/front?command=ItemSearch&searchtext=${param.searchtext}&pageNum=${pageNum }">${pageNum }</a></li>&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<!-- NextPage -->
			<c:if test="${pb.nextPageGroup }">
				<li class="page-item"><a class="page-link" 
					href="${pageContext.request.contextPath }/front?command=ItemSearch&searchtext=$${param.searchtext}&pageNum=${pb.endPageOfPageGroup+1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span> <span
					class="sr-only">Next</span>
				</a></li>&nbsp;&nbsp;
			</c:if>
	</ul>
</div>
<!-- /.container -->