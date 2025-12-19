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

/* 구분용 점선 */
.dots-row td {
    padding: 5px 0;
    font-size: 1.5rem;
    color: #888;
    border-bottom: none;
    text-align: center;
    letter-spacing: 10px;
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

<% 
    // Controller에서 넘겨준 데이터 가져오기
    List<User> list = (List<User>) request.getAttribute("rankingList");	// DB에서 가져온 랭킹 리스트
    User myUser = (User) request.getAttribute("myUser");	// 내 유저 정보 (DB or 임시)
    Integer myRank = (Integer) request.getAttribute("myRank"); 	// 내 순위

    // 화면 출력용 리스트 생성 (DB 건드리지 않고 작업하기 위해 복사)
    List<User> displayList = new ArrayList<>();
    if (list != null) {
        displayList.addAll(list);
    }

    // 내 랭킹을 화면 리스트에 끼워 넣기
    // DB 업데이트 X => 메모리(displayList)에서만 처리
    if (myUser != null && myRank != null && myRank <= 6) {
        // 이미 리스트에 내가 있는지 확인 (중복 방지)
        boolean isAlreadyIn = false;
        int existingIndex = -1;
        for (int i = 0; i < displayList.size(); i++) {
            if (displayList.get(i).getUserId().equals(myUser.getUserId())) {
                isAlreadyIn = true;
                existingIndex = i;
                break;
            }
        }

        if (isAlreadyIn) {
            // 이미 있다면 최신 정보로 교체
            displayList.set(existingIndex, myUser);
        } else {
            // 리스트에 없다면 내 순위 위치(myRank-1)에 삽입 (뒤는 자동으로 밀림)
            if (displayList.size() >= myRank - 1) {
                displayList.add(myRank - 1, myUser);
            } else {
                displayList.add(myUser);
            }
        }
    }
%>
<%-- 랭킹 테이블 --%>
<div class="rank-box">
    <div class="crown-top">👑</div>
    <table class="rank-table">
        <tr>
            <th>순위</th>
            <th>플레이어</th>
            <th>점수</th>
        </tr>

        <%-- 상단 내 순위 고정 --%>
        <% if (myUser != null) { %>
        <tr class="my-rank">
            <td><%= myRank %></td>
            <td><%= myUser.getName() %></td>
            <td><%= myUser.getScore() %></td>
        </tr>
        
        <%-- 구분용 점선 --%>
        <tr class="dots-row">
            <td colspan="3">···</td>
        </tr>
        <% } %>

        <%-- 상위 6명 출력 --%>
        <% 
        if (displayList != null) {
            int currentRank = 1;
            int previousScore = -1;

            // 6위까지만 출력
            for (int i = 0; i < displayList.size() && i < 6; i++) { 
                User u = displayList.get(i); 
                int score = u.getScore();
             	// 동점자 처리
                if (i > 0) {
                    if (score < previousScore) {
                        currentRank = i + 1;
                    }
                }
                previousScore = score;
        %>
        <tr <%= (currentRank == 1) ? "class='rank-1'" : "" %>>
            <td><%= (currentRank == 1) ? "👑" : currentRank %></td>
            <td><%= u.getName() %></td>
            <td><%= u.getScore() %></td>
        </tr>
        <% 
            } 
        } 
        %>
    </table>
</div>
</body>
</html>
