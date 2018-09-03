<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#submitBtn").click(function(){
			if($("#point").val()>=1000){
			alert("포인트 환급이 완료되었습니다.");
			}else{
			alert("1000포인트 이상부터 환급 가능합니다.");
			}
		});
		
		$("#withdrawForm").submit(function(){
			if($("#point").val()<=0){				
				return false;
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
	
	padding-top: 100px;
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

.bgheader {
	height: 160px;
}
.bgfooter {
	height: 120px;
}
</style>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12" align="center">
<h3>포인트 환급</h3>

<form action="front" method="post" id="withdrawForm">
<input type="hidden" name="command" value="MemberWithdrawPoint">
<input type="number" name="point" id="point" required="required">
<button type="submit" class="btn btn_center btn_pk" id="submitBtn">환급받기</button>
</form>
</div>
<div class="col-sm-12 bgfooter"></div>