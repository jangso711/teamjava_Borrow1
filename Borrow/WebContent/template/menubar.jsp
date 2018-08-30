<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${requestScope.url=='/main.jsp'}">
		<div class="col-sm-12 mainmenubar">
	</c:when>
	<c:otherwise>
		<div class="col-sm-12 menubar">
	</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${empty sessionScope.user }">
	<a href="${pageContext.request.contextPath }/front?command=LoginForm">Login</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="">Join Us</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="">FAQ</a>&nbsp;&nbsp;
</c:when>
<c:otherwise>
	<a href="${pageContext.request.contextPath }/front?command=Logout">Logout</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="">MyPage</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="">FAQ</a>&nbsp;&nbsp;
</c:otherwise>
</c:choose>

</div>
