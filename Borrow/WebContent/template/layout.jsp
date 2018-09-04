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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <!--------------------------------------------------------->  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script> 
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
  <!--------------------------------------------------------->  
<title>Borrow빌리다</title>
</head>
<body>
<div class="row">
	<c:import url="/template/menubar.jsp"/>
</div>
<div class="row">
	<c:import url="/template/header.jsp"/>
</div>
<div class="row">
		<c:import url="${requestScope.url }"/>
</div>
<div class="row footer">
	<c:import url="/template/footer.jsp"/>
</div>
</body>
</html>