package service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import dao.UserDAO;
import domain.User;

public class RankingService {

    private UserDAO dao = new UserDAO();

    // DB 랭킹 조회
    public List<User> showRanking() throws Exception {
        return dao.showRanking();
    }

    // 임시 User 생성
    public User createMyUser(String userId, int score) {
        User user = new User();
        user.setUserId(userId);
        user.setName(userId);
        user.setScore(score);
        return user;
    }

    // DB 기준 내 순위 계산
    public int calculateRank(List<User> list, User targetUser) {
        int rank = 1;
        for (User u : list) {
            if (u.getScore() > targetUser.getScore()) {
                rank++;
            }
        }
        return rank;
    }
    
    // DB + 내 정보 합쳐서 정렬
    public List<User> mergeAndSort(List<User> dbList, User myUser) {
        // DB 복사본 생성
        List<User> merged = new ArrayList<>(dbList);

        if (myUser != null) {
            // 나와 같은 ID가 DB 복사본 리스트에 있으면 삭제(중복 제거)
            merged.removeIf(u -> u.getUserId().equals(myUser.getUserId()));
            // 내 정보 리스트에 추가
            merged.add(myUser);
        }

        // 전체 리스트 정렬
        Collections.sort(merged, new Comparator<User>() {
            @Override
            public int compare(User o1, User o2) {
                return o2.getScore() - o1.getScore();
            }
        });

        return merged;
    }
}

