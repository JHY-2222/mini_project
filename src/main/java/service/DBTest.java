package service;

import java.util.List;

import dao.UserDAO;
import domain.User;

public class DBTest {

	public static void main(String[] args) {
		try {
            UserDAO dao = new UserDAO();
            System.out.println("DB 연결 시도...");
            List<User> list = dao.showRanking();
            System.out.println("DB 연결 성공! 랭킹 수: " + list.size());
            for(User u : list) {
                System.out.println(u.getUserId() + " | " + u.getNickname() + " | " + u.getScore());
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

	}

}
