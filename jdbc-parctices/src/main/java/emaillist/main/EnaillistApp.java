package emaillist.main;

import java.util.List;
import java.util.Scanner;

import emaillist.dao.EmaillistDao;
import emaillist.vo.EmaillistVo;

public class EnaillistApp {
	private static Scanner scanner = new Scanner(System.in);
	
	public static void main(String[] args) {
		
		while(true) {
			System.out.print("(l)ist, (d)elete, (i)nsert, (q)uit > ");
			String command = scanner.nextLine();
			
			if("q".equals(command)) {
				System.out.println("프로그램 종료");
				break;
			}else if("l".equals(command)){
				doList();
			}else if("d".equals(command)){
				doDelete();
			}else if("i".equals(command)){
				doInsert();
			}
			
			
		}
	}

	private static void doDelete() {
		System.out.print("삭제할 이메일: ");
		
		new EmaillistDao().delete(scanner.nextLine());
	}

	private static void doInsert() {
		EmaillistVo vo = new EmaillistVo();
		
		System.out.print("성: ");
		vo.setFirstName(scanner.nextLine());
		
		System.out.print("이름: ");
		vo.setLastName(scanner.nextLine());
		
		System.out.print("이메일: ");
		vo.setEmail(scanner.nextLine());
		
		new EmaillistDao().insert(vo);
	}

	private static void doList() {
		List <EmaillistVo> list = new EmaillistDao().findAll();
		for(EmaillistVo vo : list) {
			System.out.println(vo.getFirstName()+ " "+ vo.getLastName()+" - "+ vo.getEmail());
		}
	}
	
	

}
