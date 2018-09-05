<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath }/template/e-shopper/css/font-awesome.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/template/e-shopper/css/animate.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/template/e-shopper/css/main.css" rel="stylesheet">

<style>
.bgheader {
	height: 50px;
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
</style>
<div class="col-sm-12 bgheader"></div>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-5 type">
			<!-- 180904 MIRI 사진 슬라이드 기능 추가 -->
			<div class="w3-content w3-display-container" align="left">
				<c:forEach items="${itemDetail.picList }" var="picList">
					<img class="mySlides w3-round"
						src="${pageContext.request.contextPath }/upload/${picList} "
						width="400" height="400">
				</c:forEach>
				<!-- 180904 MIRI 사진이 2장 이상일 때부터 버튼 보임 -->
				<c:if test="${fn:length(itemDetail.picList) > 1}">
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
			<form>
				<c:set value="${requestScope.itemDetail }" var="item"></c:set>
				<div class="product-information">
					<!--/product-information-->
					<h2>
						<b>${item.itemName }</b>
					</h2>
					<p>Web ID : ${item.memberVO.id }</p>
					<span> <span><fmt:formatNumber>${item.itemPrice }</fmt:formatNumber>원/1일</span>
					</span>
					<p>
						<b>Brand :</b> ${item.itemBrand }
					</p>
					<p>
						<b>Model :</b> ${item.itemModel }
					</p>
					
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
				  /* 180904 SOJEONG 대여중인 날짜 비활성화 */
				  var dates = ${requestScope.dateList};
			 	function getNextDisabledDate(date){
			 		if(dates==null)return "no";
				  var nextDisabledDate = "no";
				  dates.sort();
				  $.each(dates, function(i, d) {
				  	if(date<d){
				  		nextDisabledDate = d;
				  		return false;
				  	}
				  });
				  if(nextDisabledDate=="no") return "no";
				  return getDateInstance(nextDisabledDate);
			  	}
				function unavailable(date){		
					d = date.getFullYear()+("0"+(date.getMonth()+1)).slice(-2)+("0"+date.getDate()).slice(-2);
					if($.inArray(d,dates )==-1){
						return [true,""];
					}else{
					 	return [false,""];
					}
				}
				function getDateInstance(date){
					var y = Math.floor(date /10000);
			    	var m = Math.floor((date%10000)/100)-1;
			    	var d = (date%100);
			    	return new Date(y,m,d);	
				}
				 $(function() {
			        var dates = $( "#from,#to" ).datepicker({
			      	  showOn:"button",
			      	  buttonText:"cal",
			           prevText: '이전 달',
			             nextText: '다음 달',
			           monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			              dayNamesShort: ['일','월','화','수','목','금','토'],
			              dayNamesMin: ['일','월','화','수','목','금','토'],
			            showMonthAfterYear: true,
			             yearSuffix: '년',
			            dateFormat:"yymmdd",
			             minDate: 0,
			             maxDate: new Date("${requestScope.itemDetail.itemExpDate}"),
			         beforeShowDay: unavailable,
			         onSelect : function(selectedDate){
			      	  	if(this.id=="from"){
				        	var selDate = getDateInstance(selectedDate);
				      	   	var nextDate = new Date(selDate.getTime() + 24*60*60*1000);
							var nextDisabledDate = getNextDisabledDate(selectedDate);
			      	  		dates.not(this).datepicker("option","disabled",false);
			      	  		dates.not(this).datepicker("option","minDate",nextDate);	//선택한 datepicker가 아닌 다른 datepicker의 옵션을 설정
			      	  		if(nextDisabledDate!="no")
			      	  			dates.not(this).datepicker("option","maxDate",nextDisabledDate);
			      	  	}
			         },
			         beforeShow: function(){
			        	// 시작 날짜버튼 클릭시 재설정
			        	 if(this.id=="from"){
			         		$(this).datepicker('setDate');	//reset date
			         		$("#to").datepicker('setDate');	//reset date
			         		$("#to").datepicker("option","disabled",true);
			        	 }
			         }
			      });
			        $("#to").datepicker("option","disabled",true);
			        /*180904 SOJEONG대여 날짜 비활성화 완료*/
			        /*180904 SOJEONG 삭제 수정*/
			        $("#deleteBtn").click(function(){
			        	$.ajax({
			        		type:"post",
			        		url:"${pageContext.request.contextPath}/front",
			        		data:"command=ItemDeleteCheck&itemNo=${requestScope.itemDetail.itemNo}",
			        		success: function(result){
			        			$("#flag").val(result);
			        			if(result=="true"){// 삭제 가능
			        				
			        				if(confirm("현재 대여중인 회원이 없습니다. 상품을 삭제하시겠습니까?")){
			        					//location.href="${pageContext.request.contextPath}/front?command=ItemDelete&itemNo=${requestScope.itemDetail.itemNo}";
			        					$("#deleteForm").submit();
			        				}
			        			}else{	//삭제 여부 묻기
			      
									if(confirm("현재 대여 중인 회원이 있습니다.\n삭제 예정일 : "+result+"\n삭제 신청하시겠습니까?")){
										//location.href="${pageContext.request.contextPath}/front?command=ItemDelete&itemNo=${requestScope.itemDetail.itemNo}&";
										$("#deleteForm").submit();
									}
			        			}}
			        		});
			        });
			  } );
			</script>
					<c:set value="${requestScope.itemDetail.itemNo}" var="itemNo"></c:set>
					<!-- 180831 MIRI 본인일 경우에는 수정/삭제 버튼 보이고 본인이 아닐 경우에는 달력 및 대여버튼 보이기-->
					<c:if test="${!empty sessionScope.user}">
						<!-- 로그인되어있으면 -->
						<c:choose>
							<c:when
								test="${sessionScope.user.id == requestScope.itemDetail.memberVO.id}">
								<button type="button"
									class="w3-theme-d1 w3-button w3-round-large" name="update"
									onclick="updateItem(${itemNo})">수정</button>
						&nbsp;&nbsp;&nbsp;
						<button id="deleteBtn" type="button"
									class="w3-theme-d2 w3-button w3-round-large" name="delete">삭제</button>
								<br><br><br>
							</c:when>
							<c:otherwise>
								<form action="front" method="post">
									<input type="hidden" name="command" value="ItemRental">
									<input type="hidden" name="item_no" value="${itemNo}">
									<!-- 180903 JB 대여일 조건 추가 위해 min/max 추가 -->
									<br>
									대여날짜 입력
									<input id="from" type="text" name="rentalDate" value="" required="required" data-readonly><br>
									반납날짜 입력
									<input id="to" type="text" name="returnDate" value="" required="required" data-readonly><br> 
									<img src="${pageContext.request.contextPath }/template/e-shopper/images/product-details/share.png" class="share img-responsive"/>										
									<hr>
									<div align="right">
										<span>
											<span>
												TOTAL &nbsp;&nbsp;
												<!-- 수정 필요 -->
												<fmt:formatNumber>${item.itemPrice }</fmt:formatNumber>
												원
											</span>
										</span>
									</div>
									<div align="center">
										<button type="submit" class="btn btn-fefault cart" >
											<i class="fa fa-shopping-cart"></i> &nbsp;바로 빌리기
										</button>
									</div>
								</form>
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
				<!--/product-information-->
			</form>
		</div>
		<div class="col-sm-1"></div>
	</div>
</div>

<form id="deleteForm" action="${pageContext.request.contextPath}/front"
	method="post">
	<input type="hidden" name="command" value="ItemDelete"> <input
		type="hidden" name="itemNo" value="${itemNo}"> <input
		type="hidden" name="flag" id="flag">
</form>
