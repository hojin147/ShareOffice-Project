package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import office.*;

public class OfficeDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String url, user, passwd;

	//데이터 베이스 접속
	public OfficeDAO() {
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
	
	//수정을 위한 오피스 하나씩 불러오기 메소드
	public Office selectOneoffice(int num) {
		String sql = "SELECT * FROM OFFICE WHERE NUM = ?";
		Office office = new Office();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				office.setoNum(rs.getInt("NUM"));
				office.setoBuildingName(rs.getString("BUILDING_NAME"));
				office.setoName(rs.getString("OFFICE_NAME"));
				office.setoPeople(rs.getInt("PEOPLE"));
				office.setoFloor(rs.getInt("FLOOR"));
				office.setoMonthlyRent(rs.getInt("MONTHLY_RENT"));
				office.setoStatus(rs.getString("STATUS"));
				System.out.println(office);
			}
		} catch (Exception e) {
			System.out.println("오피스 셀렉트 오류");
		} finally {
			close();			
		}
		return office;
	}
	
	//오피스 정보 수정
	public int updateOffice(Office office) {
		System.out.println("오피스정보수정시작");
		String sql = "UPDATE OFFICE SET OFFICE_NAME = ?, PEOPLE = ?, FLOOR = ?, MONTHLY_RENT=? WHERE NUM = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, office.getoName());
			pstmt.setInt(2, office.getoPeople());
			pstmt.setInt(3, office.getoFloor());
			pstmt.setInt(4, office.getoMonthlyRent());
			pstmt.setInt(5, office.getoNum());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("오피스정보 수정 오류");
		} finally {
			close();			
		}
		// 데이터베이스 오류
		return -1;
	}
	
	//오토 커밋 끄기
	public void setAutoCommitFalse() {
		try {
			this.conn.setAutoCommit(false);
			System.out.println("OfficeDAO/start setAutoCommitFalse");	
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//오토 커밋 켜기
	public void setAutoCommitTrue() {
		try {
			this.conn.setAutoCommit(true);
			System.out.println("OfficeDAO/start setAutoCommitTrue");	
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//커밋하기
	public void commit() {
		try {
			this.conn.commit();
			System.out.println("OfficeDAO/start commit");	
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 오피스 전체 불러오기
	public ArrayList<Office> selectOfficeAll() {
		System.out.println("OfficeDAO/start selectOfficeAll");
		ArrayList<Office> officelArr = new ArrayList<Office>();
		String sql = "SELECT * FROM OFFICE";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Office office = new Office();

				office.setoNum(rs.getInt("NUM"));
				office.setoBuildingName(rs.getString("BUILDING_NAME"));
				office.setoName(rs.getString("OFFICE_NAME"));
				office.setoPeople(rs.getInt("PEOPLE"));
				office.setoFloor(rs.getInt("FLOOR"));
				office.setoMonthlyRent(rs.getInt("MONTHLY_RENT"));
				office.setoStatus(rs.getString("STATUS"));

				officelArr.add(office);
			}
		} catch (Exception e) {
			System.out.println("상담글 목록 불러오기 오류");
		} finally {
			close();
		}
		return officelArr;
	}

	//빌딩별 오피스 불러오기
	public ArrayList<Office> selectOfficeAllByBuilding(String building) {
		System.out.println("OfficeDAO/start selectOfficeAllByBuilding");
		ArrayList<Office> officelArr = new ArrayList<Office>();
		String sql = "SELECT * FROM OFFICE WHERE ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, building);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Office office = new Office();

				office.setoNum(rs.getInt("NUM"));
				office.setoBuildingName(rs.getString("BUILDING_NAME"));
				office.setoName(rs.getString("OFFICE_NAME"));
				office.setoPeople(rs.getInt("PEOPLE"));
				office.setoFloor(rs.getInt("FLOOR"));
				office.setoMonthlyRent(rs.getInt("MONTHLY_RENT"));
				office.setoStatus(rs.getString("STATUS"));

				officelArr.add(office);
			}
		} catch (Exception e) {
			System.out.println("빌딩별 오피스 불러오기 오류");
		} finally {
			close();
		}
		return officelArr;
	}

	//카테고리 별로 인실 불러오기1
	public ArrayList<String> selectOfficeCategoryByBuilding(String building) {
		System.out.println("OfficeDAO/start selectOfficeCategoryByBuilding");
		ArrayList<String> officeKindsArr = new ArrayList<String>();
		String sql = "SELECT DISTINCT TO_NUMBER(SUBSTR(OFFICE_NAME,1,INSTR(OFFICE_NAME,'인실',1,1)-1)) AS PERSON "
				+ "FROM OFFICE WHERE BUILDING_NAME=? ORDER BY PERSON";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, building);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String office;
				office = rs.getInt("PERSON") + "인실";
				officeKindsArr.add(office);
			}
		} catch (Exception e) {
			System.out.println("빌딩에 해당하는 인실 불러오기 오류");
		} finally {
			close();
		}
		return officeKindsArr;
	}

	//카테고리 별로 인실과 상세인실 불러오기1
	public ArrayList<String> selectOfficeListByBuilding(String building, String officeKinds) {
		System.out.println("OfficeDAO/start selectOfficeListByBuilding");
		ArrayList<String> officeKindsArr = new ArrayList<String>();
		String sql = "SELECT OFFICE_NAME,TO_NUMBER(SUBSTR(OFFICE_NAME,INSTR(OFFICE_NAME,'-',1,1)+1)) AS PERSON "
				+ "FROM OFFICE " + "WHERE BUILDING_NAME=? AND INSTR(OFFICE_NAME,?)>0 ORDER BY PERSON";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, building);
			pstmt.setString(2, officeKinds);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String office = null;
				office = rs.getString("OFFICE_NAME");
				officeKindsArr.add(office);
			}
		} catch (Exception e) {
			System.out.println("상세인실 불러오기 오류");
		} finally {
			close();
		}
		return officeKindsArr;
	}
	
	//오피스 정보 삭제
	public int deleteOffice(int officeNum) {
		System.out.println("오피스 정보 삭제 시작");
		String sql = "DELETE FROM OFFICE WHERE NUM = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, officeNum);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("오피스정보 삭제 오류");
		} finally {
			close();			
		}
		// 데이터베이스 오류
		return -1;
	}
}
