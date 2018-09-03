<%@page import="org.kosta.borrow.model.CategoryVO"%>
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
.southContent{
	padding-left:200px;
	padding-bottom:20px;
	
}
.bgheader{

	height:160px;
}
tr{
	border-top: 1px;
	border-bottom: 1px;
}
ul{
	list-style: none;
}
</style>
<script>

	$(document).ready(function(){
		var clist = ${requestScope.clist};
		for(i=0;i<clist.length;i++){
			var cno = clist[i].catNo;
			$("input[type=checkbox][value="+cno+"]").prop("checked",true);
		}
		
		$("#imgBtn").change(function(){
			var form = $('#uploadForm')[0];
			var data = new FormData(form);
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/front",
				data:data,
				dataType:"json",
				enctype: 'multipart/form-data',
				processData: false,
		        contentType: false,
		        cache: false,
				success:function(result){
					$("#pictureList").append("<li>"+result.orgName+"<input type='hidden'name='pics'value="+result.fileName+
					"><button class='deleteBtn'>x</button></li>");
					$("#imgBtn").val("");
					$("#picAlert").text("")
				}
			});
		});
		$("#pictureList").on("click","button",function(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/front",
				data:"command=DeleteServerPicture&fileName="+$(this).parent().find(":hidden").val(),
			});
			$(this).parent().remove();
		});
		$("#updateBtn").click(function(){
			$("#catAlert").text("")
			var cats = $(".category:checkbox:checked");
			var pics = $("#pictureList li").length;
			
			if(cats.length==0){
				$("#catAlert").text("*카테고리를 1개 이상 선택해주세요.").css("color","red");
				return false;
			}
			if(pics==0){
				$("#picAlert").text("*사진을 1장 이상 등록해주세요.").css("color", "red");
				return false;
			}
			$("#updateForm").submit();
			
		});
		
	});
	
</script>
<div class="col-sm-12 bgheader">
</div>
<div class="col-sm-12 content">
<h3>상품등록</h3>
<div class="formContent">
<form id="updateForm"action="${pageContext.request.contextPath }/front"method="post"enctype="multipart/form-data">
<input type="hidden"name="command"value="ItemUpdate">
<table cellpadding="3">
	<c:set value="${requestScope.itemInfo}" var="i"></c:set>
	<tr>
	<td>상품이름*</td><td><input type="text"name="itemName"required="required"value="${i.itemName}"></td>
	</tr>
	<tr>
	<td>제조사</td><td><input type="text"name="itemBrand"value="${i.itemBrand }"></td>
	</tr>
	<tr>
	<td>모델명(번호)</td><td><input type="text"name="itemModel"value="${i.itemModel }"></td>
	</tr>
	<tr>
	<td>상품가격*</td><td><input type="number"name="itemPrice"required="required"value="${i.itemPrice }"></td>
	</tr>
	<tr>
	<td>대여기간</td>
	<td>${requestScope.itemInfo.itemRegDate}&nbsp;~&nbsp;<input type="date"name="itemExpDate"required="required"value="${requestScope.itemInfo.itemExpDate}" >
	</td>
	</tr>
	<tr>
	<td>분류선택*</td>
	<td >
	<c:forEach items="${requestScope.catList }" var="cat" varStatus="info">	
	<input type="checkbox" name="category" value="${cat.catNo }">${cat.catName}
	<c:if test="${info.count%3==0}"><br></c:if>
	</c:forEach>
	</td>
	</tr>
	<tr>
	<td>상품설명*</td><td><textarea name="itemExpl"cols="50"rows="8">${i.itemExpl }</textarea></td>
	</tr>
	<tr>
	<td>사진*</td>
	<td>
	<ul id="pictureList">
	<c:forEach items="${i.picList}" var="picName" varStatus="info">
	<li >${picName }<button class='deleteBtn'>x</button></li>	
	</c:forEach>
	</ul>
	</td>
	</tr>
</table>
</form>
</div>
<div class="southContent">
<form id="uploadForm" method="post"enctype="multipart/form-data">
	<input type="hidden"name="command"value="PictureUpload">
	<input class="btn"type="file"name="img"id="imgBtn">
</form>
	
</div>
<input id="updateBtn"class="btn btn_pk"type="button"value="상품 수정">
</div>
