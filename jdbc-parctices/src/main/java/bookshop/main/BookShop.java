package bookshop.main;

import java.util.Scanner;

import bookshop.vo.BookVo;

public class BookShop {

	public static void main(String[] args) {
		System.out.println("*****도서 정보 출력하기******");
		displayBookInfo();
		
		Scanner scanner = new Scanner(System.in);
		System.out.print("대여 하고 싶은 책의 번호를 입력하세요:");
		int num = scanner.nextInt();
		num-= 1; // num과 index 맞춰주기
		scanner.close();
		
		BookVo vo = new BookVo();
		vo.setNo(null);
		vo.setRent("y");
		new BookDao().updateRent(vo);
		
		// (1) 입력된 번호에 맞는 책을 찾아 대여 되었음(stateRent = True)을 체크 합니다.
		if(books[num].getStateRent()) {
			System.out.println(books[num].getTitle() + "이(가) 이미 대여중입니다.");
		}else {
			System.out.println(books[num].getTitle() + "이(가) 대여 됐습니다.");
			books[num].rent();
		}
		
		// (2) Book 객체의 정보를 출력
		System.out.println("*****도서 정보 출력하기******");
		displayBookInfo( books );
	}

	private static void displayBookInfo(BookVo vo) {
		List<BookVo> list = new VookDao().findAll();
		for(BookVo vo : list) {
			
		}
		
	}
}
