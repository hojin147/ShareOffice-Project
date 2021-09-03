package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import office.*;

public class CompanyDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public CompanyDAO() {
		this.conn = DBConnection.getConnection();
		System.out.println("커넥션 불러옴");
	}
	
	public void close() {
		DBConnection.close();
		System.out.println("sql문 끝");
	}
	
	public void closeconn() {
		DBConnection.closeConn();
		System.out.println("DB연결 끊기 불러옴");
	}
	
	//기업정보 인서트
	public int inCom(Companyinfo_history com) {
		String sql = "INSERT INTO COMPANY_INFO_HISTORY VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, com.getcEmail());
			pstmt.setString(2, com.getcName());
			pstmt.setString(3, com.getcBuznum());
			pstmt.setString(4, com.getcRepersentative());
			pstmt.setString(5, com.getcPhone());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회사정보 입력 오류");
		} finally {
			close();			
		}
		//DB오류
		return -1;
	} 
	
	//해당 이메일에 해당하는 기업정보 불러오기
	public Companyinfo_history selectOneCom(String companyinfo_history) {
		System.out.println("CompanyDAO/start selectOneCom");		
		String sql = "SELECT * FROM COMPANY_INFO_HISTORY WHERE E_MAIL = ?";
		Companyinfo_history company = new Companyinfo_history();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, companyinfo_history);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				company.setcEmail(rs.getString("E_MAIL"));
				company.setcBuznum(rs.getString("BUSINESS_NUMBER"));
				company.setcRepersentative(rs.getString("REPRESENTATIVE"));
				company.setcPhone(rs.getString("COMPANY_PHONE"));
				company.setcName(rs.getString("COMPANY_NAME"));
				company.setcRegdate(rs.getTimestamp("REGDATE"));
				System.out.println(company);
			}
		} catch (Exception e) {
			System.out.println("기업 정보 불러오기 오류");
		} finally {
			close();			
		}
		return company;
	}
	
	//오토 커밋 끄기
	public void setAutoCommitFalse() throws Exception{
		try {
			this.conn.setAutoCommit(false);
			System.out.println("CompanyDAO/start setAutoCommitFalse");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//오토 커밋 켜기
	public void setAutoCommitTrue() throws Exception{
		try {
			this.conn.setAutoCommit(true);
			System.out.println("CompanyDAO/start setAutoCommitTrue");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//커밋하기
	public void commit() throws Exception{
		try {
			this.conn.commit();
			System.out.println("CompanyDAO/start commit");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//롤백하기
	public void rollback() throws Exception{
		try {
			this.conn.rollback();
			System.out.println("CompanyDAO/start rollback");	
		} catch (SQLException e) {
			throw e;
		}
	}
	
	//회사 정보 인서트
	public int insertCompany(Companyinfo_history com) throws Exception{
		System.out.println("CompanyDAO/start insertCompany");	
		String sql = "INSERT INTO COMPANY_INFO_HISTORY VALUES(?, ?, ?, ?, ?, SYSDATE)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, com.getcEmail());
			pstmt.setString(2, com.getcBuznum());
			pstmt.setString(3, com.getcRepersentative());
			pstmt.setString(4, com.getcPhone());
			pstmt.setString(5, com.getcName());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회사정보 입력 오류");
			throw e;
		} finally {
			close();			
		}
		
	} 
	
	//해당 이메일에 대한 회사정보 있는지 없는지 확인 후 불러오기
	public Companyinfo_history selectLatestCompany(String email) throws Exception{
		System.out.println("CompanyDAO/start selectLatestCompany");		
		String sql = "SELECT * FROM COMPANY_INFO_HISTORY WHERE E_MAIL = ? "
				+ "AND REGDATE=(SELECT MAX(REGDATE) FROM COMPANY_INFO_HISTORY WHERE E_MAIL=?)";
		Companyinfo_history company = new Companyinfo_history();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				company.setcEmail(rs.getString("E_MAIL"));
				company.setcBuznum(rs.getString("BUSINESS_NUMBER"));
				company.setcRepersentative(rs.getString("REPRESENTATIVE"));
				company.setcPhone(rs.getString("COMPANY_PHONE"));
				company.setcName(rs.getString("COMPANY_NAME"));
				company.setcRegdate(rs.getTimestamp("REGDATE"));
				System.out.println(company);
			}
		} catch (Exception e) {
			System.out.println("회사 정보 셀렉트 오류");
			throw e;
		} finally {
			close();			
		}
		return company;
	} 
}
