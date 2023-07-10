package emaillist.dao.test;

import java.util.List;
import java.util.Scanner;

import emaillist.dao.EmaillistDao;
import emaillist.vo.EmaillistVo;

public class EmaillistDaoTest {

	private static Scanner scanner = new Scanner(System.in);
	
	public static void main(String[] args) {
		EmaillistVo vo =  new EmaillistVo();
		vo.setFirstName("lee");
		vo.setLastName("juno");
		vo.setEmail("juno@naver.com");
		testInsert(vo);
		testDelete("juno@naver.com");
		testFindAll();
		
		
	}

	private static void testDelete(String email) {
		new EmaillistDao().delete(email);
		
	}

	private static void testInsert(EmaillistVo vo) {
		
//		System.out.print("성: ");
//		vo.setFirstName(scanner.nextLine());
//		
//		System.out.print("이름: ");
//		vo.setLastName(scanner.nextLine());
//		
//		System.out.print("이메일: ");
//		vo.setEmail(scanner.nextLine());
		new EmaillistDao().insert(vo);
	}

	private static void testFindAll() {
		List <EmaillistVo> list = new EmaillistDao().findAll();
		for(EmaillistVo vo : list) {
			System.out.println(vo);
		}
	}
	
}
