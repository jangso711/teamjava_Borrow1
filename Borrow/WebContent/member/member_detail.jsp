<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
h3 {
	padding-left: 100px;
	padding-top: 30px;
	font-weight: bold;
}
.bgheader {
	height: 160px;
}
.membercontent {
	padding-top: 20px;
	padding-left: 200px;
	padding-bottom: 20px;
}
table{
	font-size: 18px;	
}
td{
width: 75%;
}
tr{
 	border-bottom: 2px solid #e0e0e0;
    border-top: 2px solid #e0e0e0;
}
.btn_center{

} 
.btn_pk{
	 background-color: #f6cac9;
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
			<td>${vo.point}</td>
		</tr>

	</table>
	<br>
	<input class="btn btn_center btn_pk"type="button"value="회원 정보 수정">
	</div>
</div>
