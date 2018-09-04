<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<div class="col-sm-12 content" align="center">
	<c:choose>
		<c:when test="${empty requestScope.allItemList }">
			<br>
			<h3>등록 상품이 존재하지 않습니다!!</h3>
			<br><br><br>
		</c:when>	
		<c:otherwise>
			<h3>${requestScope.allItemList[0].memberVO.id }님의 등록 상품 내역</h3>
			<form>
				<table class="table">
					<thead>
						<tr>
							<th> </th><th>이름</th><th>설명</th><th>가격</th><th>아이디</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${requestScope.allItemList }" var="allItemList">
						<c:set value="${pageContext.request.contextPath }/front?command=ItemDetail&itemNo=${allItemList.itemNo}" var="detailurl"></c:set>
							<tr>
								<td>							
									<a href="${detailurl}"><img src="${pageContext.request.contextPath}/upload/${allItemList.picList[0]}" width="150" height="150" ></a>
								</td>
								<td><a href="${detailurl }">${allItemList.itemName }</a></td>
								<td><pre>${allItemList.itemExpl }</pre></td>
								<td><fmt:formatNumber>${allItemList.itemPrice }</fmt:formatNumber></td>
								<td>${allItemList.memberVO.id }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>	
		</c:otherwise>
	</c:choose>
</div>

