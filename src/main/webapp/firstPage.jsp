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
    
    .main-container {
	    position: absolute;
	    bottom: 80px;
	    left: 50%;
	    transform: translateX(-50%);
	    text-align: center;
    }
    
    .btn-group {
        display: flex;
        gap: 20px;
        justify-content: center;
    }
        
    /* 버튼 스타일 변경 */
	.btn {
		background: #fff;
        padding: 15px 40px;
        text-decoration: none;
        color: #333;
        
	    width: 400px; /* 너비 설정 */
	    height: 50px; /* 높이 설정 */
	    border-radius: 15px; /* 모서리 반경 */
	    border: 3px solid #808080; /* 회색 테두리 */
	    font-family: 'Comic Sans MS', cursive; /* 폰트 변경 */
	    font-size: 32px; /* 폰트 크기 */
	    font-weight: bold; /* 굵게 */
	    position: relative;
	    /* 지글지글 효과를 위한 애니메이션 */
	    filter: url(#squiggle-filter);
	}



</style>

</head>
<body>
	<!-- 지글지글 효과를 위한 SVG 필터 -->
	<svg style="position: absolute; width: 0; height: 0;">
	    <defs>
	        <filter id="squiggle-filter">
	            <feTurbulence baseFrequency="0.02" numOctaves="3" seed="2" />
	            <feDisplacementMap in="SourceGraphic" scale="3" />
	        </filter>
	    </defs>
	</svg>
	
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