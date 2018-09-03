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
<h3>포인트 충전</h3>

<form action="front" method="post">
<input type="hidden" name="command" value="MemberPointCharge">
<input type="number" name="point">
<input type="submit" value="충전하기">
</form>
</div>