<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3{
	padding-left:30px;
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
	padding-left:100px;
	text-align:center;
}

</style>
<div class="col-sm-12 content">
<h3>상품등록</h3>
<form action="${pageContext.request.contextPath }/front">
<input type="hidden"name="command"value="ItemRegister">
<div class="formContent">
<table cellpadding="3">
	<tr>
	<td>상품이름</td><td><input type="text"name="itemName"required="required"></td>
	</tr>
	<tr>
	<td>제조사</td><td><input type="text"name="itemBrand"></td>
	</tr>
	<tr>
	<td>모델명(번호)</td><td><input type="text"name="itemModel"></td>
	</tr>
	<tr>
	<td>상품가격</td><td><input type="number"name="itemModel"></td>
	</tr>
	<tr>
	<td>분류선택</td>
	<td >
	<c:forEach items="${requestScope.catList }" var="cat" varStatus="info">
	<input type="checkbox" name="category" value="${cat.catNo }">${cat.catName}
	<c:if test="${info.count%3==0}"><br></c:if>
	</c:forEach>
	</td>
	</tr>
	<tr>
	<td>사진등록</td><td><button class="btn btn_pk"type="button">파일검색</button></td>
	</tr>
	<tr>
	<td></td><td><div id="pictureListView">목록view</div></td>
	</tr>
	<tr>
	<td>상품설명</td><td><textarea cols="50"rows="8"></textarea></td>
	</tr>
	<tr >
	<td></td>
		<td >
		<input class="btn btn_pk"type="submit"value="상품 등록">
		</td>
	</tr>
</table>
</div>
</form>

</div>