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
	</div>
	</c:otherwise>
</c:choose>
