<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link
	href="${pageContext.request.contextPath }/template/e-shopper/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/template/e-shopper/css/animate.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/template/e-shopper/css/main.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/template/fancytab/css/fancytab.css"
	rel="stylesheet">

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
<script type="text/javascript">
	window.alert = function() {
	};
	var defaultCSS = document.getElementById('bootstrap-css');
	function changeCSS(css) {
		if (css)
			$('head > link')
					.filter(':first')
					.replaceWith(
							'<link rel="stylesheet" href="'+ css +'" type="text/css" />');
		else
			/* $('head > link').filter(':first').replaceWith(defaultCSS); */
			$('head > link')
			.filter(':first')
			.replaceWith(
					'<link rel="stylesheet" href="'+ css +'" type="text/css" />');
	}
	$(document).ready(function() {
		var iframe_height = parseInt($('html').height());
		/* window.parent.postMessage(iframe_height); */
	});
</script>

<div class="col-sm-12 bgheader"></div>
<div class="container-fluid">
	<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-5" align="center">
			<div class="product-information">
				<!-- 180904 MIRI 사진 슬라이드 기능 추가 -->
				<div class="w3-content w3-display-container">
					<c:forEach items="${itemDetail.picList }" var="picList">
						<img class="mySlides w3-round"
							src="${pageContext.request.contextPath }/upload/${picList} "
							width="400" height="400">
					</c:forEach>
				</div>
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

					<p>
						<b>평점 :</b> ${item.itemAddVO.grade}
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
				//180905 MIRI JavaScript 1000 단위 콤마 찍기
				function numberWithCommas(money) {
				    return money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
				 //180905 MIRI 총 대여 날짜 계산을 위한 전역변수 선언
				 $(document).ready(function() {
		        	var firDateSelect;
		        	var secDateSelect;
		        	var substractDate;
			        var dates = $( "#from,#to" ).datepicker({
			      	  showOn:"both",
			      	 buttonText: "<i class='fa fa-calendar'></i>",	// 180905 SOJEONG button이미지 추가 
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
			      	  		//180905 MIRI 변수 firDateSelect에 대여날짜 저장
				      	  	firDateSelect = selDate.getTime();
			      	  	} else {
				      	  	//180905 MIRI 변수 secDateSelect에 반납날짜 저장
				      	  	var selDate = getDateInstance(selectedDate);
				      	  	secDateSelect = selDate.getTime();
				      	  	//반납 날짜를 선택하면 총 대여 날이 즉시 계산
				      	    substractDate = Math.abs((secDateSelect - firDateSelect) / (1000 * 60 * 60 * 24));
				      	  	$("#subDate").text(numberWithCommas(substractDate * ${item.itemPrice}));
				      	  	} 
			         },
			         beforeShow: function(){
			        	// 시작 날짜버튼 클릭시 재설정
			        	 if(this.id=="from"){
			         		$(this).datepicker('setDate');	//reset date
			         		$("#to").datepicker('setDate');	//reset date
			         		$("#to").datepicker("option","disabled",true);
			         		//180905 MIRI 총 금액 칸 공백
			         		$("#subDate").text("");
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
			  });
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
								<br>
								<br>
								<br>
							</c:when>
							<c:otherwise>
								<form action="front" method="post">
									<input type="hidden" name="command" value="ItemRental">
									<input type="hidden" name="item_no" value="${itemNo}">
									<!-- 180903 JB 대여일 조건 추가 위해 min/max 추가 -->
									<br> 대여 일자 <input id="from" type="text" name="rentalDate"
										value="" required="required" data-readonly><br>
									반납 일자 <input id="to" type="text" name="returnDate" value=""
										required="required" data-readonly><br> <img
										src="${pageContext.request.contextPath }/template/e-shopper/images/product-details/share.png"
										class="share img-responsive" />
									<hr>
									<div align="right">
										<span> <span> TOTAL &nbsp; </span>
										</span> <span><span id="subDate"></span></span> <span> <span>
												원 </span>
										</span>
									</div>
									<div align="center">
										<button type="submit" class="btn btn-fefault cart">
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
	<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-10" align="center">
			<div class="product-information" align="center">
				<div class="container text-center" align="center">
					<div role="tabpanel" align="center">
					
						<!-- 180907 MIRI Nav tabs -->
						<ul class="nav nav-justified" id="nav-tabs" role="tablist"
							style="align-content: center; align-items: center;">
							<li role="presentation"><a href="#daksh"
								aria-controls="dustin" role="tab" data-toggle="tab"> <img
									class="img-rounded" align="middle"
									src="${pageContext.request.contextPath }/DetailNav.png" /> <span
									class="quote"><i class="fa fa-quote-left"></i></span>
							</a></li>
							<li role="presentation"><a href="#dustin"
								aria-controls="daksh" role="tab" data-toggle="tab"> <img
									class="img-rounded" align="middle"
									src="${pageContext.request.contextPath }/ReviewNav.png" /> <span
									class="quote"><i class="fa fa-quote-left"></i></span>
							</a></li>
						</ul>

						<!-- 180906 MIRI Tab panes -->
						<div class="tab-content" id="tabs-collapse">

							<div role="tabpanel" class="tab-pane fade" id="daksh"
								align="center">
								<div class="tab-inner" align="center">
									<p class="lead" align="center">
									<c:set value="${requestScope.itemDetail }" var="item"></c:set>
										<br>
										<br>
										<br> ${item.itemExpl } <br>
										<br>
										<br>
										<br>
										<br>
										<c:forEach items="${itemDetail.picList }" var="picList">
											<img
												src="${pageContext.request.contextPath }/upload/${picList}">
											<br>
											<br>	
											<br>
											<br>
										</c:forEach>
									</p>
									<hr>
									<p>
										<strong class="text-uppercase">Borrow:바로빌리다</strong>
									</p>
									<p>
										<em class="text-capitalize"> UX designer</em> at <a href="#">MIRI</a>
									</p>
								</div>
							</div>
							<!-- 180907 MIRI 후기 게시판 -->
							<div role="tabpanel" class="tab-pane fade in active" id="dustin">
								<div class="tab-inner">
									<p class="lead">
										<c:forEach var="rvo" items="${requestScope.rvo.list}">
											<div class="reviews">
												<div class="row blockquote review-item">
													<div class="col-md-3 text-center">
														<img class="rounded-circle reviewer"
															src="http://standaloneinstaller.com/upload/avatar.png">
														<div class="caption">
															<small>by <a href="#joe">${rvo.memberVO.name}</a></small>
														</div>
													</div>
													<div class="col-md-9">
														<h4><b>"${rvo.reviewTitle }"</b></h4>
														<div class="ratebox text-center" data-id="0"
															data-rating="5"></div>
														<p class="review-text"> <pre>${rvo.reviewContent }</pre></p>
									<small class="review-date">${rvo.reviewRegdate}</small><br><br>
								</div>
							</div>
						</div>
						</c:forEach>
						</p>
						<!-- 180907 MIRI 페이징 -->
						<ul class="pagination justify-content-center">
							<c:if test="${requestScope.rvo.pagingBean.previousPageGroup}">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${requestScope.rvo.pagingBean.startPageOfPageGroup-1}">&laquo;</a></li>
							</c:if>
							<c:forEach
								begin="${requestScope.rvo.pagingBean.startPageOfPageGroup}"
								end="${requestScope.rvo.pagingBean.endPageOfPageGroup}"
								var="pagenum">
								<c:choose>
									<c:when test="${requestScope.rvo.pagingBean.nowPage!=pagenum}">
										<li class="page-item"><a class="page-link"
											href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${pagenum}">${pagenum}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item active"><a class="page-link"
											href="#">${pagenum}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${requestScope.rvo.pagingBean.nextPageGroup}">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${requestScope.rvo.pagingBean.endPageOfPageGroup+1}">&raquo;</a></li>
							</c:if>
						</ul>
						<hr>
						<p>
							<strong class="text-uppercase">Borrow:바로빌리다</strong>
						</p>
						<p>
							<em class="text-capitalize"> Senior web developer</em> at <a
								href="#">MIRI</a>
						</p>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
</div>
<div class="col-sm-1"></div>
</div>
</div>
<div></div>

	<%-- <ul class="pagination justify-content-center">
		<c:if test="${requestScope.rvo.pagingBean.previousPageGroup}">
			<li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${requestScope.rvo.pagingBean.startPageOfPageGroup-1}">&laquo;</a></li>
		</c:if>
		<c:forEach begin="${requestScope.rvo.pagingBean.startPageOfPageGroup}"
			end="${requestScope.rvo.pagingBean.endPageOfPageGroup}" var="pagenum">
			<c:choose>
				<c:when test="${requestScope.rvo.pagingBean.nowPage!=pagenum}">
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${pagenum}">${pagenum}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item active"><a class="page-link" href="#">${pagenum}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${requestScope.rvo.pagingBean.nextPageGroup}">
			<li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=ItemDetail&itemNo=${requestScope.itemDetail.itemNo}&pageNo=${requestScope.rvo.pagingBean.endPageOfPageGroup+1}">&raquo;</a></li>
		</c:if>
	</ul> --%>
	
</div>
<div class="col-sm-1" align="center"></div>
<form id="deleteForm" action="${pageContext.request.contextPath}/front"
	method="post">
	<input type="hidden" name="command" value="ItemDelete"> <input
		type="hidden" name="itemNo" value="${itemNo}"> <input
		type="hidden" name="flag" id="flag">
</form>
