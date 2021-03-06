<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css?ver=1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css?ver=1">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css?ver=1">
<!-- <link rel="stylesheet" 	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css?ver=1"> -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">	<!-- 180904 MIRI 추가 -->

<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath }/template/portfolio/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath }/template/portfolio/css/2-col-portfolio.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" /> -->


<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script -->

<!--------------------------------------------------------->  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> 
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" ></script>
<!------------------------------------------------->
<title>Borrow빌리다</title>
</head>
<body>
<div id="MyContainer">
<div class="row">
	<c:import url="/template/menubar.jsp"/>
</div>
<div class="row">
	<c:import url="/template/header.jsp"/>
</div>
<div class="row">
	<c:import url="/template/category.jsp"/>
</div>
<div class="row">
		<c:import url="${requestScope.url }"/>
</div>
<div class="row footer">
	<c:import url="/template/footer.jsp"/>
</div>
</div>
</body>
</html>