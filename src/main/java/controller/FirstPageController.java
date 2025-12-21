package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.User;


@WebServlet("/first")
public class FirstPageController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");

        if ("start".equals(action)) {
            // 바다 domain.User 규격에 맞게 게스트 유저 정보 생성
            User user = new User();
            String uuid = java.util.UUID.randomUUID().toString();	// 겹치지 않는 고유 ID 생성
            
            user.setUserId(uuid);
            user.setNickname("게스트-" + uuid.substring(0, 4));	// 바다 RoomWebSocket에서 쓰는 것(ex. 게스트-1a2b)과 동일한 규칙 적용
            user.setAvatar("/img/default-avatar.jpg");	// 기본 이미지 씌우기
            
            // 바다의 웹소켓(HttpSessionConfigurator)이 읽을 수 있게 세션에 저장
            request.getSession().setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/room");	// 바다가 만든 방 목록 페이지 주소로 이동
            return;	
        }
		
		// 원래는 이거 하나만 내 코드
		request.getRequestDispatcher("/firstPage.jsp").forward(request, response);
	}

}
