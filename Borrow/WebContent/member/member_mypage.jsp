<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.bgheader {
	height: 50px;
}
.mypagecontent{
	margin-top:100px;
	margin-bottom:100px;
	margin-left:auto;
	margin-right:auto;
}
.bg_gr{
 	background-color: #e0e0e0;
 	font-size:25px;
 	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#FFFFFF;
}
.bg_gr:hover{
	 background-color: #f6cac9;
	 font-size:25px;
	 font-weight:bold;
	 text-shadow: 0 0 2px #000;
	 color:#FFFFFF;
}
</style>
<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div align="center" class=" mypagecontent">

  <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterForm'">물품 등록하기</button>
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterAllList&memberId=${sessionScope.user.id}'" >등록 물품 목록</button>
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterList'">빌려준 내역</button>
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRentalList'">물품 대여 목록</button>
    <button type="button" class="btn bg_gr btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=MemberDetail'">회원정보</button>

</div>
