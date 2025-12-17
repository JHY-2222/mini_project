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

@WebServlet("/testRanking")
public class TestRankingController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 테스트용 사용자 세션
            request.getSession().setAttribute("USER_ID", "testUser01");

            // 테스트용 임시 랭킹 리스트
            List<User> list = new ArrayList<>();
            User u1 = new User();
            u1.setUserId("user01");
            u1.setName("철수");
            u1.setScore(1200);
            list.add(u1);

            User u2 = new User();
            u2.setUserId("user02");
            u2.setName("영희");
            u2.setScore(1800);
            list.add(u2);

            User u3 = new User();
            u3.setUserId("user03");
            u3.setName("민수");
            u3.setScore(1600);
            list.add(u3);

            User me = new User();
            me.setUserId("testUser01");
            me.setName("테스터");
            me.setScore(1500);
            list.add(me);


            request.setAttribute("rankingList", list);
            request.getRequestDispatcher("/ranking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("rankingList", new ArrayList<User>());
            request.getRequestDispatcher("/ranking.jsp").forward(request, response);
        }
    }
}
