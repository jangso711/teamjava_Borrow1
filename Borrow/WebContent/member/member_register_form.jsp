<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.bgheader{

	height:160px;
}
</style>
<div class="col-sm-12 bgheader">
</div>
<div class="col-sm-12" align="center">
<form method="post" name="MemberRegisterForm" action="front">
		<input type="hidden" name="command" value="MemberRegister">
		아이디 : <input type="text" name="id" id="id" required="required">		
		<br>패스워드 : <input type="password" name="pwd" id="pwd" required="required">		
		<br>패스워드 확인 : <input type="password" name="repwd" id="repwd" required="required">		
		<br>이름 : <input type="text" name="name" required="required">	
		<br>주소 : <input type="text" name="address" required="required">
		<br>전화번호 : <input type="text" name="tel" required="required" >
		<br><input type="submit" value="회원가입">
		</form>
		</div>