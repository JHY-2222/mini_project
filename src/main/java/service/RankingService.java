package service;

import java.util.List;

import dao.UserDAO;
import domain.User;

public class RankingService {

    private UserDAO dao = new UserDAO();

    // 게임 결과 처리
    public User processGameResult(String userId, int gainedScore, String name) throws Exception {
        User dbUser = dao.findUserById(userId); // DB에 있는 유저
        if (dbUser != null) {
            int newScore = dbUser.getScore() + gainedScore;
            dao.updateScore(userId, newScore);
            dbUser.setScore(newScore);
            return dbUser; // 공식 유저
        }

        // DB에 없는 유저 (게스트)
        User tempUser = new User();
        tempUser.setUserId(userId);
        tempUser.setName(name);
        tempUser.setScore(gainedScore);
        return tempUser; // DB 저장 ❌
    }

    // 랭킹 조회
    public List<User> showRanking() throws Exception {
        return dao.showRanking();
    }

    // DB + 임시 유저 비교해서 순위 계산
    public int calculateRank(List<User> list, User targetUser) {
        int rank = 1;
        for (User u : list) {
            if (u.getScore() > targetUser.getScore()) {
                rank++;
            }
        }
        return rank;
    }
    
    public User findUser(String userId) throws Exception {
        return dao.findUserById(userId); // DAO의 기존 조회 메서드 활용 (업데이트 로직 없음)
    }
}
