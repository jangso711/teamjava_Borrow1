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
<h3>상세보기</h3>
	<form>
		<table class="table">
			<thead>
				<tr>
					<th> </th>
					<th>카테고리이름</th>
					<th>상품명</th>
					<th>브랜드</th>
					<th>모델</th>
					<th>가격</th>
					<th>등록날짜</th>
					<th>만료날짜</th>
					<th>등록자</th>
					<th>설명</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${requestScope.itemDetail }" var="detail">
					<tr>

						<td><img src="${pageContext.request.contextPath }/upload/아이유1.jpg" width="150" height="150"></td>

						<td>${detail.categoryVO.catName }</td>
						<td>${detail.itemName }</td>
						<td>${detail.itemBrand }</td>
						<td>${detail.itemModel }</td>
						<td>${detail.itemPrice }</td>
						<td>${detail.itemRegDate }</td>
						<td>${detail.itemExpDate }</td>
						<td>${detail.memberVO.id }</td>
						<td><pre>${detail.itemExpl }</pre></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<script type="text/javascript">
			function updateItem(upitem_no) {
				var up = confirm("게시글을 수정하시겠습니까?");
				if(up) {
					location.href="${pageContext.request.contextPath}/front?command=ItemUpdateForm&upitem_no="+upitem_no;
				}
			}
			function deleteItem(delitem_no) {
				var del = confirm("게시글을 삭제하시겠습니까?");
				if(del) {
					location.href="${pageContext.request.contextPath}/front?command=ItemDelete&delitem_no="+delitem_no;
				}
			}
		</script>
		
		<button type="button" name="update" onclick="updateItem(10005)">수정</button>
		<button type="button" name="delete" onclick="deleteItem(10006)">삭제</button>
	</form>
</div>