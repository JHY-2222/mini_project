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
        font-family: 'Arial';
        background: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5)), /* 배경 불투명 */
                    url("${pageContext.request.contextPath}/assets/first_page.png")
                    no-repeat center center fixed;
        background-size: cover;
        min-height: 100vh;
        padding-top: 80px;
    }
    
	.top-bar {
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
	    gap: clamp(40px, 10vw, 300px);;
	    padding-right: 100px;
	}
	
	.menu li {
	    cursor: pointer;
	    font-weight: 600;
	    font-size: 20px;
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
    }

    /* 랭킹 테이블 */
    .rank-table {
        width: 100%;
        border-collapse: collapse;
        font-family: 'Arial';
        font-weight: bold;
    }

    /* 테이블 헤더 */
    .rank-table th {
        background: #8bc34a;
        color: white;
        padding: 15px;
        font-size: 1.2rem;
        font-weight: bold;
    }

    /* 테이블 셀 */
    .rank-table td {
        padding: 15px;
        border-bottom: 2px solid #eee;
        font-size: 1.1rem;
        color: #000000;
    }

    /* 내 순위 강조 */
    .my-rank {
        background: #fff4e6;
        border: 5px solid #ff9800;
        /* 지글지글 효과 */
        filter: url(#squiggle-filter);
    }

    .my-rank td {
        font-weight: bold;
        color: #ff6b00;
        font-size: 1.8rem;
    }

    /* 1등 강조 */
    .rank-1 {
        background: #fffacd;
    }

    /* 순위 번호 스타일 */
    .rank-number {
        font-size: 1.3rem;
        font-weight: bold;
        padding-bottom: 2px
    }

	.crown-top {
	    font-size: 80px;        /* 기존 이미지 크기와 비슷하게 */
	    margin-bottom: 30px;
	}
    /* 왕관 아이콘 (1등) */
    .crown-icon {
        font-size: 1.5rem;
    }
    
	a,
	a:visited,
	a:hover,
	a:active {
	    color: inherit;
	    text-decoration: none;
	}

</style>
</head>
<body>
	<header class="top-bar">
	    <div class="logo">OMOK</div>
	    <nav class="menu">
	        <ul>
	            <li><a href="RoomList.jsp">HOME</a></li>
	            <li>RANK</li>
	            <li>HOW</li>
	        </ul>
	    </nav>
	</header>
	
	<div class="rank-box">
	    <div class="crown-top">👑</div>
		<%-- Controller에서 setAttribute로 보낸 값 받는 부분 --%>
	    <%
	        List<User> list = (List<User>) request.getAttribute("rankingList");
	        User myUser = (User) request.getAttribute("myUser");
	        Integer myRank = (Integer) request.getAttribute("myRank");
	    %>
	
	    <table class="rank-table">
	        <tr>
	            <th>순위</th>
	            <th>플레이어</th>
	            <th>점수</th>
	        </tr>
	
	        <%-- 내 순위 (없으면 NULL) --%>
	        <% if (myUser != null && myRank != null) { %>
	        <tr class="my-rank">
	            <td class="rank-number"><%= myRank %></td>
	            <td><%= myUser.getName() %></td>
	            <td><%= myUser.getScore() %></td>
	        </tr>
	        <% } %>
	
	        <%-- DB 1~6위 출력 --%>
	        <%
	            for (int i = 0; i < list.size() && i < 6; i++) {
	                User u = list.get(i);
	        %>
	        <tr class="<%= (i == 0) ? "rank-1" : "" %>">
	            <td><%= (i == 0) ? "👑" : (i + 1) %></td>
	            <td><%= u.getName() %></td>
	            <td><%= u.getScore() %></td>
	        </tr>
	        <% } %>
	    </table>
	</div>
</body>
</html>