package office;

//지점정보
public class Building {
	//지점이름과 주소
	private String bName, bAddress;
	
	public Building() {
		
	}

	//생성자
	public Building(String bName, String bAddress) {
		super();
		this.bName = bName;
		this.bAddress = bAddress;
	}

	//세팅/호출 메소드
	public String getbName() {
		return bName;
	}

	public void setbName(String bName) {
		this.bName = bName;
	}

	public String getbAddress() {
		return bAddress;
	}

	public void setbAddress(String bAddress) {
		this.bAddress = bAddress;
	}
}
