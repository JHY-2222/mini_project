package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;
import service.RankingService;

@WebServlet("/testRanking")
public class TestRankingController extends HttpServlet {
    
    private RankingService service = new RankingService();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
	        try {
	            // ⭐ 테스트용 DB 랭킹 리스트 (실제론 DB에서 가져온 것처럼)
	            List<User> dbList = new ArrayList<>();
	           
	            // ⭐ 내 정보 (게임 결과)
	            String userId = "김철수";
	            Integer score = 500;
	            
	            // ⭐ 게임 로직에서 받았다고 가정하고 setAttribute로 전달
	            request.setAttribute("GAME_USER_ID", userId);
	            request.setAttribute("GAME_SCORE", score);
	            request.setAttribute("TEST_DB_LIST", dbList); // 테스트용 DB 리스트도 전달
	            
	            // ⭐ RankingController로 forward
	            request.getRequestDispatcher("/ranking").forward(request, response);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
        }
    }
}