<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
h3 {
	padding-left: 100px;
	padding-top: 30px;
	font-weight: bold;
}

.bgheader {height:160px;}

.mySlides {display:none;}

</style>
<div class="col-sm-12 bgheader"></div>
	<h3>상세보기</h3>
<div class="container-fluid">
  <div class="row" align="center">
    <div class="col-sm-1"></div>
    <div class="col-sm-5">
    
    <c:set value="${requestScope.itemDetail }" var="item"></c:set>
    <h2 class="w3-center">${item.itemName }</h2>
    <!-- 180904 MIRI 사진 슬라이드 기능 추가 -->
	<div class="w3-content w3-display-container">
		<c:forEach items="${itemDetail.picList }" var="picList">
			<img class="mySlides" src="${pageContext.request.contextPath }/upload/${picList}" width="400" height="400">
		</c:forEach>
	    <button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
	    <button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
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
		  if (n > x.length) {slideIndex = 1}    
		  if (n < 1) {slideIndex = x.length}
		  for (i = 0; i < x.length; i++) {
		     x[i].style.display = "none";  
		  }
		  x[slideIndex-1].style.display = "block";  
		}
	</script>
		</div>
    	<div class="col-sm-5">
    	<div class="col-sm-12 content">
		<form>
    	<table class="table">
            <tr>
                <th>카테고리</th>
				<td>
					<!-- 180901 MIRI 상품 전체 카테고리 리스트를 불러옴 -->
					<c:forEach items="${itemDetail.catList }" var="catList">
						${catList.catName } / 
					</c:forEach>
				</td>
            </tr>
            <tr>
                <th>브랜드</th>
                <td>${item.itemBrand }</td>
            </tr>
            <tr>
                <th>모델</th>
                <td>${item.itemModel }</td>
            </tr>
            <tr>
                <th>가격</th>
                <td>${item.itemPrice }</td>
            </tr>
            <tr>
                <th>등록 날짜</th>
                <td>${item.itemRegDate }</td>
            </tr>
            <tr>
                <th>만료 날짜</th>
                <td>${item.itemExpDate }</td>
            </tr>
            <tr>
                <th>등록자</th>
                <td>${item.memberVO.id }</td>
            </tr>
            <tr>
                <th>설명</th>
                <td><pre>${item.itemExpl }</pre></td>
            </tr>
        </table>
			<br><br>
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
				
				/* 180904 SOJEONG 대여중인 날짜 비활성화 함수*/
	  			function unavailable(date){
		 			d = date.getFullYear()+("0"+(date.getMonth()+1)).slice(-2)+("0"+date.getDate()).slice(-2);
		  			if($.inArray(d, ${requestScope.dateList})==-1){
			  			return [true,""];
		  			}else{
			 		 	return [false,""];
		  			}
	  			}
	  
	 			 $( function() {
	   				var dates = $( "#from,#to" ).datepicker({
	   					prevText: '이전 달',
	   				  	nextText: '다음 달',
	   					monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	   			 		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	   			 	  	dayNamesShort: ['일','월','화','수','목','금','토'],
	   			   		dayNamesMin: ['일','월','화','수','목','금','토'],
	   			 		showMonthAfterYear: true,
	   		  			yearSuffix: '년',
	   			 		dateFormat:"yymmdd",
	    				beforeShowDay: unavailable,
	    				onSelect : function(selectedDate){
	    					 var option = this.id == "from" ? "minDate" : "maxDate",
	    						      instance = $( this ).data( "datepicker" ),
	    						      date = $.datepicker.parseDate(
	    						        instance.settings.dateFormat ||
	    						        $.datepicker._defaults.dateFormat,
	    						        selectedDate, instance.settings );
	    						    dates.not( this ).datepicker( "option", option, date );
	    				}
	    			});
	  			} );
			</script>

			<c:set value="${requestScope.itemDetail.itemNo}" var="itemNo"></c:set>
			<!-- 180831 MIRI 본인일 경우에는 수정/삭제 버튼 보이고 본인이 아닐 경우에는 달력 및 대여버튼 보이기-->
			<c:if test="${!empty sessionScope.user}">   <!-- 로그인되어있으면 -->
				<c:choose>
					<c:when test="${sessionScope.user.id == requestScope.itemDetail.memberVO.id}">
						<button type="button" name="update" onclick="updateItem(${itemNo})">수정</button>
						<button type="button" name="delete" onclick="deleteItem(${itemNo})">삭제</button>
					</c:when>
					<c:otherwise> 
					<form action="front" method="post">
						<input type="hidden" name="command" value="ItemRental">
						<input type="hidden" name="item_no" value="${itemNo}">
						<!-- 180903 JB 대여일 조건 추가 위해 min/max 추가 -->
						대여날짜 입력<input id="from"type="text" name="rentalDate" min="${item.itemRegDate}" max="${item.itemExpDate}" required="required"><br>
						반납날짜 입력<input id="to"type="text"  name="returnDate" min="${item.itemRegDate}" max="${item.itemExpDate}" required="required" ><br>
						<input type="submit" value="대여하기">
					</form>
					</c:otherwise>
				</c:choose>
			</c:if>
		</form>
	</div>
    </div>
    <div class="col-sm-1"></div>
  </div>
</div>


