package emaillist.dao.test;

import java.util.List;
import java.util.Scanner;

import emaillist.dao.EmaillistDao;
import emaillist.vo.EmaillistVo;

public class EmaillistDaoTest {

	private static Scanner scanner = new Scanner(System.in);
	public static void main(String[] args) {
		testInsert();
		//testDelete("zhqkfxm0127@naver.com");
		testFindAll();
		
		
	}

	private static void testInsert(EmaillistVo vo) {
		System.out.print("성: ");
		vo.setFirstName(scanner.nextLine());
		
		System.out.print("성: ");
		vo.setFirstName(scanner.nextLine());
		
		
		new EmaillistDao().insert(vo);
		
	}

	private static void testFindAll() {
		List <EmaillistVo> list = new EmaillistDao().findAll();
		for(EmaillistVo vo : list) {
			System.out.println(vo);
		}
	}
	
}
