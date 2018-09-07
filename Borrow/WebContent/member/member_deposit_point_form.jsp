<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#chargeForm").submit(function(){
			if($("#point").val()<1000){
				alert("1000포인트 이상부터 충전 가능합니다.");
				return false;
			}else{
				alert("포인트 충전이 완료되었습니다.");
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


input[type=text] {
	size: 50px;
	height: 40px;
	width: 200px;
	border-radius: 5px;
	padding: 5px;
}

input[type=password] {
	size: 50px;
	height: 40px;
	width: 200px;
	border-radius: 5px;
	padding: 5px;
}
input[type=number] {
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
<h3>포인트 충전</h3>
<div class="col-sm-12 formContent" >


<form action="front" method="post" id="chargeForm">
<input type="hidden" name="command" value="MemberDepositPoint">
<table>
<tr>
<td class="tt">은행</td><td colspan="2"><input type="text" name="countId" required="required"></td>
</tr>
<tr>
<td class="tt">계좌번호</td><td colspan="2"><input type="number" name="countNo" required="required"></td>
</tr>
<tr>
<td class="tt">계좌주명</td><td colspan="2"><input type="text" name="name" required="required"></td>
</tr>
<tr>
<td class="tt">계좌비밀번호</td><td colspan="2"><input type="password" name="countPassword" required="required"></td>
</tr>
<tr>
<td class="tt">충전 금액</td><td colspan="2"><input type="number" pattern="[0-9]+([,\.][0-9]+)?" id="point" name="point" required="required"></td>
</tr>
<tr>
<td></td><td><button type="submit" class="btn btn_center btn_pk" id="submitBtn">충전하기</button></td>
</tr>
</table>
</form>
</div>