package gagebu;

public class GagebuVo {
	private int idx;
	private String wDate;
	private String gCode;
	private int price;
	private String content;
	private int balance;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public String getgCode() {
		return gCode;
	}
	public void setgCode(String gCode) {
		this.gCode = gCode;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	@Override
	public String toString() {
		return "GagebuVo [idx=" + idx + ", wdate=" + wDate + ", gCode=" + gCode + ", price=" + price + ", content="
				+ content + ", balance=" + balance + "]";
	}
}
