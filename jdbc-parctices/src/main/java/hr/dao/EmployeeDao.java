package hr.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hr.vo.EmployeeVo;

public class EmployeeDao {
	
	public List<EmployeeVo> findByName(String keyword) {
		List<EmployeeVo> result = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			
			String url = "jdbc:mariadb://192.168.0.150:3306/employees?charset=utf8";
			conn = DriverManager.getConnection(url, "hr", "hr");
			
			String sql = "select emp_no, first_name, last_name, date_format(hire_date, '%Y-%m-%d')\r\n"
					+ "from employees\r\n"
					+ "where first_name like ?\r\n"
					+ "or last_name like ?\r\n"
					+ "order by hire_date asc";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			
			rs = pstmt.executeQuery();
			
			// 5. 결과처리
			while(rs.next()) {
				Long no = rs.getLong(1); // DB는 1부터시작
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				String hireDate = rs.getString(4);
				
				EmployeeVo vo = new EmployeeVo();
				vo.setNo(no);
				vo.setFirstName(firstName);
				vo.setLastName(lastName);
				vo.setHireDate(hireDate);
				
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
	
	public List<EmployeeVo> findBySalary(Long min, Long max) {
		// 결과 객체 변수
		List<EmployeeVo> result = new ArrayList<>();
		// 자원
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 1. 클래스 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			// 2. 연결
			String url = "jdbc:mariadb://192.168.0.150:3306/employees?charset=utf8";
			conn = DriverManager.getConnection(url, "hr", "hr");
			// 3.statement준비
			String sql = "select a.emp_no, a.first_name, a.last_name, b.salary\r\n"
					+ "     from employees a, salaries b\r\n"
					+ "    where a.emp_no = b.emp_no\r\n"
					+ "      and b.to_date = '9999-01-01'\r\n"
					+ "      and b.salary > ? and b.salary < ? \r\n"
					+ " order by b.salary desc";
					
			pstmt = conn.prepareStatement(sql);
			// 4.바인딩
			pstmt.setLong(1, min);
			pstmt.setLong(2, max);
			
			rs = pstmt.executeQuery();
			
			// 5. 결과처리
			while(rs.next()) {
				Long no = rs.getLong(1); // DB는 1부터시작
				String firstName = rs.getString(2);
				String lastName = rs.getString(3);
				Long salary = rs.getLong(4);
				
				EmployeeVo vo = new EmployeeVo();
				vo.setNo(no);
				vo.setFirstName(firstName);
				vo.setLastName(lastName);
				vo.setSalary(salary);
				
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
	
}
