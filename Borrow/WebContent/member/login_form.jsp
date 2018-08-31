<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.btn_pk{
   background-color: #f6cac9;
   height:70px;
   margin:10px;   
}

.logincontent{
   margin-top:160px;
   min-height: 300px;
   text-align:center;
   padding-top:120px;
   padding-bottom:120px;
}
input[type=text]{
   size:50px;
   height:40px;
   width:250px;
   border-radius: 5px;
   padding:5px;
}input[type=password]{
   size:50px;
   height:40px;
   width:250px;
   border-radius: 5px;
   padding:5px;
}

</style>
<div class="col-sm-12 logincontent">
<form action="${pageContext.request.contextPath }/front"method="post">
<table align="center" cellpadding="3">
   <tr>
      <td>아이디</td><td><input type="text"name="memberId"required="required"></td><td rowspan="2"><input class="btn btn_pk"type="submit"value="로그인"></td>
   </tr>
   <tr>
      <td>비밀번호</td><td><input type="password"name="memberPwd"required="required"></td>
   </tr>
</table>
<input type="hidden"name="command"value="Login">
</form>
<br>
<a style="color:#f6cac9"href="${pageContext.request.contextPath }/front?command=RegisterForm">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="">비밀번호를 잊으셨습니까?</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>