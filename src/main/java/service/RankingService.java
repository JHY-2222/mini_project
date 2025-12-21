package service;

import java.util.List;	// List 인터페이스 사용 (랭킹 목록)
import java.util.Map;	// 한 번에 여러 값 반환
import java.util.HashMap;	// 한 번에 여러 값 반환
import dao.UserDAO;	// DB 접근 객체
import domain.User;	// 유저 한 명 표현 객체

public class RankingService {

    private UserDAO dao = new UserDAO();	// DAO 객체 생성

    // 랭킹 목록 조회
    public List<User> showRanking() throws Exception {
        return dao.showRanking();	// DB에서 점수 기준으로 정렬된 유저 목록 가져옴
    }

    // New 코
    public Map<String, Object> getUserRankingInfo(String userId, String userName, Integer gameScore, List<User> rankingList) throws Exception {
        Map<String, Object> result = new HashMap<>();
        User myUser = null;

        // userId가 존재할 때만 DB 조회 시도
        if (userId != null && !userId.isEmpty() && !userId.contains("-")) { 
            // UUID는 하이픈(-)이 포함되므로, 하이픈이 있으면 게스트로 간주하고 DB 조회를 건너뛰게 설계
            myUser = dao.findUserById(userId);
        }
        
        // 게스트이거나 DB에 없는 경우
        if (myUser == null) {
            myUser = new User();
            // ID가 없으면 중복 체크 로직에서 에러 안 나게 임시값 부여
            myUser.setUserId("GUEST_" + System.currentTimeMillis());
            myUser.setNickname("Guest"); // 입력값 무시하고 "Guest"로 고정
            myUser.setScore(gameScore != null ? gameScore : 0);
        }
        
        int myRank = calculateRank(rankingList, myUser.getScore());
        
        result.put("myUser", myUser);
        result.put("myRank", myRank);
        return result;
    }

    // 순위 계산 로직
    public int calculateRank(List<User> list, int score) {
        int rank = 1;	 // 기본 1등부터 시작
        if (list != null) {
        	// 랭킹 목록을 하나씩 비교
            for (User u : list) {
                if (u.getScore() > score) {
                    rank++;
                }
            }
        }
        return rank;
    }
}