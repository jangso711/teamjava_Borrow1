<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
h3{
	padding-left:100px;
	padding-top:30px;
	font-weight: bold;
}
.bgheader{

	height:160px;
}
</style>
<div class="col-sm-12 bgheader">
</div>
<div class="col-sm-12 content">
<h3>검색 상품 목록</h3>
<form>
	<table class="table">
		<thead>
			<tr>
				<th> </th><th>이름</th><th>설명</th><th>가격</th><th>아이디</th>
			</tr>
		</thead>
		<tbody>
			<!-- 180903 MIRI 클릭한 카테고리로 등록된 상품이 없을 시 alert 띄우고 메인화면으로 이동 -->
			<c:choose>
				<c:when test="${empty requestScope.itemCategorySearchList }">
					<script>
						alert("현재 '${requestScope.categoryVO.catName}' 카테고리에 해당하는 상품이 없습니다.");
						location.href="${pageContext.request.contextPath }/front?command=Main";
					</script>
				</c:when>
				<c:otherwise>
					<c:forEach items="${requestScope.itemCategorySearchList }" var="itemCategorySearchList">
					<c:set value="${pageContext.request.contextPath }/front?command=ItemDetail&itemSearchId=${itemCategorySearchList.itemNo}" 
						var="detailurl"></c:set>
						<tr>
							<td><a href="${detailurl }">
								<img src="${pageContext.request.contextPath }/upload/${itemCategorySearchList.picList[0]}" width="150" height="150"></a></td>
							<td><a href="${detailurl }">${itemCategorySearchList.itemName }(링크)</a></td>
							<td><pre>${itemCategorySearchList.itemExpl }</pre></td>
							<td>${itemCategorySearchList.itemPrice }</td>
							<td>${itemCategorySearchList.memberVO.id }</td>
						</tr>
					</c:forEach>						
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</form>
</div>