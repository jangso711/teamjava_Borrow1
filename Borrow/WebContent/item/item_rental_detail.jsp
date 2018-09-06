<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href='https://fonts.googleapis.com/css?family=Pacifico'
	rel='stylesheet' type='text/css'>
<link
	href="${pageContext.request.contextPath }/template/e-shopper/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/template/e-shopper/css/animate.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/template/e-shopper/css/main.css"
	rel="stylesheet">

<style>
table {
	text-align: center;
}

table#info {
	position: relative;
	left: 23%;
}

.bgheader {
	height: 50px;
}

.btn_pk {
	background-color: #f6cac9;
	height: 30px;
	margin: 10px;
}

.mySlides {
	display: none;
}

.w3-theme-d1 {
	color: #fff !important;
	background-color: #f1a4a3 !important
}

.w3-theme-d2 {
	color: #fff !important;
	background-color: #aeacb7 !important
}

input[data-readonly] {
	pointer-events: none;
}

th {
	text-align: center;
}

td {
	text-align: center;
}

td#test {
	width: 400px;
}

h3 {
	padding-left: 100px;
	padding-top: 30px;
	font-weight: bold;
}

h5 {
	font-weight: bold;
}
</style>
<%-- 대여료 상세 추가 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
	
</script>

<div class="col-sm-12 content">
	<fmt:parseDate value="${requestScope.rvo.rentalDate}" var="strPlanDate"
		pattern="yyyy-MM-dd" />
	<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}"
		integerOnly="true" var="strDate"></fmt:parseNumber>
	<fmt:parseDate value="${requestScope.rvo.returnDate}" var="endPlanDate"
		pattern="yyyy-MM-dd" />
	<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}"
		integerOnly="true" var="endDate"></fmt:parseNumber>
	<h3>대여 내역</h3>
	<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-5" align="center">
			<div class="product-information">
				<!-- 180904 MIRI 사진 슬라이드 기능 추가 -->
				<div class="w3-content w3-display-container">
					<c:forEach items="${rvo.itemVO.picList }" var="picList">
						<img class="mySlides w3-round"
							src="${pageContext.request.contextPath }/upload/${picList}"
							width="400" height="400">
					</c:forEach>
				</div>
				<!-- 180904 MIRI 사진이 2장 이상일 때부터 버튼 보임 -->
				<c:if test="${fn:length(rvo.itemVO.picList) > 1}">
					<button class="w3-button w3-black w3-display-left"
						onclick="plusDivs(-1)">&#10094;</button>
					<button class="w3-button w3-black w3-display-right"
						onclick="plusDivs(1)">&#10095;</button>
				</c:if>
			</div>
			<script>
				var slideIndex = 1;
				showDivs(slideIndex);

				function plusDivs(n) {
					showDivs(slideIndex += n);
				}

				function showDivs(n) {
					var i;
					var x = document.getElementsByClassName("mySlides");
					if (n > x.length) {
						slideIndex = 1
					}
					if (n < 1) {
						slideIndex = x.length
					}
					for (i = 0; i < x.length; i++) {
						x[i].style.display = "none";
					}
					x[slideIndex - 1].style.display = "block";
				}
			</script>
		</div>
		<div class="col-sm-5">
			<table class="table">
				<tr>
					<th>거래번호</th>
					<td id="test">${requestScope.rvo.rentalNo}</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td id="test">${requestScope.rvo.itemVO.itemName}</td>
				</tr>
				<tr>
					<th>제조사</th>
					<td id="test">${requestScope.rvo.itemVO.itemBrand}</td>
				</tr>
				<tr>
					<th>모델명</th>
					<td id="test">${requestScope.rvo.itemVO.itemModel}</td>
				</tr>
				<tr>
					<th>등록자</th>
					<td id="test">${requestScope.rvo.memberVO.id}</td>
				</tr>
				<tr>
					<th>대여일</th>
					<td id="test">${requestScope.rvo.rentalDate}</td>
				</tr>
				<tr>
					<th>반납일</th>
					<td id="test">${requestScope.rvo.returnDate}</td>
				</tr>
				<tr>
					<%-- 대여료 출력 조건 추가 --%>
					<th>대여료</th>
					<td id="test"><button type="button" class="btn btn-link"
							data-toggle="collapse" data-target="#demo">
							<fmt:formatNumber>${requestScope.rvo.totalPayment}</fmt:formatNumber>
						</button>
						<div id="demo" class="collapse">
							<c:choose>
								<c:when test="${requestScope.check != null}">
									<div id="friendImg" style="text-align: center">
										<br>
										<table id="info" width="200">
											<tr>
												<td colspan=2><h5>대여료 상세 정보</h5></td>
											</tr>
											<tr>
												<td>일대여료</td>
												<td>${requestScope.rvo.itemVO.itemPrice}</td>
											</tr>
											<tr>
												<td>총대여일수</td>
												<td>${(endDate-strDate)}</td>
											</tr>
										</table>
									</div>
								</c:when>
								<c:otherwise>
									<div id="friendImg" style="text-align: center">
										<br>
										<table id="info" width="200">
											<tr>
												<td colspan=2><h5>대여료 상세 정보</h5></td>
											</tr>
											<tr>
												<td>일대여료</td>
												<td>${requestScope.rvo.itemVO.itemPrice}</td>
											</tr>
											<tr>
												<td>총대여일수</td>
												<td>${(endDate-strDate)}</td>
											</tr>
											<tr>
												<td>대여 전 포인트</td>
												<td>${requestScope.originalPoint}</td>
											</tr>
											<tr>
												<td>대여 후 포인트</td>
												<td>${requestScope.newPoint}</td>
											</tr>
										</table>
									</div>
								</c:otherwise>
							</c:choose>
						</div></td>
				</tr>
				<tr>
					<td colspan=3><input class="btn" type="button" value="홈"
						onclick="location.href='${pageContext.request.contextPath}/index.jsp'">
						<input class="btn" type="button" value="마이페이지"
						onclick="location.href='${pageContext.request.contextPath}/front?command=MemberMypage'">
					</td>
				</tr>
			</table>
		</div>
		<div class="col-sm-1"></div>
	</div>
</div>
