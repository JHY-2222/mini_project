package service;

import java.util.List;	// List 인터페이스 사용 (랭킹 목록)
//import java.util.ArrayList;
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

    // 유저 정보 및 순위 결정(from. 컨트롤러)
    public Map<String, Object> getUserRankingInfo(String userId, String userName, Integer gameScore, List<User> rankingList) throws Exception {
    	Map<String, Object> result = new HashMap<>();	// 여러 개의 값을 묶어서 돌려주기 위한 Map
        
        User myUser = dao.findUserById(userId);	// DB에서 해당 userId로 유저 조회
        
        // DB에 없는 게스트라면 => 전달받은 데이터로 임시 객체 생성
        if (myUser == null) {
            myUser = new User();	// 새 User 객체 생성
            myUser.setUserId(userId);
            myUser.setName(userName);
            myUser.setScore(gameScore != null ? gameScore : 0);	// 점수가 없으면 0점
        }
        
        // 내 점수가 랭킹에서 몇 등인지 계산
        int myRank = calculateRank(rankingList, myUser);
        
        // 결과를 Map에 담아서 컨트롤러로 전달
        result.put("myUser", myUser);
        result.put("myRank", myRank);
        
        return result;
    }

    // 순위 계산 로직
    public int calculateRank(List<User> list, User targetUser) {
        int rank = 1;	 // 기본 1등부터 시작
        
        // 랭킹 목록을 하나씩 비교
        for (User u : list) {
            if (u.getScore() > targetUser.getScore()) {	// 나보다 점수 높은 사람이 있으면
                rank++;	// 순위 밀림
            }
        }
        return rank;
    }
}