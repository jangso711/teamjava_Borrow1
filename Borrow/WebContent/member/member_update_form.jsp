<%@page import="org.kosta.borrow.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.btn_pk {
	background-color: #f6cac9;
	height: 70px;
	margin: 10px;
}

.logincontent {
	min-height: 300px;
	text-align: center;
	padding-top: 120px;
	padding-bottom: 120px;
}

input[type=text] {
	size: 50px;
	height: 40px;
	width: 250px;
	border-radius: 5px;
	padding: 5px;
}

input[type=password] {
	size: 50px;
	height: 40px;
	width: 250px;
	border-radius: 5px;
	padding: 5px;
}

.bgheader {
	height: 160px;
}
</style>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12" align="center">
<form method="post" name="updateMemberForm" id="updateMemberForm"
		action="front">
<input type="hidden" name="command" value="updateMember">
아이디 <input type="text" name="id" id="id" value="${vo.id }"readonly="readonly"><br>
패스워드 <input type="password" name="pwd" id="pwd" required="required"><br>
패스워드확인 <input type="password" name="repwd" id="repwd" required="required"><br>
이름 <input type="text" name="name" required="required"><br>
주소 <input type="text" name="address" required="required"><br>
전화번호 <input type="text" name="tel" required="required"><br>
<input type="submit" value="수정">
</form>
		</div>