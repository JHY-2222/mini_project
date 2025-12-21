<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임 방법</title>

<style>
* {
    box-sizing: border-box;
}

a,
a:visited,
a:hover,
a:active {
    color: inherit;
    text-decoration: none;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;

    background:
        linear-gradient(rgba(225,225,225,0.7), rgba(225,225,225,0.7)),
        url("${pageContext.request.contextPath}/img/back.png");
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
    background-attachment: fixed;
}

/* ===== top bar ===== */
.top-bar {
    width: 100%;
    background: #fff;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

.logo {
    font-size: 24px;
    font-weight: 800;
    padding-left: 50px;
}
.menu ul {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
    gap: clamp(40px, 10vw, 300px);
    padding-right: 100px;
}
.menu li {
    cursor: pointer;
    font-weight: 600;
    font-size: 20px;
}
.menu li.active {
    color: #5483B9;
}

    /* 게임 방법 흰색 박스 */
    .how-box {
        background-color: #ffffff; /* 순백색 배경 */
        
        width: 70%;              /* 박스 너비 */
        max-width: 700px; /* PC에서 너무 퍼져 보이지 않게 제한 */
        margin: 40px auto;	/* 가운데 정렬 핵심 */
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
        font-family: 'Arial';
        letter-spacing: 2px; /* 글자 간격 추가 */
    }

	/* 서브 제목 (오목 규칙, 난이도 등) */
	.how-box h3 {
	    font-size: 1.8rem;
	    color: #444;
	    margin-top: 2rem;
	    margin-bottom: 1rem;
	}
	
	.how-box ol {
	    padding-left: 30px;
	    margin: 0;
	}
	
	.how-box ol li {
	    font-size: 1.4rem; /* 약간 조정하여 가독성 높임 */
	    line-height: 2.0;
	    color: #333;
	    font-weight: 600;
	    font-family: 'Arial';
	    letter-spacing: 1px;
	}
	
	.description {
	    font-size: 1.2rem;
	    color: #666;
	    line-height: 1.6;
	    margin-top: 10px;
	    font-family: 'Arial';
	}
	
	/* 난이도 배지 스타일 */
	.mode-container {
	    display: flex;
	    gap: 15px;
	    margin-top: 10px;
	}
	
	.mode-badge {
	    padding: 8px 15px;
	    border-radius: 8px;
	    font-weight: bold;
	    font-size: 1.1rem;
	    color: #fff;
	}
	
	.mode-badge.normal {
	    background-color: #4a90e2; /* 파란색 (일반) */
	}
	
	.mode-badge.pro {
	    background-color: #e94e77; /* 빨간색 (고수) */
	}
	
	/* 강조 텍스트 */
	strong {
	    color: #000;
	    text-decoration: underline;
	}
</style>

</head>
<body>
<header class="top-bar">
    <div class="logo">OMOK</div>

    <nav class="menu">
        <ul>
            <li><a href="RoomList.jsp">HOME</a></li>
            <li><a href="ranking">RANK</a></li>
            <li class="active"><a href="howTo.jsp">HOW</a></li>
        </ul>
    </nav>

    <!-- 아바타 -->
    <img src="${pageContext.request.contextPath}${player.avatar}"
    		onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'"
    		alt="avatar" width="36" height="36">
</header>
	
	<div class="how-box">
	    <h2>🎮 게임 방법</h2>
	    <h3>오목 규칙</h3>
	    <ol>
	        <li>플레이어는 번갈아 돌⚫⚪을 둡니다</li>
	        <li>가로 / 세로 / 대각선 5목 완성 시 승리</li>
	        <li>상대 턴에는 돌을 둘 수 없습니다</li>
	        <li>승리 시 점수가 랭킹에 반영됩니다</li>
	    </ol>
		<div class="info-section">
		        <h3>⏱️ 난이도 선택</h3>
		        <div class="mode-container">
		            <span class="mode-badge normal">60초 모드 (일반)</span>
		            <span class="mode-badge pro">30초 모드 (고수)</span>
	        	</div>
	        	<p class="description">제한 시간 내에 두지 못하면 패배할 수 있으니 주의하세요!</p>
	    </div>
	
	    <div class="info-section">
	        <h3>🏆 랭킹 시스템</h3>
	        <p class="description"><strong>회원가입 후</strong> 플레이 시 승리 점수가 기록됩니다. <br> 전 세계 유저들과 순위를 겨뤄보세요!</p>
	    </div>
	</div>
</body>
</html>