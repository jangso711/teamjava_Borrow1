<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>


h1 {
    color: black;
    text-align: center;
}
table{
	text-align: center;
}
</style>
</head>
<body>
<div class="container content">       
		<h1>회원 정보 상세 보기</h1>     
  		<table class="table table-hover" >
			<tr>
				<td>아이디</td><td>${vo.id}</td>
			</tr>
			<tr>
				<td>이름</td><td>${vo.name}</td>
			</tr>
			<tr>
				<td>주소</td><td>${vo.address}</td>
			</tr>
			<tr>
				<td>전화번호</td><td>${vo.tel}</td>
			</tr>
			<tr>
				<td>잔여 포인트</td><td><pre>${vo.point}</pre></td>
			</tr>
		</table>
		</div>
