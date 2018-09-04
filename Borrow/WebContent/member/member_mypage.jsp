<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.bgheader{

	height:100px;
}
.mypagecontent{
	margin-top:170px;
	margin-bottom:30px;
	margin-left:auto;
	margin-right:auto;
}
.bg_gr{
 	background-color: #e0e0e0;
 	font-size:20px;
 	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#FFFFFF;
}
.bg_gr:hover{
	 background-color: #f6cac9;
	 font-size:20px;
	 font-weight:bold;
	 text-shadow: 0 0 2px #000;
	 color:#FFFFFF;
}
</style>
<br>
<br>
<br>
<br>

<div class="col-sm-4 mypagecontent" align="right">
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 130pt; HEIGHT: 130pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterAllList'" >나의 등록 물품</button><br><br><br><br>
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 130pt; HEIGHT: 130pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterList'">나의 대여 목록</button>
   </div>
   <div class="col-sm-4 mypagecontent" align="left">
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 130pt; HEIGHT: 130pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRentalList'">내가 대여한 목록</button><br><br><br><br>
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 130pt; HEIGHT: 130pt" onclick="location.href='${pageContext.request.contextPath}/front?command=MemberDetail'">회원정보</button>
</div>

