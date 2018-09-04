
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
h3 {
	padding-left: 400px;
	padding-top: 40px;
	font-weight: bold;
}
.bgheader {
	height: 160px;
}
.membercontent {
	padding-top: 20px;
	padding-left: 400px;
	padding-bottom: 40px;
}
table{
	font-size: 18px;	
}
td{
width: 75%;

}
tr{
border: ="none"
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

</style>
<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12 ">
	<h3>회원 정보</h3>
	<div class="membercontent">
	  <table cellpadding="15">
	
	
		<tr>
			<th>아이디</th>
			<td>${vo.id}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${vo.name}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${vo.address}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${vo.tel}</td>
		</tr>
		<tr>
			<th>잔여 포인트</th>
			<td><fmt:formatNumber>${vo.point}</fmt:formatNumber></td>
		</tr>
		</table>
		<br>
		<button type="button" class="btn btn_pk1" onclick="location.href=
	'${pageContext.request.contextPath}/front?command=MemberUpdateForm'">회원 정보 수정</button>		
		<button type="button" class="btn btn_pk" onclick="location.href=
	'${pageContext.request.contextPath}/front?command=MemberDepositPointForm'">포인트 충전</button>		
		<button type="button" class="btn  btn_pk" onclick="location.href=
	'${pageContext.request.contextPath}/front?command=MemberWithdrawPointForm&existingPoint=${vo.point}'">포인트 환급</button>
		 
	
	</div>
</div>
