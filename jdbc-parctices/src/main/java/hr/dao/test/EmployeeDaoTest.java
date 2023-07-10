package hr.dao.test;

import java.util.List;

import hr.dao.EmployeeDao;
import hr.vo.EmployeeVo;

// 테스트코드로 로직을 세워보는 과정 -> 클래스이름, 메소드, 메소드 파나메터, 등등 을 구상해봄
public class EmployeeDaoTest {

	public static void main(String[] args) {
		testFindByName("mahe");
		//최소 최댓값을 받고 그 사이 를 구하는 메소드
		testFindBySalary(150000l, 155000l);
	}
	
	private static void testFindBySalary(Long min, Long max) {
		List<EmployeeVo> list = new EmployeeDao().findBySalary(min, max);
		for(EmployeeVo vo: list) {
			System.out.println(vo);
		}
	}

	// 1. 메소드를 생각해보고
	public static void testFindByName(String keyword) {
		// 2. 클래스를 생각해보고
		List<EmployeeVo> list = new EmployeeDao().findByName(keyword);
		for(EmployeeVo vo : list) {
			System.out.println(vo);
		}
	}

}
