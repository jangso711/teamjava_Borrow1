<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link
	href="${pageContext.request.contextPath }/template/search/css/style.css"
	rel="stylesheet">
<c:choose>
	<c:when test="${requestScope.url=='/main.jsp'}">
		<div class="col-sm-12 mainheader">
			<a href="${pageContext.request.contextPath }/front?command=Main"><img
				id="logo" src="${pageContext.request.contextPath }/img/logo.png"
				width="300" height="110" alt="Logo"></a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="col-sm-3 header" align="center">
			<form action="${pageContext.request.contextPath}/front">
				<a href="${pageContext.request.contextPath }/front?command=Main">
				<img id="logo_block" src="${pageContext.request.contextPath }/img/logo_block.png" alt="Logo"></a>
		</div>
		<div class="col-sm-9 header">
	 		<!-- 180907 MIRI 검색창 CSS로 변경 -->
			<div class="search__container">
				<input type="hidden" name="command" value="ItemSearch">
				<input class="search__input_header" type="text" name="searchtext" placeholder="Search">
			</div>
			</form>
		</div>
	</c:otherwise>
</c:choose>
