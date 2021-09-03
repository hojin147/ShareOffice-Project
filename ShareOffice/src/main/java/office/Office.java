package office;

//오피스 정보
public class Office {
	//오피스의 개별 정보
	///오피스 고유 번호, 해당 인실 기준 인원수, 층, 1달 기준 가격
	private int oNum, oPeople, oFloor, oMonthlyRent;
	//지점이름, 인실 이름, 예약 가능 상태
	private String oBuildingName, oName, oStatus;
	
	public Office() {
		
	}
	
	//생성자
	public Office(int oNum, int oPeople, int oFloor, int oMonthlyRent, String oBuildingName, String oName,
			String oStatus) {
		super();
		this.oNum = oNum;
		this.oPeople = oPeople;
		this.oFloor = oFloor;
		this.oMonthlyRent = oMonthlyRent;
		this.oBuildingName = oBuildingName;
		this.oName = oName;
		this.oStatus = oStatus;
	}

	//세팅/호출 메소드
	public int getoNum() {
		return oNum;
	}

	public void setoNum(int oNum) {
		this.oNum = oNum;
	}

	public int getoPeople() {
		return oPeople;
	}

	public void setoPeople(int oPeople) {
		this.oPeople = oPeople;
	}

	public int getoFloor() {
		return oFloor;
	}

	public void setoFloor(int oFloor) {
		this.oFloor = oFloor;
	}

	public int getoMonthlyRent() {
		return oMonthlyRent;
	}

	public void setoMonthlyRent(int oMonthlyRent) {
		this.oMonthlyRent = oMonthlyRent;
	}

	public String getoBuildingName() {
		return oBuildingName;
	}

	public void setoBuildingName(String oBuildingName) {
		this.oBuildingName = oBuildingName;
	}

	public String getoName() {
		return oName;
	}

	public void setoName(String oName) {
		this.oName = oName;
	}

	public String getoStatus() {
		return oStatus;
	}

	public void setoStatus(String oStatus) {
		this.oStatus = oStatus;
	}
}