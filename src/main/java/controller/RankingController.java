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
			// DB에서 score 기준으로 랭킹 조회
			List<User> list = service.showRanking();
			
			// 디버깅용 로그 추가
			System.out.println("랭킹 리스트 크기: " + (list != null ? list.size() : "null"));
			
			// JSP로 전달
			request.setAttribute("rankingList", list);
			request.getRequestDispatcher("/ranking.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			// 에러 발생 시에도 빈 리스트라도 전달
			request.setAttribute("rankingList",new ArrayList<User>());
			request.getRequestDispatcher("/ranking.jsp").forward(request, response);
		}
	}
}
