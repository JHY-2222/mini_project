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

@WebServlet("/ranking")
public class RankingController extends HttpServlet {
	
	private RankingService service = new RankingService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 유저 정보 게임 로직에서 받았다고 가정
			String userId = (String) request.getAttribute("GAME_USER_ID");
			Integer score = (Integer) request.getAttribute("GAME_SCORE");

			// DB 랭킹 조회
            List<User> dbList = service.showRanking();
            
            User myUser = null;
            if (userId != null && score != null) {
                myUser = service.createMyUser(userId, score);
            }

            // 중복이 제거되고 내 최신 정보가 포함된 최종 리스트 생성
            List<User> mergedList = service.mergeAndSort(dbList, myUser);

            // [순위 찾기] 최종 리스트에서 내가 몇 번째 인덱스에 있는지 확인
            Integer myRank = null;
            if (myUser != null) {
                for (int i = 0; i < mergedList.size(); i++) {
                    if (mergedList.get(i).getUserId().equals(userId)) {
                        myRank = i + 1; // 인덱스는 0부터이므로 +1
                        break;
                    }
                }
            }
            request.setAttribute("rankingList", mergedList);
            request.setAttribute("myUser", myUser);
            request.setAttribute("myRank", myRank);

            request.getRequestDispatcher("/ranking.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
