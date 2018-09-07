<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.mypagecontent {
	margin-top: 40px;
	margin-bottom: 80px;
}

h3 {
	padding-left: 600px;
	padding-top: 32px;
	font-weight: bold;
}

.btn_pk {
	background-color: #f6cac9;
	padding-top: 10px;
	padding-bottom: 10px;
}

.btn_pk1 {
	background-color: #f6cac9;
	margin-left: 160px;
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

.formContent {
	padding-top: 10px;
	padding-bottom: 20px;
	padding-left: 450px;
	text-align: center;
}

table {
	border-top: 2px solid #e0e0e0;
	border-bottom: 2px solid #e0e0e0;
	font-size: 18px;
	margin:0 auto;
}

tr {
	border-top: 1px solid #e0e0e0;
	border-bottom: 1px solid #e0e0e0;
}

th,td {
	padding-left: 50px;
	padding-right: 50px;

}
</style>
<h3>회원 정보</h3>
<div class="col-sm-12 mypagecontent">
	<table cellpadding="10">
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
		<tr>
			<td colspan="2"><button type="button" class="btn btn_pk"
					onclick="location.href=
	'${pageContext.request.contextPath}/front?command=MemberUpdateForm'">회원
					정보 수정</button>
				<button type="button" class="btn btn_pk"
					onclick="location.href=
	'${pageContext.request.contextPath}/front?command=MemberDepositPointForm'">포인트
					충전</button>
				<button type="button" class="btn  btn_pk"
					onclick="location.href=
	'${pageContext.request.contextPath}/front?command=MemberWithdrawPointForm&existingPoint=${vo.point}'">포인트
					환급</button></td>
		</tr>
	</table>

</div>

