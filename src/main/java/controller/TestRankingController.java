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
	// GET 요청 오면 실행
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	// 외부에서 정보 보냈다고 가정
        request.setAttribute("GAME_USER_ID", 99);
        request.setAttribute("GAME_USER_NAME", "박보검");
        request.setAttribute("GAME_SCORE", 9900);

        // ranking 컨트롤러로 요청을 넘김
        request.getRequestDispatcher("/ranking").forward(request, response);
    }
}