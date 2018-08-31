<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3{
	padding-left:100px;
	padding-top:30px;
	font-weight: bold;
}
input[type=text]{
	size:50px;
	height:40px;
	width:250px;
	border-radius: 5px;
	padding:5px;
}
input[type=number]{
	size:50px;
	height:40px;
	width:250px;
	border-radius: 5px;
	padding:5px;
}
.formContent{
	padding-top:20px;
	padding-left:200px;
	text-align:center;
}
.bgheader{

	height:160px;
}
</style>
<div class="col-sm-12 bgheader">
</div>
<div class="col-sm-12 content">
<h3>전체 상품 목록</h3>
	<form>
		<table class="table">
			<thead>
				<tr>
					<th> </th><th>이름</th><th>설명</th><th>가격</th><th>아이디</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${requestScope.pictureList }" var="pictureList">
				<c:set value="${pageContext.request.contextPath }/front?command=ItemDetail&itemSearchId=${pictureList.itemVO.itemNo}" 
					var="detailurl"></c:set>
					<tr>
						<td><a href="${detailurl }">
							<img src="${pageContext.request.contextPath }/upload/${pictureList.picturePath}" width="150" height="150"></a></td>
						<td><a href="${detailurl }">${pictureList.itemVO.itemName }(링크)</a></td>
						<td><pre>${pictureList.itemVO.itemExpl }</pre></td>
						<td>${pictureList.itemVO.itemPrice }</td>
						<td>${pictureList.itemVO.memberVO.id }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>