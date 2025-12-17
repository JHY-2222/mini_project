<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OMOK</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/style.css">

<style>
    body {
	    margin: 0;
	    font-family: 'Arial';
        background: url("${pageContext.request.contextPath}/assets/first_page.png")
                    no-repeat center center fixed;
        background-size: cover;
        height: 100vh;
    }
</style>

</head>
<body>
	<div class="main-container">
	   <div class="btn-group">
	       <a href="${pageContext.request.contextPath}/room"
	          class="btn primary">GAME START</a>
	
	       <a href="${pageContext.request.contextPath}/login"
	          class="btn">LOGIN</a>
    	</div>
	</div>
</body>
</html>