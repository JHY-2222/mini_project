<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="domain.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RANK</title>

<style>
    body {
        margin: 0;
        font-family: 'Comic Sans MS', cursive; /* 폰트 통일 */
        background: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5)), /* 배경 불투명 */
                    url("${pageContext.request.contextPath}/assets/first_page.png")
                    no-repeat center center fixed;
        background-size: cover;
        min-height: 100vh;
        padding-top: 80px; /* 상단 메뉴바 공간 확보 */
    }

    /* 상단 메뉴바 */
    .nav {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 60px;
        padding: 20px 0;
        background: rgba(255, 255, 255);
        border-bottom: 1px solid #ddd;
        z-index: 1000;
        /* 지글지글 효과 */
        filter: url(#squiggle-filter);
    }

    .logo-text {
        font-weight: 900;
        font-style: italic;
        font-size: 1.5rem;
        color: #000;
        margin-right: 50px;
        font-family: 'Comic Sans MS', cursive;
    }

    .nav a {
        text-decoration: none;
        color: #555;
        font-weight: bold;
        font-size: 1.1rem;
        font-family: 'Comic Sans MS', cursive;
    }

    .nav a.active {
        color: #85BE57;
    }

    .profile-img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        cursor: pointer;
        margin-left: 30px;
    }

    /* 랭킹 박스 */
    .rank-box {
        width: 70%;
        max-width: 700px;
        background: white;
        margin: 40px auto;
        padding: 40px;
        border-radius: 30px;
        text-align: center;
        /* 지글지글 효과 */
        filter: url(#squiggle-filter);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    /* 랭킹 테이블 */
    .rank-table {
        width: 100%;
        border-collapse: collapse;
        font-family: 'Comic Sans MS', cursive;
    }

    /* 테이블 헤더 */
    .rank-table th {
        background: #8bc34a;
        color: white;
        padding: 15px;
        font-size: 1.2rem;
        font-weight: bold;
        /* 테이블 헤더에도 지글지글 효과 */
        filter: url(#squiggle-filter);
    }

    /* 테이블 셀 */
    .rank-table td {
        padding: 15px;
        border-bottom: 2px solid #eee;
        font-size: 1.1rem;
        color: #333;
    }

    /* 내 순위 강조 */
    .my-rank {
        background: #fff4e6;
        border: 3px solid #ff9800;
        /* 지글지글 효과 */
        filter: url(#squiggle-filter);
    }

    .my-rank td {
        font-weight: bold;
        color: #ff6b00;
    }

    /* 1등 강조 */
    .rank-1 {
        background: #fffacd;
    }

    /* 순위 번호 스타일 */
    .rank-number {
        font-size: 1.3rem;
        font-weight: bold;
    }

	.crown-top {
	    font-size: 80px;        /* 기존 이미지 크기와 비슷하게 */
	    margin-bottom: 30px;
	}
    /* 왕관 아이콘 (1등) */
    .crown-icon {
        font-size: 1.5rem;
    }

    /* 프로필 이미지 (테이블 안) */
    .player-img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        vertical-align: middle;
        margin-right: 8px;
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

	<nav class="nav">
	    <span class="logo-text">OMOK</span>
	    <a href="room">HOME</a>
	    <a class="active">RANK</a>
	    <a href="how">HOW</a>
	    <a href="UserSet" target="_blank">
	        <img src="${pageContext.request.contextPath}/assets/profile_img.png" 
	             alt="Profile" 
	             class="profile-img">
	    </a>
	</nav>
	<div class="rank-box">
	    <div class="crown-top">👑</div>
	
	    <table class="rank-table">
	        <tr>
	            <th>순위</th>
	            <th>플레이어</th>
	            <th>점수</th>
	        </tr>
	
	        <%
	            List<User> list = (List<User>)request.getAttribute("rankingList");
		        if(list == null) {
		            list = new java.util.ArrayList<>(); // null이면 빈 리스트로 초기화
		        }    
	        
	        String currentUserId = (String)session.getAttribute("USER_ID"); // 현재 로그인한 사용자 ID
	            
	            // 내 순위 찾기
	            User myUser = null;
	            int myRank = -1;
	            for(int i = 0; i < list.size(); i++) {
	                if(list.get(i).getUserId().equals(currentUserId)) {
	                    myUser = list.get(i);
	                    myRank = i + 1;
	                    break;
	                }
	            }
	            
	            // 내 순위 먼저 출력
	            if(myUser != null) {
	        %>
	        <tr class="my-rank">
	            <td class="rank-number"><%= myRank %></td>
	            <td><%= myUser.getName() %></td>
	            <td><%= myUser.getScore() %></td>
	            <td>100%</td>
	        </tr>
	        <% } %>
	
	        <%
	            // 1위부터 6위까지 출력 (내 순위 제외)
	            int count = 0;
	            for(int i = 0; i < list.size() && count < 6; i++) {
	                User u = list.get(i);
	                // 내 순위는 이미 출력했으므로 건너뜀
	                if(myUser != null && u.getUserId().equals(currentUserId)) {
	                    continue;
	                }
	                count++;
	                int rank = i + 1;
	                String rowClass = (rank == 1) ? "rank-1" : "";
	        %>
	        <tr class="<%= rowClass %>">
	            <td class="rank-number">
	                <%= (rank == 1) ? "<span class='crown-icon'>👑</span>" : rank %>
	            </td>
	            <td><%= u.getName() %></td>
	            <td><%= u.getScore() %></td>
	        </tr>
	        <% } %>
	    </table>
	</div>
</body>
</html>