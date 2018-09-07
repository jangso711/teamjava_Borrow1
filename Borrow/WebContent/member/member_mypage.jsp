<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.bgheader {
	height: 50px;
}
.mypagecontent{
	margin-top:80px;
	margin-bottom:80px;
	margin-left:auto;
	margin-right:auto;
}
.bg_gr{
 	background-color: #e0e0e0;
 	font-size:30px;
 	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#FFFFFF;
 text-align: center;
}
.bg_gr:hover{
	 background-color: #f6cac9;
	 font-size:30px;
	 font-weight:bold;
	 text-shadow: 0 0 2px #000;
	 color:#FFFFFF;
	  text-align: center;
}
button{
margin-top:30px;	
	margin-left:15px;
	margin-right: 40px;
}
</style>
<div class="col-sm-12 mypagecontent" align="center">
    <button type="button" class="btn bg_gr" style="WIDTH: 150pt; HEIGHT: 150pt;" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterAllList&memberId=${sessionScope.user.id}'" >등록 물품</button>
    <button type="button" class="btn bg_gr" style="WIDTH: 150pt; HEIGHT: 150pt;" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterList&nowPage=1'">빌려준 목록</button>
    <button type="button" class="btn bg_gr" style="WIDTH: 150pt; HEIGHT: 150pt;" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRentalList&nowPage=1'">빌린 목록</button><br><br>
    <button type="button" class="btn bg_gr" style="WIDTH: 150pt; HEIGHT: 150pt;" onclick="location.href='${pageContext.request.contextPath}/front?command=MemberDetail'">회원정보</button>
	<button type="button" class="btn bg_gr" style="WIDTH: 150pt; HEIGHT: 150pt;" onclick="location.href='${pageContext.request.contextPath}/front?command=ReviewMyList&pageNo=1'">나의 후기</button> 
</div>