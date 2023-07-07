package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SelectTest01 {

	public static void main(String[] args) {
		list();
	}
	
	public static void list () {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			// 1. JDBC Driver Class 로딩 - DBMS 벤더들이 만들어 놓은 클래스 모음?
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기 -> 드라이버가 커넥션 객체를 생성해서 나한테 주는 것
			String url = "jdbc:mariadb://192.168.0.150:3306/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
			// 3. Statement 생성
			stmt = conn.createStatement();
			
			// 4. SQL 실행
			String sql = "select no, name from dept order by no desc";
			
			rs = stmt.executeQuery(sql);
			
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
				if(stmt != null) {
					stmt.close();
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
