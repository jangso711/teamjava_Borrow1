<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-sm-12 maincontent" align="center">
	<form action="${pageContext.request.contextPath}/front">
 		<!-- 180907 MIRI 검색창 CSS로 변경 -->
		<div class="search_container_main" align="left">
			<input type="hidden" name="command" value="ItemSearch">
			<input class="search__input" type="text" name="searchtext" placeholder="Search"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<img alt="상품등록" src="${pageContext.request.contextPath }/img/등버.png" id="registerBtn">
		</div>
		<!-- <input type="hidden" name="command" value="ItemSearch"> <input
			type="search" name="searchtext" placeholder="Search.."
			style="width: 550px; height: 35px; letter-spacing: 2px; margin-bottom: 5px; border-radius: 10px;"/> -->
			<script type="text/javascript">
			
			$(document).ready(function() {
				$("#registerBtn").click(function() {
					<c:choose>
					<c:when test="${empty sessionScope.user }">
					alert("로그인 후 사용 가능");					
					location.href="${pageContext.request.contextPath}/front?command=LoginForm";
					</c:when>
					<c:otherwise>
					location.href="${pageContext.request.contextPath}/front?command=ItemRegisterForm";
					</c:otherwise>
					</c:choose>
				})//clicdk
			})//ready
			
			</script>
			<!-- <a href=> -->
	</form>
	<br>
	<!-- 180903 MIRI 카테고리 url 작성 -->
	<!-- 180905 MIRI 카테고리 url 최신 db와 일치하게 수정 -->
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3006"><img id="wintersports"
		height="150" width="150" src="${pageContext.request.contextPath }/img/겨울스포츠.png" alt="겨스"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3002"><img id="swim" height="150" width="150"
		src="${pageContext.request.contextPath }/img/수영.png" alt="수영"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3007"><img id="outdoor" height="150" width="150"
		src="${pageContext.request.contextPath }/img/야외스포츠.png" alt="야외"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3004"><img id="fishing" height="150" width="150"
		src="${pageContext.request.contextPath }/img/낚시.png" alt="낚시"></a><br>
	<br>
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3001"><img id="climb" height="150" width="150"
		src="${pageContext.request.contextPath }/img/등산.png" alt="등산"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3003"><img id="camping" height="150" width="150"
		src="${pageContext.request.contextPath }/img/캠핑.png" alt="캠핑"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3008"><img id="baby" height="150" width="150"
		src="${pageContext.request.contextPath }/img/유아.png" alt="유아"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemAllSearch"><img id="all" height="150" width="150"
		src="${pageContext.request.contextPath }/img/전체.png" alt="전체"></a>
</div>
