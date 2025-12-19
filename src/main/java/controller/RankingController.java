package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;
import service.RankingService;

@WebServlet("/ranking")
public class RankingController extends HttpServlet {

    private RankingService service = new RankingService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 게임 후 결과 받았다고 가정
        	Integer userIdInt = (Integer) request.getAttribute("GAME_USER_ID");
            String userId = (userIdInt != null) ? String.valueOf(userIdInt) : null;
            
            String userName = (String) request.getAttribute("GAME_USER_NAME");
            
            // 🔴 GAME_SCORE도 Integer 객체로 받아 언박싱
            Integer scoreObj = (Integer) request.getAttribute("GAME_SCORE");
            int gainedScore = (scoreObj != null) ? scoreObj : 0;

            User myUser = null;
            int myRank = -1;

            // 랭킹 조회
            List<User> rankingList = service.showRanking();

            // 게임 결과가 있으면 처리
            if (userId != null) {
            	// myUser = processGameResult 호출
            	myUser = service.processGameResult(userId, gainedScore, userName);
            	// 랭킹 계산
                myRank = service.calculateRank(rankingList, myUser);
                
            }

            // JSP 전달
            request.setAttribute("rankingList", rankingList);
            request.setAttribute("myUser", myUser);
            request.setAttribute("myRank", myRank);
            request.getRequestDispatcher("/ranking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
