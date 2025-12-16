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
                "jdbc:oracle:thin:@localhost:1521:xe", 
                "OMOK_USER",                          
                "password"                             
        );
    }

    // 점수 기준 랭킹 조회
    public List<User> showRanking() throws Exception {
        List<User> list = new ArrayList<>();

        String sql = "SELECT user_id, name, score " +
                     "FROM users " +
                     "WHERE is_guest = 1 " +
                     "ORDER BY score DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new User(
                        rs.getString("user_id"),
                        rs.getString("name"),
                        rs.getInt("score")
                ));
            }
        }

        return list;
    }
    
}
