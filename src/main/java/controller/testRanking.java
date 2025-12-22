package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/testRanking")
public class testRanking extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	/*
    	// 게스트인 경우   	
        String userName = "게스트-미미";
        Integer score = 130;
    	*/
    	
    	/*
        // 회원인 경우(1~6순위 안) 
        String userName = "박민수";
        Integer score = 95; 
        */
    	
    	
        //회원인 경우(6순위 밖) 
        String userName = "박지훈";
        Integer score = 5; 
        

        // 2. RankingController가 기대하는 이름(Key)으로 데이터 세팅
        request.setAttribute("GAME_USER_NAME", userName);
        request.setAttribute("GAME_SCORE", score);

        System.out.println("테스트 데이터 전송:" + userName);

        // 3. 질문자님이 만든 RankingController(/ranking)로 정보를 실어서 보냄
        // 리다이렉트가 아니라 'forward'를 써야 Attribute가 유지됩니다.
        request.getRequestDispatcher("/ranking").forward(request, response);
    }
}