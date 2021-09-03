package office;
import java.sql.Timestamp;

//예약 폼 입력시 추가되는 고객기업의 정보
public class Companyinfo_history {
	//고객기업의 이메일, 사업자등록번호, 대표자, 회사전화번호, 예약일
	private String cEmail, cBuznum, cRepersentative, cPhone, cName;
	private Timestamp cRegdate;
	
	public void Timestamp() {
		
	}

	//생성자
	public Companyinfo_history(String cEmail, String cBuznum, String cRepersentative, String cPhone, String cName, java.sql.Timestamp cRegdate) {
		super();
		this.cEmail = cEmail;
		this.cBuznum = cBuznum;
		this.cRepersentative = cRepersentative;
		this.cPhone = cPhone;
		this.cName = cName;
		this.cRegdate = cRegdate;
	}

	public Companyinfo_history() {
		
	}
	

	//세팅/호출 메소드
	public String getcEmail() {
		return cEmail;
	}

	public void setcEmail(String cEmail) {
		this.cEmail = cEmail;
	}

	public String getcBuznum() {
		return cBuznum;
	}

	public void setcBuznum(String cBuznum) {
		this.cBuznum = cBuznum;
	}

	public String getcRepersentative() {
		return cRepersentative;
	}

	public void setcRepersentative(String cRepersentative) {
		this.cRepersentative = cRepersentative;
	}

	public String getcPhone() {
		return cPhone;
	}

	public void setcPhone(String cPhone) {
		this.cPhone = cPhone;
	}
	
	public String getcName() {
		return cName;
	}
	
	public void setcName(String cName) {
		this.cName = cName;
	}

	public Timestamp getcRegdate() {
		return cRegdate;
	}

	public void setcRegdate(Timestamp cRegdate) {
		this.cRegdate = cRegdate;
	}
}
