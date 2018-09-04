<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${requestScope.url=='/main.jsp'}">
	<div class="col-sm-12 mainheader">
	<a href="${pageContext.request.contextPath }/front?command=Main"><img id="logo"src="${pageContext.request.contextPath }/img/logo.png"  width="300" height="110" alt="Logo"></a>
	</div>
	</c:when>
	<c:otherwise>
	<div class="col-sm-12 header">
	<a href="${pageContext.request.contextPath }/front?command=Main"><img id="logo_block"src="${pageContext.request.contextPath }/img/logo_block.png" alt="Logo"></a>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3004"><img id="wintersports"
		height="100" width="100" src="${pageContext.request.contextPath }/img/겨울스포츠.png" alt="겨스"></a>
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3002"><img id="swim" height="100" width="100"
		src="${pageContext.request.contextPath }/img/수영.png" alt="수영"></a> <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3006"><img id="outdoor" height="100" width="100"
		src="${pageContext.request.contextPath }/img/야외스포츠.png" alt="야외"></a>
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3005"><img id="fishing" height="100" width="100"
		src="${pageContext.request.contextPath }/img/낚시.png" alt="낚시"></a>
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3001"><img id="climb" height="100" width="100"
		src="${pageContext.request.contextPath }/img/등산.png" alt="등산"></a> <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3003"><img id="camping" height="100" width="100"
		src="${pageContext.request.contextPath }/img/캠핑.png" alt="캠핑"></a> <a
		href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3007"><img id="baby" height="100" width="100"
		src="${pageContext.request.contextPath }/img/유아.png" alt="유아"></a> <a
		href="${pageContext.request.contextPath }/front?command=ItemAllSearch"><img id="all" height="100" width="100"
		src="${pageContext.request.contextPath }/img/전체.png" alt="전체"></a>

	</div>
	</c:otherwise>
</c:choose>
