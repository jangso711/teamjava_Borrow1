<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
h3 {
	align-content:center;
	align-items: center;
	text-align:center;
	font-weight: bold;
	padding-bottom:10px;
	padding-top:10px;
}
table{
	text-align: center;
}
.bgheader {
	height: 50px;
}
</style>
<div class="container">
  <h3>자주 묻는 질문(FAQ)</h3>
  <div id="accordion">
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseOne">
      		    물품 등록은 어떻게 하나요?
        </a>
      </div>
      <div id="collapseOne" class="collapse" data-parent="#accordion">
        <div class="card-body">
          	로그인 후 마이페이지에서 내 물품 등록하시면 됩니다.	
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
      	  대여 어떻게 하나요?
      </a>
      </div>
      <div id="collapseTwo" class="collapse" data-parent="#accordion">
        <div class="card-body">
        	 원하는 상품 게시글에서 대여 일자 설정하시고 대여하기 누르면 됩니다.
         </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
      	    대여 취소 어떻게 하나요?
        </a>
      </div>
      <div id="collapseThree" class="collapse" data-parent="#accordion">
        <div class="card-body">
          	마이페이지 -> 내 대여 목록에서 대여 취소 누르시면 됩니다.
          </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseFour">
       	   월 매출 얼마에요?
        </a>
      </div>
      <div id="collapseFour" class="collapse" data-parent="#accordion">
        <div class="card-body">
         	비밀입니다.
         	 </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header">
        <a class="collapsed card-link" data-toggle="collapse" href="#collapseFive">
          대여해준 물품 파손 시 어떻게 해야 하나요?
        </a>
      </div>
      <div id="collapseFive" class="collapse" data-parent="#accordion">
        <div class="card-body">
          	경찰에 신고하세요.
        </div>
      </div>
    </div>
  </div>
</div>