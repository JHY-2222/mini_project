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

    // 랭킹 조회
    public List<User> showRanking() throws Exception {
    	// 결과를 담을 빈 리스트 생성
        List<User> list = new ArrayList<>();
        
        // 게스트 제외 + DB 점수 높은 순으로 가져오기
        String sql = "SELECT NAME, SCORE FROM USERS ORDER BY SCORE DESC";
        
        // 연결 시도 및 쿼리 준비
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
        	// 쿼리 실행 후 결과물 전체를 받아옴
            ResultSet rs = ps.executeQuery()) {
        	
        	// 결과표의 마지막 줄까지 한 줄씩 계속 읽음(while문)
            while (rs.next()) {
                User user = new User();	// 한 명의 정보를 담을 바구니 생성
                user.setNickname(rs.getString("NAME"));	// 이름 담기
                user.setScore(rs.getInt("SCORE"));	// 점수 담기
                list.add(user);	// 큰 바구니(list)에 한 명씩 차례로 추가
            }
        }
        // 1등부터 꼴찌까지(회원만) 담긴 리스트 반환
        return list;
    }
}
