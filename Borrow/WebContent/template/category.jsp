<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${requestScope.url!='/main.jsp'}">
	<div class="col-sm-12 category">
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3006">겨울스포츠</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3002">물놀이용품</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3007">야외스포츠</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3004">낚시용품</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3001">등산용품</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3003">캠핑용품</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="${pageContext.request.contextPath }/front?command=ItemCategorySearch&categoryNo=3008">유아용품</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemAllSearch">전체보기</a>
	</div>	
	</c:when>
</c:choose>

