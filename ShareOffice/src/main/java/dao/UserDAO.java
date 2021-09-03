package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import office.*;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String url, user, passwd;

	//데이터 베이스 접속
	public UserDAO() {
		this.conn = DBConnection.getConnection();
		System.out.println("커넥션 불러옴");
	}
	
	//닫는 메소드
	public void close() {
		DBConnection.close();
		System.out.println("sql문 끝");
	}
	
	//DB연결 끊기
	public void closeconn() {
		DBConnection.closeConn();
		System.out.println("DB연결 끊기 불러옴");
	}

	// 로그인
	public int login(String uEmail, String uPassword) {
		String sql = "SELECT PASSWORD FROM USER_ACCOUNT WHERE E_MAIL = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uEmail);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(uPassword)) {
					// 로그인 성공
					return 1;
				} else {
					// 비밀번호 틀림
					return 0;
				}
			}
			// 아이디가 없음
			return -1;
		} catch (Exception e) {
			System.out.println("로그인 오류");
			e.printStackTrace();
		} finally {
			close();			
		}
		// 데이터 베이스 오류
		return -2;
	}

	// 회원가입
	public int join(User_account user_account) {
		String sql = "INSERT INTO USER_ACCOUNT VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_account.getuEmail());
			pstmt.setString(2, user_account.getuPassword());
			pstmt.setString(3, user_account.getuName());
			pstmt.setString(4, user_account.getuPhone());
			pstmt.setString(5, "user");
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원가입 오류");
		} finally {
			close();			
		}
		// 아이디가 있는 경우
		return -1;
	}

	//회원 정보 수정
	public int updateUser(User_account user_account) {
		String sql = "UPDATE USER_ACCOUNT SET PASSWORD = ?, USER_NAME = ?, PHONE = ? WHERE E_MAIL= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_account.getuPassword());
			pstmt.setString(2, user_account.getuName());
			pstmt.setString(3, user_account.getuPhone());
			pstmt.setString(4, user_account.getuEmail());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("회원정보수정 오류");
		} finally {
			close();			
		}
		// 데이터베이스 오류
		return -1;
	}

	//회원 탈퇴
	public int deleteUser(User_account user_account) {
		System.out.println("유저용 계정탈퇴 메소드 실행");
		String sql = "DELETE FROM USER_ACCOUNT WHERE E_MAIL = ? AND PASSWORD=?";
		// 비번 일치 여부 확인을 위한 비번 셀렉
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_account.getuEmail());
			pstmt.setString(2, user_account.getuPassword());
			// 삭제 성공
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("삭제 오류");
			e.printStackTrace();
		} finally {
			close();
		}
		// 데이터 베이스 오류
		return -1;
	}
	
	//관리자가 회원삭제
	public int deleteUserManager(String email) {
		System.out.println("삭제 메소드 실행");
		String sql = "DELETE FROM USER_ACCOUNT WHERE E_MAIL = ?";
		// 비번 일치 여부 확인을 위한 비번 셀렉
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			// 삭제 성공
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("삭제 오류");
		} finally {
			close();
		}
		// 데이터 베이스 오류
		return -1;
	}

	//수정을 위한 회원정보 하나씩 불러오기 메소드
	public User_account selectOneuser(String user_account) {
		System.out.println("start userDAO/selectOne");
		
		String sql = "SELECT * FROM USER_ACCOUNT WHERE E_MAIL = ?";
		User_account user = new User_account();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_account);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				user.setuEmail(rs.getString("E_MAIL"));
				user.setuPassword(rs.getString("PASSWORD"));
				user.setuName(rs.getString("USER_NAME"));
				user.setuPhone(rs.getString("PHONE"));
				user.setuType(rs.getString("USER_TYPE"));
				System.out.println(user);
			}
		} catch (Exception e) {
			System.out.println("셀렉트 오류");
		} finally {
			close();			
		}
		return user;
	}
	
	//관리자의 회원 관리를 위한 메소드
	public ArrayList<User_account> selectAlluser() {
		ArrayList<User_account> userArr = new ArrayList<User_account>();
		String sql = "SELECT E_MAIL, PASSWORD, USER_NAME, PHONE FROM USER_ACCOUNT WHERE USER_TYPE = 'user'";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User_account user = new User_account();
				user.setuEmail(rs.getString("E_MAIL"));
				user.setuPassword(rs.getString("PASSWORD"));
				user.setuName(rs.getString("USER_NAME"));
				user.setuPhone(rs.getString("PHONE"));
				userArr.add(user);
			}
		} catch (Exception e) {
			System.out.println("유저 목록 불러오기 오류");
		} finally {
			close();
		}
		return userArr;
	}

	//유저목록 총 레코드 수
	public int countRecord() {
		int count=0;
		String sql = "SELECT COUNT(*) AS COUNT FROM USER_ACCOUNT";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt("COUNT");
			}
		} catch (Exception e) {
			System.out.println("유저 총 레코드수 불러오기 오류");
		} finally {
			close();		
		}
		return count;
	}
	
	//오토커밋 끄기
	public void setAutoCommitFalse() {
		try {
			this.conn.setAutoCommit(false);
			System.out.println("BuildingDAO/start setAutoCommitFalse");
		} catch (SQLException e) {
			System.out.println("오토커밋 끄기 오류");
		}
	}

	//오토커밋 켜기
	public void setAutoCommitTrue() {
		try {
			this.conn.setAutoCommit(true);
			System.out.println("BuildingDAO/start setAutoCommitTrue");
		} catch (SQLException e) {
			System.out.println("오토커밋 켜기 오류");
		}
	}

	//커밋하기
	public void commit() {
		try {
			this.conn.commit();
			System.out.println("BuildingDAO/start commit");
		} catch (SQLException e) {
			System.out.println("커밋 오류");
		}
	}
}
