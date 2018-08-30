<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-sm-12 maincontent"align="center" >
<form action="${pageContext.request.contextPath}/front">
 <input type="hidden" name="command" value="ItemSearch">
 <input type="text" name="searchtext" placeholder="Search..." style="width:700px; height:50px; letter-spacing: 2px" />
</form>
<br><br><br>
<a href=""><img id="wintersports" height="150" width="150" 
src="${pageContext.request.contextPath }/img/겨울스포츠.png" alt="겨스"></a>
<a href=""><img id="swim" height="150" width="150" 
src="${pageContext.request.contextPath }/img/수영.png" alt="수영"></a>
<a href=""><img id="outdoor" height="150" width="150" 
src="${pageContext.request.contextPath }/img/야외스포츠.png" alt="야외"></a>
<a href=""><img id="fishing" height="150" width="150" 
src="${pageContext.request.contextPath }/img/낚시.png" alt="낚시"></a><br><br>
<a href=""><img id="climb" height="150" width="150" 
src="${pageContext.request.contextPath }/img/등산.png" alt="등산"></a>
<a href=""><img id="camping" height="150" width="150" 
src="${pageContext.request.contextPath }/img/캠핑.png" alt="캠핑"></a>
<a href=""><img id="baby" height="150" width="150" 
src="${pageContext.request.contextPath }/img/유아.png" alt="유아"></a>
<a href=""><img id="all" height="150" width="150" 
src="${pageContext.request.contextPath }/img/전체.png" alt="전체"></a>
</div>
