<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
h3 {

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
	padding-top:80px;
	padding-bottom:80px;
	padding-left:450px;
	text-align:center;
}

table{
	font-size: 18px;	
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$("#findBtn").click(function() {
		//alert("아아아아");
		 $.ajax({
            type : "post",
            url : "${pageContext.request.contextPath}/front",
            data : $("#MemberFindPwdForm").serialize(),
            success : function(result) {
               alert(result);
          		  }//result
				})//ajax 
			})//click
		})//ready 
</script>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12 content">
	<h3>비밀번호 찾기</h3>
	<form method="post" name="MemberFindPwdForm" id="MemberFindPwdForm">
		<input type="hidden" name="command" value="MemberFindPwd">
		<div class="formContent">
			<table cellpadding="3">
				<tr>
					<td><input type="text" name="id" id="id" required="required" placeholder="아이디"></td>
				</tr>
				<tr>
					<td><input type="text" name="name" id="name" required="required" placeholder="이름"></td>
				</tr>
				<tr>
					<td><input type="text" name="tel" id="tel" required="required"placeholder="전화번호"></td>
				</tr>
				<tr>
					<td><input class="btn btn_pk" type="submit" id="findBtn"
						value="비밀번호찾기"></td>
				</tr>
			</table>
		</div>
	</form>
</div>