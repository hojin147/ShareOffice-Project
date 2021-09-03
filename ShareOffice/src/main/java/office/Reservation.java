package office;
import java.sql.Date;
import java.sql.Timestamp;

//예약 폼 데이터
public class Reservation {
	
	//예약한 후 지점, 오피스 정보와, 시작~끝 날짜, 예약자 등의 정보
	private int rvNum, rvPeriod, rvTotalprice;
	private String rvBname, rvOname, rvStatus, rvEmail, rvType;
	private Date rvIndate, rvEnddate;
	private Timestamp rvRegdate;
	
	public Reservation() {
		
	}
	
	//생성자
	public Reservation(int rvNum, int rvPeriod, int rvTotalprice, String rvBname, String rvOname, String rvStatus,
			String rvEmail, String rvType, Date rvIndate, Date rvEnddate, Timestamp rvRegdate) {
		super();
		this.rvNum = rvNum;
		this.rvPeriod = rvPeriod;
		this.rvTotalprice = rvTotalprice;
		this.rvBname = rvBname;
		this.rvOname = rvOname;
		this.rvStatus = rvStatus;
		this.rvEmail = rvEmail;
		this.rvIndate = rvIndate;
		this.rvEnddate = rvEnddate;
		this.rvRegdate = rvRegdate;
		this.rvType = rvType;
	}

	//세팅/호출 메소드
	public int getRvNum() {
		return rvNum;
	}

	public void setRvNum(int rvNum) {
		this.rvNum = rvNum;
	}

	public int getRvPeriod() {
		return rvPeriod;
	}

	public void setRvPeriod(int rvPeriod) {
		this.rvPeriod = rvPeriod;
	}

	public int getRvTotalprice() {
		return rvTotalprice;
	}

	public void setRvTotalprice(int rvTotalprice) {
		this.rvTotalprice = rvTotalprice;
	}

	public String getRvBname() {
		return rvBname;
	}

	public void setRvBname(String rvBname) {
		this.rvBname = rvBname;
	}

	public String getRvOname() {
		return rvOname;
	}

	public void setRvOname(String rvOname) {
		this.rvOname = rvOname;
	}

	public String getRvStatus() {
		return rvStatus;
	}

	public void setRvStatus(String rvStatus) {
		this.rvStatus = rvStatus;
	}

	public String getRvEmail() {
		return rvEmail;
	}

	public void setRvEmail(String rvEmail) {
		this.rvEmail = rvEmail;
	}
	
	public String getRvType() {
		return rvType;
	}

	public void setRvType(String rvType) {
		this.rvType = rvType;
	}

	public Date getRvIndate() {
		return rvIndate;
	}

	public void setRvIndate(Date rvIndate) {
		this.rvIndate = rvIndate;
	}

	public Date getRvEnddate() {
		return rvEnddate;
	}

	public void setRvEnddate(Date rvEnddate) {
		this.rvEnddate = rvEnddate;
	}

	public Timestamp getRvRegdate() {
		return rvRegdate;
	}

	public void setRvRegdate(Timestamp rvRegdate) {
		this.rvRegdate = rvRegdate;
	}
}
