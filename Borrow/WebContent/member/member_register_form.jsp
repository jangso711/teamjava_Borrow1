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
<script type="text/javascript">
					$(document).ready(function() {
						$("#id").keyup(function(){//아이디 중복확인
							$("#id").text("");
							var le=$(this).val();
							if(le.length<4||le.length>10){
								$("#idCheckResult").html("아이디는 4자이상 10자이하만 가능").css("color", "red");
							}else{
								$.ajax({
									type:"post",
									url:"${pageContext.request.contextPath}/front",
									data:"command=MemberIdCheck&id="+$("#id").val(),
									success:function(result){		
										if(result=="ok"){
											$("#idCheckResult").html("사용 가능").css("color", "blue");
										}else{
											$("#idCheckResult").html("아이디가 중복 되어 사용 불가").css("color", "red");											
										}//else
											/*  $("#registerBtn").click(function() {
												if(result=="fail"){
													$("#idcheckBtn").html("아이디를 확인하세요").css("color", "red");
													return false; 
												}//if
											}) //click  */
					
						$("#pwd").keyup(function() {//비밀번호 확인
							$("#pwd").text("");
						});//keyup
						$("#repwd").keyup(function() {
							if($("#repwd").val()!=$("#pwd").val()){							
							$("#pwdcheckResult").html("비밀번호 불일치").css("color", "red");
							}else{
							$("#pwdcheckResult").html("비밀번호 일치").css("color", "blue");
						}//else
						});//keyup
						 $("#registerBtn").click(function(){//비밀번호 오류시 회원가입 실패
							if($("#repwd").val()!=$("#pwd").val()||result!="ok"){
								$("#checkBtn").html("아이디 또는 비밀번호를 확인하세요").css("color", "red");
							return false;		
							}//if
						})//registerBtn 
									}//result
								})//ajax
							}//else		
						})//keyup
				})//ready
				</script>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12" align="center">
<h3>회원가입</h3>
	<form method="post" name="MemberRegisterForm" id="MemberRegisterForm"
		action="front">
		<input type="hidden" name="command" value="MemberRegister">
		아이디<br>
		<input type="text" name="id" id="id" required="required"><br>
		<span id="idCheckResult"></span> <br>
		<br>패스워드<br>
		<input type="password" name="pwd" id="pwd" required="required">
		<br>
		<br>패스워드 확인<br>
		<input type="password" name="repwd" id="repwd" required="required"><br>
		<span id="pwdcheckResult"></span> <br>
		<br>이름<br>
		<input type="text" name="name" required="required"> <br>
		<br>주소<br>
		<input type="text" name="address" required="required"> <br>
		<br>전화번호<br>
		<input type="text" name="tel" required="required" width=80px;>
		<br>
		<br>
		<input type="submit" value="회원가입" id="registerBtn"><br> 
		<span id="checkBtn"></span>
	</form>
</div>