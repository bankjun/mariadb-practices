package bookshop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bookshop.vo.AuthorVo;

public class AuthorDao {
	public boolean insert(AuthorVo vo) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			// 1.클래스 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기 
			String url = "jdbc:mariadb://192.168.0.150:3306/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
	
			// 3. Statement 생성
			String sql = "insert into author values(null, ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			// 4. 바인딩(binding)
			pstmt.setString(1, vo.getName());
			
			// 5. SQL 실행
			int count = pstmt.executeUpdate(); //여기에 sql을 넣으면 안되고 바인딩이 완성된걸 넘겨줘야함
			
			// 6. 결과처리
			result = count == 1;
			System.out.println("Author insert 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: "+ e);
		} catch (SQLException e) {
			System.out.println("Error: "+ e);
		} finally {// 7. 자원정리
			try {
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
		return result;
	}
}
