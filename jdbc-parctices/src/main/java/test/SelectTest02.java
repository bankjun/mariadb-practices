package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SelectTest02 {

	public static void main(String[] args) {
		list();
	}
	
	public static void list () {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1. JDBC Driver Class 로딩 - DBMS 벤더들이 만들어 놓은 클래스 모음?
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기 -> 드라이버가 커넥션 객체를 생성해서 나한테 주는 것
			String url = "jdbc:mariadb://192.168.0.150:3306/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			// 3. Statement 준비
			String sql = "select no, name from dept order by no desc";
			pstmt = conn.prepareStatement(sql);
			// 커넥션객체로 Statement를 생성 -> 4번에서 SQL문(statement)를 사용하기 위해서
			
			
			// 4. Binding, select는 바인딩할 값이 없음
			
			// 5. SQL 실행
			rs = pstmt.executeQuery();
			
			// 주의할점: 디버깅할때 SQL문이 오류인지 java가 오류인지 모르니까 일단 SQL이 오류없음을 증명해놓고 시작 
			// , ";"을 뺴야함
			
			
			// 5. 결과처리
			while(rs.next()) {
				Long no = rs.getLong(1); // DB는 1부터시작
				String name = rs.getString(2);
				
				System.out.println(no + ":" + name);
			}
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: "+ e);
		} catch (SQLException e) {
			System.out.println("Error: "+ e);
		} finally {// 6. 자원정리
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
