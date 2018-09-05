<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 

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
	<a href="${pageContext.request.contextPath }/front?command=MemberRegisterForm">Join Us</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=FAQ">FAQ</a>&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ReviewList&pageNo=1">Review</a>&nbsp;&nbsp;
</c:when>
	<c:otherwise>
		<a href="${pageContext.request.contextPath }/front?command=Logout">Logout</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=MemberMypage">MyPage</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=FAQ">FAQ</a>&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ItemRegisterForm">register</a>&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ReviewList&pageNo=1">Review</a>&nbsp;&nbsp;

</c:otherwise>
</c:choose>

</div>
