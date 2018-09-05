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
.btn_pk {
	background-color: #f6cac9;
	height: 45px;
	margin: 10px;
	
}
h3{
	
	padding-top: 50px;
	font-weight: bold;
	text-align:center;
	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#A9D0F5;

}

input[type=number] {
	size: 50px;
	height: 40px;
	width: 250px;
	border-radius: 5px;
}
input[type=text] {
	size: 50px;
	height: 40px;
	width: 250px;
	border-radius: 5px;
}
input[type=password] {
	size: 50px;
	height: 40px;
	width: 250px;
	border-radius: 5px;
}
.bgheader {
	height: 50px;
}
.bgfooter {
	height: 100px;
}
</style>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12" align="center">
<h3>포인트 환급</h3>

<form action="front" method="post" id="withdrawForm">
<input type="hidden" name="command" value="MemberWithdrawPoint">
<table>
<tr>
<td>은행</td><td colspan="2"><input type="text" name="countId" required="required"></td>
</tr>
<tr>
<td>계좌번호</td><td colspan="2"><input type="number" name="countNo" required="required"></td>
</tr>
<tr>
<td>계좌주명</td><td colspan="2"><input type="text" name="name" required="required"></td>
</tr>
<tr>
<td>계좌비밀번호</td><td colspan="2"><input type="password" name="countPassword" required="required"></td>
</tr>
<tr>
<td>환급 받을 금액</td><td colspan="2"><input type="number" pattern="[0-9]+([,\.][0-9]+)?" name="point" id="point" required="required"></td>
</tr>
</table>
<button type="submit" class="btn btn_center btn_pk" id="submitBtn">환급받기</button>
</form>
</div>
<div class="col-sm-12 bgfooter"></div>