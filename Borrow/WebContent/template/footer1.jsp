<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${requestScope.url=='/main.jsp'}">
	<div class="col-sm-12 mainfooter">
	footer
	</div>
	</c:when>
	<c:otherwise>
	<div class="col-sm-12 footer">
	footer
	</div>
	</c:otherwise>
</c:choose>
