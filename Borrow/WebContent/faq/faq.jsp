<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">

var main_cnt = 5 //주 메뉴 갯수

function showhide(num)    {
	
	for (i=1; i<=main_cnt; i++)   {  
		menu=eval("document.all.block"+i+".style");

		if (num == i) {
			if (menu.display == "block") {
				menu.display="none";
			} else {
				menu.display="block";
			}
		} else {
			menu.display="none";
		}
	}
}
</script>
<style>

h3 {
    text-align: center;
   	padding:20px;
}
table{
	text-align: center;
}
.bgheader {
	height: 160px;
}
</style>
<div class="col-sm-12 bgheader"></div>
<div class="container">
<h3>자주 묻는 질문(FAQ)</h3>
	<table class="table table-hover table table-bordered">
		<tr class="table-primary">
			<td><div align="center">
					<a href="javascript:showhide('1');">물품 등록은 어떻게 하나요?<br></a>
				</div></td>
		</tr>
		<tr>
			<td>
				<div align="center">
					<SPAN id=block1 style="DISPLAY: none; xCURSOR: hand">
						로그인 후 마이페이지에서 내 물품 등록하시면 됩니다.									
					</span>
				</div>
			</td>
		</tr>
		<tr class="table-success">
			<td>
				<div align="center">
					<a href="javascript:showhide('2');">대여 어떻게 하나요?<br></a>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div align="center">
					<SPAN id=block2 style="DISPLAY: none; xCURSOR: hand">
						원하는 상품 게시글에서 대여 일자 설정하시고 대여하기 누르면 됩니다.
					</span>
				</div>
			</td>
		</tr>
		<tr class="table-info">
			<td><div align="center">
					<a href="javascript:showhide('3');">대여 취소 어떻게 하나요?<br></a>
				</div></td>
		</tr>
		<tr>
			<td>

				<div align="center">

					<SPAN id=block3 style="DISPLAY: none; xCURSOR: hand">
						마이페이지 -> 내 대여 목록에서 대여 취소 누르시면 됩니다.
					</span>

				</div>

			</td>
		</tr>
		<tr class="table-secondary">
			<td><div align="center">
					<a href="javascript:showhide('4');">월 매출 얼마에요?<br></a>
				</div></td>
		</tr>
		<tr>
			<td>

				<div align="center">

					<SPAN id=block4 style="DISPLAY: none; xCURSOR: hand">
						비밀입니다.
					</span>

				</div>
			</td>
		</tr>
		<tr class="table-danger">
			<td><div align="center">
					<a href="javascript:showhide('5');">대여해준 물품 파손 시 어떻게 해야 하나요?<br></a>
				</div></td>
		</tr>
		<tr>
			<td>

				<div align="center">

					<SPAN id=block5 style="DISPLAY: none; xCURSOR: hand">
						경찰에 신고하세요.
					</span>

				</div>

			</td>
		</tr>
	</table>
</div>