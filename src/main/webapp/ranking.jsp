<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    background: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5)),
        url("${pageContext.request.contextPath}/assets/first_page.png") no-repeat center center fixed;
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
    filter: url(#squiggle-filter);
}
.my-rank td {
    font-weight: bold;
    color: #ff6b00;
    font-size: 1.8rem;
}

/* 점선 구분 행 스타일 */
.dots-row td {
    padding: 5px 0 !important;
    font-size: 1.5rem;
    color: #888;
    border-bottom: none !important;
    text-align: center;
    letter-spacing: 10px; /* 점 사이 간격 */
}

/* 1등 강조 */
.rank-1 {
    background: #fffacd;
}

.crown-top {
    font-size: 80px;
    margin-bottom: 30px;
}
/* 왕관 아이콘 (1등) */
.crown-icon {
    font-size: 1.5rem;
}
</style>
</head>
<body>
<header class="top-bar">
    <div class="logo">OMOK</div>
    <nav class="menu">
        <ul>
            <li class="active"><a href="RoomList.jsp">HOME</a></li>
            <li>RANK</li>
            <li>HOW</li>
        </ul>
    </nav>
    <!-- 아바타 -->
    <img src="${pageContext.request.contextPath}${player.avatar}" alt="avatar" width="36" height="36">
</header>

<div class="rank-box">
    <div class="crown-top">👑</div>
    <table class="rank-table">
        <tr>
            <th>순위</th>
            <th>플레이어</th>
            <th>점수</th>
        </tr>

        <% 
            // 1. 데이터 가져오기
            List<User> list = (List<User>) request.getAttribute("rankingList"); 
            User myUser = (User) request.getAttribute("myUser"); 
            Integer myRank = (Integer) request.getAttribute("myRank"); 

            // 2. 중요: 원본 리스트를 복사하여 '나'를 원하는 위치에 끼워넣기
            List<User> displayList = new ArrayList<>();
            if (list != null) {
                displayList.addAll(list);
            }

            // 내 순위가 1~6위 사이라면 해당 위치에 나를 끼워넣음
            if (myUser != null && myRank != null && myRank <= 6) {
                // 리스트 인덱스는 0부터 시작하므로 (myRank - 1) 위치에 삽입
                if (displayList.size() >= myRank - 1) {
                    displayList.add(myRank - 1, myUser);
                } else {
                    displayList.add(myUser); // 리스트가 짧으면 맨 뒤에 추가
                }
            }
        %>

        <%-- [A] 상단 내 순위 고정 (무조건 출력) --%>
        <% if (myUser != null) { %>
        <tr class="my-rank">
            <td><%= myRank %></td>
            <td><%= myUser.getName() %></td>
            <td><%= myUser.getScore() %></td>
        </tr>
        
        <tr class="dots-row">
        	<td colspan="3">...</td>
        </tr>
        <% } %>

        <%-- [B] 리스트 순회 (나를 포함하여 순서대로 출력) --%>
        <% 
        if (displayList != null) {
            int currentRank = 1;      // 현재 표시할 순위
            int sameScoreCount = 0;   // 동점자 수 카운트
            int previousScore = -1;   // 이전 사람의 점수 저장

            for (int i = 0; i < displayList.size() && i < 6; i++) { 
                User u = displayList.get(i); 
                int score = u.getScore();

                // 순위 계산 로직
                if (i > 0) {
                    if (score < previousScore) {
                        // 점수가 낮아지면, 지금까지 쌓인 동점자 수만큼 순위를 점프
                        currentRank = i + 1;
                    }
                    // 점수가 같으면 currentRank를 그대로 유지 (동점 처리)
                }
                
                previousScore = score; // 다음 비교를 위해 현재 점수 저장
	    %>
	    <tr <%= (currentRank == 1) ? "class='rank-1'" : "" %>>
	        <%-- 1등이면서 점수가 같을 수도 있으니 조건 체크 --%>
	        <td>
	            <% if (currentRank == 1) { %> 👑 <% } 
	               else { %> <%= currentRank %> <% } %>
	        </td>
	        <td><%= u.getName() %></td>
	        <td><%= u.getScore() %></td>
	    </tr>
        <% 
			} } 
        %>
    </table>
	</div>
</body>
</html>
