<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
h1 {
    color: #08088A;
    text-align: center;
}
table{
	text-align: center;
}
.bgheader{

	height:160px;
}
th {
    background-color: #F5A9BC;
    text-align: center;
  }
td {
    background-color: #868A08;
    text-align: center;
    }
</style>
<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-4 container">       
		<h1>회원 정보 상세 보기</h1>     
  		<table class="table table-bordered" >
			<tr>
				<th>아이디</th><td>${vo.id}</td>
			</tr>
			<tr>
				<th>이름</th><td>${vo.name}</td>
			</tr>
			<tr>
				<th>주소</th><td>${vo.address}</td>
			</tr>
			<tr>
				<th>전화번호</th><td>${vo.tel}</td>
			</tr>
			<tr>
				<th>잔여 포인트</th><td><pre>${vo.point}</pre></td>
			</tr>
		</table>
		</div>
