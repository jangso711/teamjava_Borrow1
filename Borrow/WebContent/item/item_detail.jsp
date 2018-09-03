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
				<tr>
				<c:set value="${requestScope.itemDetail }" var="item"></c:set>
					<td>
						<!-- 180903 MIRI ItemDAO에서 처리 -->
						<%-- <!-- 180901 MIRI 사진이 없으면 디폴트 이미지 띄움 -->
							<c:if test="${empty itemDetail.picList }">
								<img src="${pageContext.request.contextPath }/upload/디폴트.png">
							</c:if> --%>
							<!-- 180901 MIRI 상품 전체 사진 리스트를 불러와 사진이 있으면 사진을 띄움 -->
							<c:forEach items="${itemDetail.picList }" var="picList">
								<img src="${pageContext.request.contextPath }/upload/${picList}" width="150" height="150"><br>
							</c:forEach>
					</td>
					<td>
						<!-- 180901 MIRI 상품 전체 카테고리 리스트를 불러옴 -->
						<c:forEach items="${itemDetail.catList }" var="catList">
							${catList.catName }<br>
						</c:forEach>
					</td>
					<td>${item.itemName }</td>
					<td>${item.itemBrand }</td>
					<td>${item.itemModel }</td>
					<td>${item.itemPrice }</td>
					<td>${item.itemRegDate }</td>
					<td>${item.itemExpDate }</td>
					<td>${item.memberVO.id }</td>
					<td><pre>${item.itemExpl }</pre></td>
				</tr>
			</tbody>
		</table>
		
		<script type="text/javascript">
			/* 180831 MIRI 게시글 수정 함수 */
			function updateItem(upitem_no) {
				var up = confirm("게시글을 수정하시겠습니까?");
				if(up) {
					location.href="${pageContext.request.contextPath}/front?command=ItemUpdateForm&itemNo="+upitem_no;
				}
			}
			/* 180831 MIRI 게시글 삭제 함수 */
			function deleteItem(delitem_no) {
				var del = confirm("게시글을 삭제하시겠습니까?");
				if(del) {
					location.href="${pageContext.request.contextPath}/front?command=ItemDelete&itemNo="+delitem_no;
				}
			}
			/* 180901 MIRI 게시글 렌트 함수 */
			function rentItem(rentitem_no) {
				var rent = confirm("해당 물품을 대여하시겠습니까?");
				if(del) {
					location.href="${pageContext.request.contextPath}/front?command=ItemRental&rentitem_no="+rentitem_no;
				}
			}
		</script>
		
		<c:set value="${requestScope.itemDetail.itemNo}" var="itemNo"></c:set>
		<!-- 180831 MIRI 본인일 경우에는 수정/삭제 버튼 보이고 본인이 아닐 경우에는 달력 및 대여버튼 보이기-->
		<c:choose>
			<c:when test="${sessionScope.user.id == requestScope.itemDetail.memberVO.id}">
				<button type="button" name="update" onclick="updateItem(${itemNo})">수정</button>
				<button type="button" name="delete" onclick="deleteItem(${itemNo})">삭제</button>
			</c:when>
			<c:otherwise> 
			<body>
			<form action="front" method="post">
				<input type="hidden" name="command" value="ItemRental">
				<input type="hidden" name="item_no" value="${itemNo}">
				대여날짜 입력<input type="date" value=""  name="rentalDate"><br>
				반납날짜 입력<input type="date" value=""  name="returnDate"><br>
				<input type="submit" value="대여하기">
			</form>
			</body>
			</c:otherwise>
		</c:choose>
	</form>
</div>