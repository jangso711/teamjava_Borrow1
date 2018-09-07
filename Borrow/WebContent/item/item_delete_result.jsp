<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
h3 {
    text-align: center;
}

.bgheader {
	height: 50px;
}
 .btn_pk{
   background-color: #f6cac9;
   height:30px;
   margin:10px;   
}
input[type=button]{
   size:50px;
   height:40px;
   width:250px;
   border-radius: 5px;
   padding:5px;
}
.resultContent{
	min-height:450px;
	height:auto;
}
</style>
<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12 resultContent">       
	<h3>삭제 완료</h3>  
	<table align="center">
   	 <tr>
      <td><input class="btn btn_pk" type="button" value="홈" onclick="location.href='${pageContext.request.contextPath}/index.jsp'"></td>
      <td><input class="btn btn_pk" type="button" value="마이페이지" onclick="location.href='${pageContext.request.contextPath}/front?command=MemberMypage'"></td>
   	 </tr>
	</table>	   

  		
</div>


