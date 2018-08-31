<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.bgheader{

	height:160px;
}
</style>
<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div align="center" class="container content">
  <div class="btn-group">
  <button type="button" class="btn btn-primary btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterForm'">내 물품 등록</button>
    <button type="button" class="btn btn-primary btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRegisterList'">내 등록 물품</button>
    <button type="button" class="btn btn-primary btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=ItemRentalList'">내 대여 목록</button>
    <button type="button" class="btn btn-primary btn-lg" style="WIDTH: 150pt; HEIGHT: 150pt" onclick="location.href='${pageContext.request.contextPath}/front?command=MemberDetail'">회원정보</button>
  </div>
</div><br>