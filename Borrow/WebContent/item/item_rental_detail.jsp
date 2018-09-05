<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>

<style>
h1 {
    color: #08088A;
    text-align: center;
}
table{
	text-align: center;
}
.bgheader {
	height: 50px;
}
 .btn_pk{
   background-color: #f6cac9;
   height:30px;
   margin:10px;   
}
th {
    background-color: #F5A9BC;
    text-align: center;
  }
td {
    text-align: center;
    }
h3 {
	padding-left: 100px;
	padding-top: 30px;
	font-weight: bold;
}
</style>
<%-- 대여료 상세 추가 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#friendImg").hide();
		$("#infoSpan").hover(function(){
			$("#friendImg").show(1000).css("background-color", "#F5A9BC");
		}, function(){
			$("#friendImg").hide(1000);
		});
	});
</script>

<br>
<br>
<br>
<br>
<div class="col-sm-12 bgheader"></div>
<div class="col-sm-4 container">    
	<fmt:parseDate value="${requestScope.rvo.rentalDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
	<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
	<fmt:parseDate value="${requestScope.rvo.returnDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
	<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>    
	<h1>대여 상세 보기</h1>     
  	<table class="table table-bordered" align = "center">
  		<tr>
  			<th rowspan="9"> <img src="${pageContext.request.contextPath}/upload/${rvo.itemVO.picList[0]}" width="150" height="150" > </th>
  		</tr>
  		<tr>
			<th>거래번호</th><td>${requestScope.rvo.rentalNo}</td>
		</tr>
		<tr>
			<th>상품명</th><td>${requestScope.rvo.itemVO.itemName}</td>
		</tr>
		<tr>
			<th>제조사</th><td>${requestScope.rvo.itemVO.itemBrand}</td>
		</tr>
		<tr>
			<th>모델명</th><td>${requestScope.rvo.itemVO.itemModel}</td>
		</tr>
		<tr>
			<th>등록자</th><td>${requestScope.rvo.memberVO.id}</td>
		</tr>
		<tr>
			<th>대여일</th><td>${requestScope.rvo.rentalDate}</td>
		</tr>
		<tr>
			<th>반납일</th><td>${requestScope.rvo.returnDate}</td>
		</tr>
		<tr>
			<%-- 대여료 출력 조건 추가 --%>
			<th>대여료</th>
			<td><span id="infoSpan"><fmt:formatNumber>${requestScope.rvo.totalPayment}</fmt:formatNumber></span>
				
				</div>
			</td>
		</tr>
	</table>
	<table >
		<c:choose>
			<c:when test="${requestScope.check != null}">
				<div id="friendImg" style="text-align:center">
					대여료 상세 정보<br>
					일대여료 : ${requestScope.rvo.itemVO.itemPrice}<br>
					대여일수 : ${(endDate-strDate)}<br>
				</div>
			</c:when>
			<c:otherwise>
				<div id="friendImg" style="text-align:center">
					대여료 상세 정보<br>
					일대여료 : ${requestScope.rvo.itemVO.itemPrice}<br>
					대여일수 : ${(endDate-strDate)}<br>
					대여 전 포인트: ${requestScope.originalPoint}<br>
					대여 후 포인트: ${requestScope.newPoint}<br>
				</div>
			</c:otherwise>
		</c:choose>
	</table>
	<br><br>
	<table align="center">
   	 <tr>
      <td><input class="btn btn_pk" type="button" value="홈" onclick="location.href='${pageContext.request.contextPath}/index.jsp'"></td>
      <td><input class="btn btn_pk" type="button" value="마이페이지" onclick="location.href='${pageContext.request.contextPath}/front?command=MemberMypage'"></td>
   	 </tr>
	</table>	
	<br><br><br><br><br>
</div>
