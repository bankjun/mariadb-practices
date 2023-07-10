package bookshop.example;

public class Book {
	private int bookNo;
	private String title;
	private String author;
	private boolean stateRent; // true: 대여중, false: 재고있음
	
	public Book() {
		stateRent = false;
	}
	
	public Book (int bookNo, String title, String author) {
		this.setBookNo(bookNo);
		this.title = title;
		this.author = author;
		stateRent = false;
	}
	
	public void rent() {
		stateRent = true;
	}
	
	public void print() {
		System.out.println(여기에 ㅓㄴ호 추가+"책 제목:" + title + ", 작가:" + author + ", 대여 유무:" + (stateRent? "대여중":"재고있음"));
	}																			// 이거 왜 괄호쳐야하는거임?? 연산자우선순위?
	
	public String getTitle() {
		return this.title;
	}
	
	public boolean getStateRent() {
		if(this.stateRent) {
			return true;
		}else {
			return false;
		}
	}

	public int getBookNo() {
		return bookNo;
	}

	public void setBookNo(int bookNo) {
		this.bookNo = bookNo;
	}
	
}