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
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("GAME_USER_ID", 5);        // 🔴 숫자 ID
        request.setAttribute("GAME_USER_NAME", "박철수");  // 🔴 이름
        request.setAttribute("GAME_SCORE", 1200);

        request.getRequestDispatcher("/ranking").forward(request, response);
    }
}