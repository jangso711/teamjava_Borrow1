<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.btn_pk {
	background-color: #f6cac9;
	height: 45px;
	margin: 10px;
	
}
h3{
	
	padding-top: 140px;
	font-weight: bold;
	text-align:center;
	font-weight:bold;
 	text-shadow: 0 0 2px #000;
 	color:#A9D0F5;

}

.bgheader {
	height: 80px;
}
.bgfooter {
	height: 80px;
}
</style>

<script type="text/javascript">
function sendList(){
	location.href="${pageContext.request.contextPath}/index.jsp";
}
function deletePost(){
	if(confirm("게시글을 삭제하시겠습니까?")){
		document.deleteForm.submit();
	}
}
function updatePost(){
	if(confirm("게시글을 수정하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/front?command=UpdatePostForm&no=${requestScope.pvo.no}";
	}
}
</script>
<div class="col-sm-12 bgheader"></div>
	<table class="table">
		<tr >
			<td>글번호 ${requestScope.rvo.reviewNo}</td>
			<td>제목: ${requestScope.rvo.reviewTitle} </td>
			<td>작성자 :  ${requestScope.rvo.memberVO.name}</td>
			<td>조회수 : ${requestScope.rvo.reviewHit}</td>
			<td>${requestScope.rvo.reviewRegdate}</td>
		</tr>		
		<tr>
			<td colspan="5" >
			<pre>${requestScope.rvo.reviewContent}</pre>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="btnArea">
			 <c:if test="${requestScope.rvo.memberVO.id==sessionScope.user.id}">
			 <form name="deleteForm" action="${pageContext.request.contextPath}/front" method="post">
			 	<input type="hidden" name="command" value="DeletePost">
			 	<input type="hidden" name="no" value="${requestScope.rvo.reviewNo}">
			 </form>
			 <button type="button" class="btn" onclick="deletePost()">삭제</button>
			 <button type="button" class="btn" onclick="updatePost()">수정</button>
			 </c:if>
			 </td>
		</tr>
	</table>
	
	
	
	
	
	
	
	