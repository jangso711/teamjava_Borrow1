<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).ready(function(){
		$("#withdrawForm").submit(function(){
			if($("#point").val()<1000){
				alert("1000포인트 이상부터 환급 가능합니다.");
				return false;
			}else if($("#point").val()>${requestScope.existingPoint}){
				alert("포인트가 부족합니다.")	;
				return false;
			}else{
				alert("포인트 환급이 완료되었습니다.");
			}
		});
	});
</script>
<style>
h3 {
	padding-left: 600px;
	padding-top: 53px;
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


.input_text[type=text] {
	size: 50px;
	height: 40px;
	width: 200px;
	border-radius: 5px;
	padding: 5px;
}

.input_pwd[type=password] {
	size: 50px;
	height: 40px;
	width: 200px;
	border-radius: 5px;
	padding: 5px;
}
.input_num[type=number] {
	size: 50px;
	height: 40px;
	width: 200px;
	border-radius: 5px;
	padding: 5px;
}

.formContent{
	padding-top:40px;
	padding-bottom:80px;
	padding-left:480px;
	text-align:center;
}
.tt{
	font-weight: bold;
}

</style>
<div class="col-sm-12 bgheader"></div>
<h3>포인트 환급</h3>
<div class="col-sm-12 formContent">


<form action="front" method="post" id="withdrawForm">
<input type="hidden" name="command" value="MemberWithdrawPoint">
<table>
<tr>
<td class="tt">은행</td><td colspan="2"><input type="text" class="input_text" name="countId" required="required"></td>
</tr>
<tr>
<td class="tt">계좌번호</td><td colspan="2"><input type="number" class="input_num" name="countNo" required="required"></td>
</tr>
<tr>
<td class="tt">계좌주명</td><td colspan="2"><input type="text" class="input_text" name="name" required="required"></td>
</tr>
<tr>
<td class="tt">계좌비밀번호</td><td colspan="2"><input type="password" class="input_pwd" name="countPassword" required="required"></td>
</tr>
<tr>
<td class="tt">환급 받을 금액</td><td colspan="2"><input type="number" class="input_num" pattern="[0-9]+([,\.][0-9]+)?" name="point" id="point" required="required"></td>
</tr>
<tr>
<td></td><td><button type="submit" class="btn btn_center btn_pk" id="submitBtn">환급받기</button></td>
</tr>
</table>
</form>
</div>