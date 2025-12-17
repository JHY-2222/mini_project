<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 방법</title>
<link rel="stylesheet" href="style.css">

<style>
    body {
	    margin: 0;
	    font-family: 'Malgun Gothic', 'Arial', sans-serif;;
        background: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5)) /*배경 불투명*/
        			,url("${pageContext.request.contextPath}/assets/first_page.png")
                    no-repeat center center fixed;
        background-size: cover;
        
        
        /* 화면 정중앙 박스를 놓기 위한 flex 설정 */
        display: flex;
        justify-content: center; /* 가로 중앙 */
        align-items: center;     /* 세로 중앙 */
        height: 100vh;           /* 전체 화면 높이 사용 */
        overflow: hidden; /* 화면 크기 조절 시 스크롤 방지 */
    }
    
    /* 상단 메뉴바*/
    .nav {
        position: fixed; /* 상단 고정 */
        top: 0;
        left: 0;
        width: 100%;
        display: flex;
        justify-content: center; /* 메뉴들을 가로 중앙으로 */
        align-items: center;
        gap: 60px;               /* 메뉴 사이 간격 */
        padding: 20px 0;
        background: rgba(255, 255, 255); /* 흰색 배경 */
        border-bottom: 1px solid #ddd;       /* 하단 얇은 구분선 */
        z-index: 1000;
    }
    
    /* 로고 텍스트 (OMOK) */
    .logo-text {
        font-weight: 900;       /* 아주 굵게 */
        font-style: italic;     /* 기울임꼴 */
        font-size: 1.5rem;
        color: #000;
        margin-right: 50px;     /* 로고와 메뉴 사이 거리 */
    }

    /* 메뉴 링크들 */
    .nav a {
        text-decoration: none;
        color: #555;
        font-weight: bold;
        font-size: 1.1rem;
    }

    /* 활성화된 메뉴 (HOW) */
    .nav a.active {
        color: #85BE57; 
    }

    /* 3. 게임 방법 흰색 박스 (이미지 중앙 박스) */
    .how-box {
        background-color: #ffffff; /* 순백색 배경 */
        
        width: 70%;              /* 박스 너비 */
        max-width: 800px; /* PC에서 너무 퍼져 보이지 않게 제한 */
        min-width: 320px; /* 모바일에서 너무 좁아지지 않게 제한 */
        
        min-height: 60vh;   /* 화면 높이의 60%를 최소 높이로 설정 (박스가 길어짐) */
        
        padding: 5vh 5vw;;        /* 내부 여백 (위아래 좌우) */
        border-radius: 30px;       /* 모서리를 아주 둥글게 */
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
        text-align: left;          /* 텍스트 왼쪽 정렬 */
    }

    /* 박스 제목 (게임 방법) */
    .how-box h2 {
        font-size: 2.5rem;         /* 글자 크기 */
        font-weight: bold;
        margin-top: 0;
        margin-bottom: 3vh;
        color: #000;
        text-align: left;
    }

    .how-box ol {
        padding-left: 30px;
        margin: 0;
    }

    .how-box ol li {
        font-size: 1.5rem;         /* 글자 크기 확대 */
        line-height: 2.2;           /* 줄 간격 넉넉하게 */
        color: #333;
        font-weight: 600;
    }
</style>

</head>
<body>
<nav class="nav">
    <span class="logo-text">OMOK</span>
    <a href="room">HOME</a>
    <a href="ranking">RANK</a>
    <a class="active">HOW</a>
</nav>

<div class="how-box">
    <h2>게임 방법</h2>
    <ol>
        <li>플레이어는 번갈아 돌을 둡니다</li>
        <li>가로 / 세로 / 대각선 5목 완성 시 승리</li>
        <li>상대 턴에는 돌을 둘 수 없습니다</li>
        <li>승리 시 점수가 랭킹에 반영됩니다</li>
    </ol>
</div>
</body>
</html>