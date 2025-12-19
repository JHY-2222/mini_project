package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
//import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;
import service.RankingService;

@WebServlet("/ranking")
public class RankingController extends HttpServlet {
	
	 // 서비스 객체 생성
    private RankingService service = new RankingService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 외부에서 전달받은 값
            Integer userIdInt = (Integer) request.getAttribute("GAME_USER_ID");	// getAttribute()로 받으면 String으로 받아져서 형변환
            String userId = (userIdInt != null) ? String.valueOf(userIdInt) : null;	// DB 조회용으로 String 변환
            String userName = (String) request.getAttribute("GAME_USER_NAME");
            Integer gameScore = (Integer) request.getAttribute("GAME_SCORE");

            // DB에서 랭킹 목록 조회 (서비스 로직 실행)
            List<User> rankingList = service.showRanking();
            
            // 내 정보 & 순위 계산
            if (userId != null) {
            	// 서비스에서 내 정보 + 내 순위 한 번에 처리
                Map<String, Object> rankingInfo = service.getUserRankingInfo(userId, userName, gameScore, rankingList);
                // JSP로 전달
                request.setAttribute("myUser", rankingInfo.get("myUser"));
                request.setAttribute("myRank", rankingInfo.get("myRank"));
            }

            // JSP로 전달
            request.setAttribute("rankingList", rankingList);
            // ranking.jsp로 화면 이동
            request.getRequestDispatcher("/ranking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}