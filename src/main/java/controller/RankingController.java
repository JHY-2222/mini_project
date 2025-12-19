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
            // 1. 전달받은 ID와 이름 가져오기
            Integer userIdInt = (Integer) request.getAttribute("GAME_USER_ID");
            String userId = (userIdInt != null) ? String.valueOf(userIdInt) : null;
            String userName = (String) request.getAttribute("GAME_USER_NAME");

            // 2. 랭킹 리스트 조회 (DB에서 현재 점수 상태 그대로 가져옴)
            List<User> rankingList = service.showRanking();

            User myUser = null;
            int myRank = -1;

            // 3. 🔴 점수 업데이트 없이 '조회'만 수행
            if (userId != null) {
                // DB에서 해당 유저의 정보를 단순히 찾아오기만 함 (score 업데이트 X)
                myUser = service.findUser(userId); 
                
                // 만약 DB에 없는 유저(게스트)라면 전달받은 이름과 점수로 임시 객체 생성
                if (myUser == null) {
                    myUser = new User();
                    myUser.setUserId(userId);
                    myUser.setName(userName);
                    Integer scoreObj = (Integer) request.getAttribute("GAME_SCORE");
                    myUser.setScore(scoreObj != null ? scoreObj : 0);
                }
                
                // 내 순위 계산
                myRank = service.calculateRank(rankingList, myUser);
            }

            // 4. JSP 전달
            request.setAttribute("rankingList", rankingList);
            request.setAttribute("myUser", myUser);
            request.setAttribute("myRank", myRank);
            request.getRequestDispatcher("/ranking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
