<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.checked {
    color: orange;
}
.reviewContents{
	resize: none;
}
</style>
<script>
	$(function(){
		// 별점 세팅하기

		var grade = ${requestScope.reviewDetail.reviewGrade};
		
		for(var i=1;i<=grade;i++){
			$("#s"+i).addClass("checked");
		}
		// 글자수 세팅
		$("#totalChar").text($("#reviewContents").val().lenght);
		$("#reviewContents").on('input',function(e){
			var len = $(this).val().length;
			$("#totalChar").text(len);
			$("#warningView").text("");
		});// review change event
		
		$("#reviewUpdateBtn").click(function(){
			var tlen = $("#reviewTitle").val().trim().replace(/ /g,"").length;
			var clen = $("#reviewContents").val().trim().replace(/ /g,"").length;	// replaceAll
			$("#warningView1").text("");
			$("#warningView2").text("");
			if(tlen==0){
				$("#warningView1").text("* 제목을 1자 이상(공백 제외) 입력해주세요").css("color","red");
				return false;
			}
			if(clen<10) {
				$("#warningView2").text("* 내용을 10자 이상(공백 제외) 입력해주세요").css("color","red");
				return false;
			}
			
			$("#reviewUpdateForm").submit();
		});	//registerBtn click
		$("#cancelBtn").click(function(){
			history.back();
		});
	});//ready

</script>
<div class="col-sm-8 offset-2"  align="center">
	<h3>후기 작성</h3>
	<div>
	<form id="reviewUpdateForm" action="${pageContext.request.contextPath }/front"method="post">
		<input type="hidden"name="command"value="ReviewUpdate">
		<!-- 대여목록 페이지에서 후기등록 버튼 생성, rentalNo 정보 hidden값으로 설정해주기 -->
		<input type="hidden"name="reviewNo"value="${requestScope.reviewDetail.reviewNo }">
		<table cellpadding="5">
			<tr>
			<td><span>물품 만족도</span>&nbsp;&nbsp;&nbsp;
	<span class="fa fa-star fa-lg" id="s1" ></span>&nbsp;
	<span class="fa fa-star fa-lg" id="s2" ></span>&nbsp;
	<span class="fa fa-star fa-lg" id="s3" ></span>&nbsp;
	<span class="fa fa-star fa-lg" id="s4" ></span>&nbsp;
	<span class="fa fa-star fa-lg" id="s5" ></span>&nbsp;
			</tr>
			<tr>
			<td><input size="45px"type="text"id="reviewTitle"name="reviewTitle" placeholder="후기 제목을 입력하세요" required="required" value="${requestScope.reviewDetail.reviewTitle }"><br>
		<span id="warningView1"></span></td>
			</tr>
			<tr>
			<td><textarea id="reviewContents"name="reviewContents" rows="10" cols="50" required="required" maxlength="500"placeholder=" 후기 내용을 입력해주세요. 후기와 관계없는 부적합한 게시물은 관리자 확인 후 제한 될 수 있습니다. 최소 10자이상 등록(공백제외) 가능합니다.">${requestScope.reviewDetail.reviewContent }</textarea>
		<br><span id="warningView2"></span></td>
			</tr>
			<tr>
			<td>&nbsp;&nbsp;<input class="btn"type="button"id="cancelBtn"value=" 취소 ">&nbsp;&nbsp;<input class="btn"type="button"id="reviewUpdateBtn"value=" 수정 ">&nbsp;&nbsp;(<span id="totalChar">0</span>/500자)</td>
			</tr>
		</table>
		
	</form>
	</div>
	
</div>
