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
 .btn_pk{
   background-color: #f6cac9;
   height:30px;
   margin:10px;   
}
th {
    background-color: #F5A9BC;
    text-align: center;
  }
td {
    text-align: center;
    }
</style>
<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-4 container">       
	<h1>대여 상세 보기</h1>     
  	<table class="table table-bordered" align = "center">
  		<tr>
  			<th rowspan="9"> 사진 </th>
  		</tr>
  		<tr>
			<th>거래번호</th><td>${requestScope.rvo.rentalNo}</td>
		</tr>
		<tr>
			<th>상품명</th><td>${requestScope.rvo.ItemVO.itemName}</td>
		</tr>
		<tr>
			<th>제조사</th><td>${requestScope.rvo.ItemVO.itemBrand}</td>
		</tr>
		<tr>
			<th>모델명</th><td>${requestScope.rvo.ItemVO.itemModel}</td>
		</tr>
		<tr>
			<th>등록자</th><td>${requestScope.rvo.MemberVO.name}</td>
		</tr>
		<tr>
			<th>대여일</th><td>${requestScope.rvo.rentalDate}</td>
		</tr>
		<tr>
			<th>반납일</th><td>${requestScope.rvo.returnDate}</td>
		</tr>
		<tr>
			<th>대여료</th><td>${requestScope.rvo.ItemVO.itemPrice}</td>
		</tr>
	</table>
	<br><br>
	<table align="center">
   	 <tr>
      <td><input class="btn btn_pk" type="button" value="홈" onclick="location.href='${pageContext.request.contextPath}/test.jsp'"></td>
      <td><input class="btn btn_pk" type="button" value="마이페이지" onclick="location.href='${pageContext.request.contextPath}/test.jsp'"></td>
   	 </tr>
	</table>	
</div>
