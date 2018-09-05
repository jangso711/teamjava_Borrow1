<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-sm-12 maincontent" align="center">
	<form action="${pageContext.request.contextPath}/front">
		<input type="hidden" name="command" value="ItemSearch"> <input
			type="text" name="searchtext" placeholder="Search..."
			style="width: 425px; height: 35px; letter-spacing: 2px; margin-bottom: 9px;"/>
			<a href="${pageContext.request.contextPath}/front?command=ItemRegisterForm"><img alt="상품등록" src="${pageContext.request.contextPath }/img/등버.png" id="registerBtn"></a>
			<script type="text/javascript">
			<c:choose>
			<c:when test="${empty sessionScope.user }">
			$(document).ready(function() {
				$("#registerBtn").click(function() {
					alert("로그인 후 사용 가능");
					return false;
				})//clicdk
			})//ready
			</c:when>
			</c:choose>
			</script>
	</form>
	
	<!-- 180903 MIRI 카테고리 url 작성 -->
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3006"><img id="wintersports"
		height="110" width="110" src="${pageContext.request.contextPath }/img/겨울스포츠.png" alt="겨스"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3002"><img id="swim" height="110" width="110"
		src="${pageContext.request.contextPath }/img/수영.png" alt="수영"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3007"><img id="outdoor" height="110" width="110"
		src="${pageContext.request.contextPath }/img/야외스포츠.png" alt="야외"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3004"><img id="fishing" height="110" width="110"
		src="${pageContext.request.contextPath }/img/낚시.png" alt="낚시"></a><br>
	<br>
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3001"><img id="climb" height="110" width="110"
		src="${pageContext.request.contextPath }/img/등산.png" alt="등산"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3003"><img id="camping" height="110" width="110"
		src="${pageContext.request.contextPath }/img/캠핑.png" alt="캠핑"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3008"><img id="baby" height="110" width="110"
		src="${pageContext.request.contextPath }/img/유아.png" alt="유아"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
		href="${pageContext.request.contextPath }/front?command=ItemAllSearch"><img id="all" height="110" width="110"
		src="${pageContext.request.contextPath }/img/전체.png" alt="전체"></a>
</div>
