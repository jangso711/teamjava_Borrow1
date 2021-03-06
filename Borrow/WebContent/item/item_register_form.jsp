<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3{

	/* padding-top:30px; */
	font-weight: bold;
}
.input_text[type=text]{
	size:50px;
	height:40px;
	width:250px;
	border-radius: 5px;
	padding:5px;
}
.input_num[type=number]{
	size:50px;
	height:40px;
	width:250px;
	border-radius: 5px;
	padding:5px;
}
.formContent{
	padding-top:20px;
	padding-bottom:20px;
	text-align:center;

}
.southContent{
	padding-left:200px;
	padding-bottom:20px;
	
}
.bgheader {
	height: 50px;
}
table{
	margin:0 auto;
}
tr{
	border-top: 1px;
	border-bottom: 1px;
}
ul{
	list-style: none;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
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
		$("#registerBtn").click(function(){
			$("#catAlert").text("")
			var flag = true;
			var cats = $(".cats:checkbox:checked");
			var pics = $("#pictureList li").length;
			$(".required").each(function(){
				if($(this).val().length==0){
					flag=false;
					return false;
				}
			});
			if(!flag) {alert("필수항목(*)을 입력하세요.");return false;}
			if(cats.length==0){
				$("#catAlert").text("*카테고리를 1개 이상 선택해주세요.").css("color","red");
				return false;
			}
			if(pics==0){
				$("#picAlert").text("*사진을 1장 이상 등록해주세요.").css("color", "red");
				return false;
			}
			
			$("#registerForm").submit();
						
		});
		$("#pictureList").on("click","button",function(){
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/front",
				data:"command=DeleteServerPicture&fileName="+$(this).parent().find(":hidden").val(),
			});
			$(this).parent().remove();
		});
	});	
</script>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-12 formContent">
<h3>상품등록</h3>

<form action="${pageContext.request.contextPath }/front"method="post"id="registerForm">
<input type="hidden"name="command"value="ItemRegister">
<table cellpadding="3">
	<tr>
	<td>상품이름*</td><td><input type="text" class="input_text"name="itemName"class="required"></td>
	</tr>
	<tr>
	<td>제조사</td><td><input type="text" class="input_text"name="itemBrand"></td>
	</tr>
	<tr>
	<td>모델명(번호)</td><td><input type="text" class="input_text"name="itemModel"></td>
	</tr>
	<tr>
	<td>상품가격*</td><td><input type="number" class="input_num"name="itemPrice"class="required"></td>
	</tr>
	<tr>
	<td>대여기간*</td>
	<td><input type="radio"name="duration"id="2months"value="2">2개월&nbsp;
		<input type="radio"name="duration"id="3months"value="3"checked="checked">3개월
	</td>
	</tr>
	<tr>
	<td>분류선택*</td>
	<td >
	<c:forEach items="${requestScope.catList }" var="cat" varStatus="info">
	<input class="cats"type="checkbox" name="category" value="${cat.catNo }">${cat.catName}
	<c:if test="${info.count%3==0}"><br></c:if>
	</c:forEach>
	<br><span id="catAlert"></span>
	</td>
	</tr>
	<tr>
	<td>상품설명*</td><td><textarea name="itemExpl"cols="50"rows="8" class="required"></textarea></td>
	</tr>
	<tr>
	<td>사진*</td><td><span id="picAlert"></span><ul id="pictureList"></ul></td>
	</tr>
</table>
</form>
<div class="col-sm-12 southContent">
<form id="uploadForm" method="post"enctype="multipart/form-data">
	<input type="hidden"name="command"value="PictureUpload">
	<input type="file"name="img"id="imgBtn">
</form>
	
</div>		
	<input id="registerBtn"class="btn btn_pk"type="button"value="상품 등록">
</div>