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
		<a href="${pageContext.request.contextPath }/front?command=LoginForm">LOGIN</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=MemberRegisterForm">JOINUS</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=FAQ">FAQ</a>&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ReviewList&pageNo=1">REVIEW</a>&nbsp;&nbsp;
	
</c:when>
	<c:otherwise>
		<a href="${pageContext.request.contextPath }/front?command=Logout">LOGOUT</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=MemberMypage">MYPAGE</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=FAQ">FAQ</a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath }/front?command=ReviewList&pageNo=1">REVIEW</a>&nbsp;&nbsp;


</c:otherwise>
</c:choose>

</div>
