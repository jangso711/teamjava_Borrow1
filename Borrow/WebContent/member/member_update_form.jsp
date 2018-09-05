<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
h3 {
	padding-left: 450px;
	padding-top: 55px;
	font-weight: bold;
}
.btn_pk{
	 background-color: #f6cac9;
	 padding-top: 10px;
	 padding-bottom: 10px;
	 }
.btn_pk1{
	 background-color: #f6cac9;
	 margin-left:160px;
	  padding-top: 10px;
	 padding-bottom: 10px;
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


.formContent{
	padding-top:10px;
	padding-bottom:20px;
	padding-left:450px;
	text-align:center;
}

table{
	font-size: 18px;	
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
		<td> <input type="text" name="id" value="아이디 : ${sessionScope.user.id}"readonly="readonly"></td>
		</tr>
		<tr>
		<td><input type="password" name="pwd" id="pwd" required="required" placeholder="비밀번호"></td>
		</tr>
		 <tr>
		 <td><input type="password" name="repwd" id="repwd" required="required"placeholder="비밀번호확인"></td><td><span id="pwdcheckResult"></span></td>
		 </tr>
		<tr>
		<td><input type="text" name="name" required="required" placeholder="이름"></td>
		</tr>
		<tr>
		<td><input type="text" name="address" required="required" placeholder="주소"></td>
		</tr>
		<tr>
		<td><input type="text" name="tel" required="required" placeholder="전화번호"></td>
		</tr>
		<tr>
		<td><input class="btn btn_pk" type="submit" id="updateBtn" value="정보수정"></td>
		</tr>
		</table>
		</div>
	</form>
</div>