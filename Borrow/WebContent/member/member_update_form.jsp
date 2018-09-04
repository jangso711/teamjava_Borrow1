<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
h3 {
	padding-left: 100px;
	/* padding-top: 30px; */
	font-weight: bold;
}

.btn_pk {
	background-color: #f6cac9;
	height: 40px;
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
	width: 400px;
	border-radius: 5px;
	padding: 5px;
}

input[type=password] {
	size: 50px;
	height: 40px;
	width: 400px;
	border-radius: 5px;
	padding: 5px;
}
.bgheader {
	height: 50px;
}

.formContent {
	padding-top: 20px;
	padding-left: 200px;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#repwd").keyup(
						function() {//비밀번호 확인
							if ($("#repwd").val() != $("#pwd").val()) {
								$("#pwdcheckResult").html("비밀번호 불일치").css(
										"color", "red");
							} else {
								$("#pwdcheckResult").html("비밀번호 일치").css(
										"color", "blue");
							}//else
						});//keyup
				$("#updateBtn").click(
						alert("update");
						function() {//비밀번호 오류시 회원정보 수정 실패
							if ($("#pwdcheckResult").text() == "비밀번호 불일치") {
								alert('비밀번호를 확인하세요');
								return false;
							}//if
						})//registerBtn 
			})//ready
</script>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12 content">
<h3>회원 정보 수정</h3>
	<form method="post" name="MemberUpdateForm" id="MemberUpdateForm" action="${pageContext.request.contextPath }/front">
		<input type="hidden" name="command" value="MemberUpdate"> 
		<div class="formContent">
		<table cellpadding="3">
		<tr> 
		<td>아이디</td><td> <input type="text" name="id" value="${sessionScope.user.id}"readonly="readonly"></td>
		</tr>
		<tr> 
		<td>패스워드</td><td> <input type="password" name="pwd" id="pwd" required="required"></td>
		</tr>
		<tr>
		<tr>
		<td>패스워드확인</td><td> <input type="password" name="repwd" id="repwd" required="required"></td><td><span id="pwdcheckResult"></span></td>
		</tr>
		<tr>
		<td>이름</td><td><input type="text" name="name" required="required"></td>
		</tr>
		<tr>
		<td>주소</td><td><input type="text" name="address" required="required"></td>
		</tr>
		<tr>
		<td>전화번호</td><td><input type="text" name="tel" required="required"></td>
		</tr>
		<tr>
		<td></td><td><input class="btn btn_pk" type="submit" id="updateBtn" value="정보수정"></td>
		</tr>
		</table>
		</div>
	</form>
</div>