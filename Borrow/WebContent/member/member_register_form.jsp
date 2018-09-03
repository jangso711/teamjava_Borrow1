<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>

h3{
	padding-left:100px;
	padding-top:30px;
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
	height: 160px;
}
.formContent{
	padding-top:20px;
	padding-left:200px;
	text-align:center;
}
</style>
<script type="text/javascript">

					$(document).ready(function() {
						$("#id").keyup(function(){//아이디 중복확인
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
									}//result
								})//ajax
							}//else		
						})//keyup
						$("#repwd").keyup(function() {//비밀번호 확인
							if($("#repwd").val()!=$("#pwd").val()){							
							$("#pwdcheckResult").html("비밀번호 불일치").css("color", "red");
							}else{
							$("#pwdcheckResult").html("비밀번호 일치").css("color", "blue");
						}//else
						});//keyup
						 $("#registerBtn").click(function(){//비밀번호,아이디 오류시 회원가입 실패
							 if($("#pwdcheckResult").text()=="비밀번호 불일치"||$("#idCheckResult").text()!="사용 가능"){            
						            alert('아이디 또는 비밀번호를 확인하세요');
									return false;								
									}//if
								})//registerBtn 
							})//ready
				</script>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12 content">
<h3>회원가입</h3>
	<form method="post" name="MemberRegisterForm" id="MemberRegisterForm"
		action="front">
		<input type="hidden" name="command" value="MemberRegister">
		<div class="formContent">
		<table cellpadding="3">
		<tr>
		<td>아이디</td><td><input type="text" name="id" id="id" required="required"></td><td><span id="idCheckResult"></span></td>
		</tr>
		<tr>
		<td>비밀번호</td><td><input type="password" name="pwd" id="pwd" required="required"></td>
		</tr>
		 <tr>
		 <td>비밀번호 확인</td><td><input type="password" name="repwd" id="repwd" required="required"></td><td><span id="pwdcheckResult"></span></td>
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
		<td></td><td><input class="btn btn_pk" type="submit" value="회원가입" id="registerBtn"></td>
		</tr>
		</table>
		</div> 
	</form>

</div>