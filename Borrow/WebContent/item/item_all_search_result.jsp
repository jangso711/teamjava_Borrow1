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
<h3>전체 상품 목록</h3>
	<form>
		<table class="table">
			<thead>
				<tr>
					<th> </th><th>이름</th><th>설명</th><th>가격</th><th>아이디</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${requestScope.allItemList }" var="allItemList">
				<!-- 180831 MIRI 클릭시 향하는 url을 변수에 담음 -->
				<c:set value="${pageContext.request.contextPath }/front?command=ItemDetail&itemSearchId=${allItemList.itemNo}" var="detailurl"></c:set>
					<tr>
						<td>
							<!-- 180902 yosep ItemDAO에서 처리 -->
							<%-- <!-- 180901 MIRI 사진이 없으면 디폴트 이미지 띄움 -->
							<c:if test="${empty allItemList.picList }">
								<img src="${pageContext.request.contextPath }/upload/디폴트.png">
							</c:if>
							<!-- 180901 MIRI 상품 전체 사진 리스트를 불러와 사진이 있으면 사진을 띄움 -->
							<c:forEach items="${allItemList.picList }" var="picList" varStatus="status">
								<!-- 180901 MIRI 사진이 여러장이면 첫 번째 대표 사진만 띄움 -->
								<c:if test="${status.index == 0 }">
									<a href="${detailurl }"><img src="${pageContext.request.contextPath }/upload/${picList}" width="150" height="150"></a><br>
								</c:if>
							</c:forEach> --%>
							
							<!-- 180902 yosep index를 0으로 처리(null값일경우에도 EL문에서 자동으로 처리)-->
							<a href="${detailurl}"><img src="${pageContext.request.contextPath}/upload/${allItemList.picList[0]}" width="150" height="150" ></a>
						</td>
						<td><a href="${detailurl }">${allItemList.itemName }</a></td>
						<td><pre>${allItemList.itemExpl }</pre></td>
						<td>${allItemList.itemPrice }</td>
						<td>${allItemList.memberVO.id }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>