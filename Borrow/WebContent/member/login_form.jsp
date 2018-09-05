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
   
   min-height: 300px;
   text-align:center;
   padding-top:115px;
   padding-bottom:103px;
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
/* .bgheader {
	height: 50px;
} */
</style>
<%-- 로그인 실패  alert 추가 --%>
<<script type="text/javascript">
	$(document).ready(function(){
		$("#loginCheck").click(function(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/front",
				data:"command=Login&memberId="+$("#id").val()+"&memberPwd="+$("#pass").val(),
				success:function(result){
					if(result=="ok"){
						location.href="index.jsp";
					}else{
						alert("로그인 실패");
					}
				}
				
			})
		})//click
	})//ready
</script>

<div class="col-sm-12 bgheader">
</div>
<div class="col-sm-12 logincontent">
<%--<form action="${pageContext.request.contextPath }/front"method="post"> --%>
<table align="center" cellpadding="3">
   <tr>
      <td>아이디</td><td><input type="text"name="memberId" required="required" id="id"></td>
      <td rowspan="2"><input class="btn btn_pk"type="submit"value="로그인" id="loginCheck"></td>
   </tr>
   <tr>
      <td>비밀번호</td><td><input type="password"name="memberPwd" required="required" id="pass"></td>
   </tr>
</table>
<input type="hidden"name="command"value="Login">
<%--</form>--%>
<br>
<a style="color:#ff99cc;font-weight: 900;"href="${pageContext.request.contextPath }/front?command=MemberRegisterForm">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a style="color:#ff99cc;font-weight: 900; "href="${pageContext.request.contextPath }/front?command=MemberFindPwdForm">비밀번호를 잊으셨습니까?</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</div>