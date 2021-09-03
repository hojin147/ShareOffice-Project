package office;
import java.sql.Timestamp;

//상담신청
public class Counsel {
	//상담글 고유번호
	private int sNum;
	//상담 신청한 사람 email, 내용, 작성일
	private String sUseremail, sSubject, sContent;
	private Timestamp sRegdate;
	
	public Counsel() {
		
	}
	
	//생성자
	public Counsel(int sNum, String sUseremail, String sSubject, String sContent, Timestamp sRegdate) {
		super();
		this.sNum = sNum;
		this.sUseremail = sUseremail;
		this.sSubject = sSubject;
		this.sContent = sContent;
		this.sRegdate = sRegdate;
	}

	//세팅/호출 메소드
	public int getsNum() {
		return sNum;
	}

	public void setsNum(int sNum) {
		this.sNum = sNum;
	}
	
	public String getsUseremail() {
		return sUseremail;
	}

	public void setsUseremail(String sUseremail) {
		this.sUseremail = sUseremail;
	}

	public String getsSubject() {
		return sSubject;
	}

	public void setsSubject(String sSubject) {
		this.sSubject = sSubject;
	}

	public String getsContent() {
		return sContent;
	}

	public void setsContent(String sContent) {
		this.sContent = sContent;
	}

	public Timestamp getsRegdate() {
		return sRegdate;
	}

	public void setsRegdate(Timestamp sRegdate) {
		this.sRegdate = sRegdate;
	}
	
}
