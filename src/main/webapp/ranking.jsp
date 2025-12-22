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
    padding: 16px;
    border-bottom: 2px solid #eee;
    font-size: 1.4rem;
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
            <li><a href="RoomList.jsp">HOME</a></li>
            <li class="active"><a href="ranking">RANK</a></li>
            <li><a href="howTo.jsp">HOW</a></li>
        </ul>
    </nav>

    <!-- 아바타 -->
    <img src="${pageContext.request.contextPath}${player.avatar}"
    		onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'"
    		alt="avatar" width="36" height="36">
</header>


<% 
    // Controller가 저장해준 전체 랭킹 리스트 꺼내기
    List<User> list = (List<User>) request.getAttribute("rankingList"); 
	//Controller가 저장해준 내 유저 정보 객체 꺼내기
    User myUser = (User) request.getAttribute("myUser"); 
 	// Controller가 저장해준 내 순위 숫자 꺼내기
    Integer myRank = (Integer) request.getAttribute("myRank"); 

    // 화면 출력용 리스트 생성 (DB 데이터 복사, 원본 유지 목적)
    List<User> displayList = new ArrayList<>();
    if (list != null) {
        displayList.addAll(list);
    }

    // 내 정보(게스트 포함)를 리스트에 실제로 삽입하여 순위를 재구성
    if (myUser != null && myRank != null) {
    	// 내가 이미 리스트에 있는지 체크할 변수
        boolean isAlreadyIn = false;
        // 이름 기준으로 리스트에 내가 이미 포함되어 있는지 검사 (중복 방지)
        for (User u : displayList) {
            if (u.getNickname().equals(myUser.getNickname())) {
                isAlreadyIn = true;	// 이미 있으면 추가 안 함
                break;
            }
        }

        // 리스트에 내가 없다면 (게스트라면)
        if (!isAlreadyIn) {
            int insertIndex = myRank - 1; // 순위는 1부터 시작하므로 index는 -1
         	// 리스트 범위 안이라면 해당 위치에 '나'를 강제로 삽입 (뒤에 사람들은 자동으로 밀림)
            if (insertIndex >= 0 && insertIndex <= displayList.size()) {
                displayList.add(insertIndex, myUser);
            } else {
            	// 꼴찌면 리스트 맨 마지막에 추가
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
            <td><%= myUser.getNickname() %></td>
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
            <td><%= u.getNickname() %></td>
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