<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="domain.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>RANK</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<body class="rank-bg">

<nav class="nav">
    <span class="logo-text">OMOK</span>
    <a href="main">HOME</a>
    <a class="active">RANK</a>
    <a href="how">HOW</a>
</nav>

<div class="rank-box">
    <img src="assets/crown.png" class="crown">

    <table class="rank-table">
        <tr>
            <th>순위</th>
            <th>플레이어</th>
            <th>돌 개수</th>
            <th>승률</th>
        </tr>

        <%
            List<User> list =
                (List<User>)request.getAttribute("rankingList");
            int rank = 1;
            for(User u : list) {
        %>
        <tr>
            <td><%= rank++ %></td>
            <td>@ <%= u.getName() %></td>
            <td><%= u.getScore() %></td>
            <td>100%</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>