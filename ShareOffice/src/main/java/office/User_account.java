package office;

//유저정보, 회원의 회원가입시 입력 데이터
public class User_account {
	//회원의 이메일(아이디), 패스워드, 회원이름, 회원연락처, 회원 타입(개인/기업)
	private String uEmail, uPassword, uName, uPhone, uType;

	public User_account() {
		
	}
	
	//생성자
	public User_account(String uEmail, String uPassword, String uName, String uPhone, String uType) {
		super();
		this.uEmail = uEmail;
		this.uPassword = uPassword;
		this.uName = uName;
		this.uPhone = uPhone;
		this.uType = uType;
	}

	//세팅/호출 메소드
	public String getuEmail() {
		return uEmail;
	}

	public void setuEmail(String uEmail) {
		this.uEmail = uEmail;
	}

	public String getuPassword() {
		return uPassword;
	}

	public void setuPassword(String uPassword) {
		this.uPassword = uPassword;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String urName) {
		this.uName = urName;
	}

	public String getuPhone() {
		return uPhone;
	}

	public void setuPhone(String uPhone) {
		this.uPhone = uPhone;
	}

	public String getuType() {
		return uType;
	}

	public void setuType(String uType) {
		this.uType = uType;
	}
}