package service;

import java.util.List;

import dao.UserDAO;
import domain.User;

public class RankingService {

	private UserDAO dao = new UserDAO();

    // 점수(score) 기준 랭킹 조회
    public List<User> showRanking() throws Exception {
        return dao.showRanking();
    }
        
}

