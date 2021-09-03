package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import office.Building;
import office.Office;

public class BuildingDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String url, user, passwd;

	//데이터 베이스 접속
	public BuildingDAO() {
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
	
	//수정을 위한 빌딩정보 불러오기 메소드
	public Building selectOneobuilding(String building) {
		String sql = "SELECT * FROM BUILDING WHERE BUILDING_NAME = ?";
		Building building1 = new Building();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, building);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				building1.setbName(rs.getString("BUILDING_NAME"));
				building1.setbAddress(rs.getString("ADDRESS"));
				System.out.println(building1);
			}
		} catch (Exception e) {
			System.out.println("빌딩 셀렉트 오류");
		} finally {
			close();			
		}
		return building1;
	}
	
	//빌딩 정보 수정
	public int updateBuilding(Building building) {
		String sql = "UPDATE BUILDING SET BUILDING_NAME = ?, ADDRESS = ? WHERE BUILDING_NAME= ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, building.getbName());
			pstmt.setString(2, building.getbAddress());
			pstmt.setString(3, building.getbName());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("빌딩정보 수정 오류");
		} finally {
			close();			
		}
		// 데이터베이스 오류
		return -1;
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

	//빌딩 전체 불러오기
	public ArrayList<Building> selectBuildingAll() {
		System.out.println("BuildingDAO/start selectBuildingAll");
		ArrayList<Building> buildingArr = new ArrayList<Building>();
		String sql = "SELECT * FROM BUILDING";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Building building = new Building();

				building.setbName(rs.getString("BUILDING_NAME"));
				building.setbAddress(rs.getString("ADDRESS"));

				buildingArr.add(building);
			}
		} catch (Exception e) {
			System.out.println("빌딩 전체 불러오기 오류");
		} finally {
			close();
		}
		return buildingArr;
	}

	//해당하는 오피스 정보 불러오기
	public ArrayList<Office> selectOfficeByBuilding(String building) {
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
			System.out.println("오피스 불러오기 오류");
		} finally {
			close();
		}
		return officelArr;
	}	
}
