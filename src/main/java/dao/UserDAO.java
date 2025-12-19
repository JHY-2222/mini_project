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

    // USER_ID 존재 여부 확인
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
        return null;
    }

    // 점수 업데이트
    public void updateScore(String userId, int score) throws Exception {
        String sql = "UPDATE USERS SET SCORE = ? WHERE USER_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, score);
            ps.setString(2, userId);
            ps.executeUpdate();
        }
    }

    // 점수 기준 랭킹 조회
    public List<User> showRanking() throws Exception {
        List<User> list = new ArrayList<>();
        String sql = "SELECT USER_ID, NAME, SCORE FROM USERS WHERE IS_GUEST = 'N' ORDER BY SCORE DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
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
