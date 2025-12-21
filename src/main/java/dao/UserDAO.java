package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import domain.User;

public class UserDAO {

    // DB 연결
    private Connection getConnection() throws Exception {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(
            "jdbc:oracle:thin:@52.78.225.32:1521:xe",
            "gabeen",
            "125012"
        );
    }

    // USER_ID로 유저 한 명 조회
    public User findUserById(String userId) throws Exception {
        String sql = "SELECT USER_ID, NAME, SCORE FROM USERS WHERE USER_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setString(1, userId);
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	                User user = new User();
	                user.setUserId(rs.getString("USER_ID"));
	                user.setName(rs.getString("NAME"));
	                user.setScore(rs.getInt("SCORE"));
	                return user;
            }
        }
        return null;	// DB에 없으면 null 반환 (게스트)
    }


    // 랭킹 조회
    public List<User> showRanking() throws Exception {
        List<User> list = new ArrayList<>();
        
        // 게스트 제외 + 점수 높은 순
        String sql = "SELECT USER_ID, NAME, SCORE FROM USERS WHERE IS_GUEST = 'N' ORDER BY SCORE DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {	// 결과를 하나씩 User 객체로 변환
                User user = new User();
                user.setUserId(rs.getString("USER_ID"));
                user.setName(rs.getString("NAME"));
                user.setScore(rs.getInt("SCORE"));
                list.add(user);
            }
        }
        return list;
    }
}
