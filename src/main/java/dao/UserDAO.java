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

    // 입력받은 userId가 DB에 있는지 확인
    public User findUserById(String userId) throws Exception {
        String sql = "SELECT USER_ID, NAME, SCORE FROM USERS WHERE USER_ID = ?";
        
        // DB 연결 통로(conn) 열고, 명령 전달할 준비(ps)
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) { 		
        		// SQL문 물음표(?) 자리에 우리가 찾는 유저의 ID를 집어기
	            ps.setString(1, userId);
	            // DB에서 찾은 후 결과를 rs에 담음
	            ResultSet rs = ps.executeQuery();
	            // 결과표에 데이터가 들어있는 경우 = 회원
	            if (rs.next()) {
	            	// 회원을 찾았다면 새로운 User 바구니 만듦
	                User user = new User();
	                // DB 결과표(rs)에서 꺼낸 정보를 자바 객체(user)에 옮겨 담음
	                user.setUserId(rs.getString("USER_ID"));	// DB 아이디 -> 자바 아이디
	                user.setNickname(rs.getString("NAME"));
	                user.setScore(rs.getInt("SCORE"));
	                return user;
            }
        }
        return null;	// DB에 없으면 null 반환 (게스트)
    }


    // 랭킹 조회
    public List<User> showRanking() throws Exception {
        List<User> list = new ArrayList<>();
        
        // 게스트 제외 + DB 점수 높은 순
        // 게스트는 DB에 없으므로, USERS 테이블 전체 점수순으로 가져오기
        String sql = "SELECT USER_ID, NAME, SCORE FROM USERS ORDER BY SCORE DESC";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
        	// 쿼리 실행 후 결과물 전체를 받아옴
            ResultSet rs = ps.executeQuery()) {
        	
        	// 결과표의 마지막 줄까지 한 줄씩 계속 읽음(while문)
            while (rs.next()) {
                User user = new User();	// 한 명의 정보를 담을 바구니 생성
                user.setUserId(rs.getString("USER_ID"));	// 아이디 담기
                user.setNickname(rs.getString("NAME"));	// 이름 담기
                user.setScore(rs.getInt("SCORE"));	// 점수 담기
                list.add(user);	// 큰 바구니(list)에 한 명씩 차례로 추가
            }
        }
        // 1등부터 꼴찌까지(회원만) 담긴 리스트 반환
        return list;
    }
}
