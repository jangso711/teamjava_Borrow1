<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-sm-12 content">
<form action="${pageContext.request.contextPath }/front" method="get">
<input type="hidden"name="command"value="Login">
<input type="text"name="memberId"required="required"placeholder="아이디"><br>
<input type="password"name="memberPwd"required="required"placeholder="비밀번호"><br>
<input type="submit"value="로그인">
</form>
</div>