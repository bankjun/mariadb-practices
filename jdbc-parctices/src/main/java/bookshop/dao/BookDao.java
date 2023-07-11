package bookshop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookshop.vo.BookVo;

public class BookDao {
	public boolean insert(BookVo vo) {
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
			String sql = "insert into book values(null, ?, 'n', ?)";
			
			pstmt = conn.prepareStatement(sql);
			
			// 4. 바인딩(binding)
			pstmt.setString(1, vo.getTitle());
			pstmt.setLong(2, vo.getAuthorNo());
			
			// 5. SQL 실행
			int count = pstmt.executeUpdate(); //여기에 sql을 넣으면 안되고 바인딩이 완성된걸 넘겨줘야함
			
			// 6. 결과처리
			result = count == 1;
			System.out.println("Book insert 성공");
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

	public List<BookVo> findAll() {
		List<BookVo> result = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1.클래스 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			// 2. 연결하기
			String url = "jdbc:mariadb://192.168.0.150:3306/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");			
			// 3. Statement 준비
			String sql = "select a.no, a.title, a.rent, b.name from book a, author b"
					+ "    where a.author_no = b.no"
					+ " order by no asc";
			pstmt = conn.prepareStatement(sql);						
			// 4. Binding, select는 바인딩할 값이 없음
			
			// 5. SQL 실행
			rs = pstmt.executeQuery();

			// 6. 결과처리
			while(rs.next()) {
				Long no = rs.getLong(1); // DB는 1부터시작
				String title = rs.getString(2);
			    String rent = rs.getString(3);
				String authorName = rs.getString(4);
				
				BookVo vo = new BookVo();
				vo.setNo(no);
				vo.setTitle(title);
				vo.setRent(rent);
				vo.setAuthorName(authorName);
				
				result.add(vo);
				
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
		return result;
	}

	public void updateRent(BookVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			// 1. 클래스 로
			Class.forName("org.mariadb.jdbc.Driver");
			// 2. 연결하기 
			String url = "jdbc:mariadb://192.168.0.150:3306/webdb?charset=utf8";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			// 3. Statement 생성
			String sql = "update book set rent = ? where no= ? ";
			pstmt = conn.prepareStatement(sql);
			// 4. SQL 실행
			pstmt.setString(1,  vo.getRent());
			pstmt.setLong(2, vo.getNo());
			
			int count = pstmt.executeUpdate();
			
			// 5. 결과처리
			System.out.println("book update 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패: "+ e);
		} catch (SQLException e) {
			System.out.println("Error: "+ e);
		} finally {// 6. 자원정리
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
	}
}
