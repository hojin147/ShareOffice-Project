<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="office.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="userDAO" class="dao.UserDAO" scope="page" />
<jsp:useBean id="companyDAO" class="dao.CompanyDAO" scope="page" />
<jsp:useBean id="officeDAO" class="dao.OfficeDAO" scope="page" />
<jsp:useBean id="buildingDAO" class="dao.BuildingDAO" scope="page" />
<jsp:useBean id="reservationDAO" class="dao.ReservationDAO" scope="page" />
<%
	PrintWriter writer = response.getWriter();
	
	//-----------------------------------------------------------------------인실,오피스 리스트 받아오기
	String building = request.getParameter("building");
	String officeKinds = request.getParameter("officeKinds");
	
	if (officeKinds != null) {
		writer.println(
		officeDAO.selectOfficeListByBuilding(building, officeKinds).toString().replace("[", "").replace("]", ""));
		return;
	}
	if (building != null) {
		writer.println(officeDAO.selectOfficeCategoryByBuilding(building).toString().replace("[", "").replace("]", ""));
		return;
	}
	
	//-----------------------------------------------------------------------서브밋 파라메터 받아오기
	String rvType = request.getParameter("rvType");
	String rvBname = request.getParameter("rvBname");
	String rvOname = request.getParameter("rvOname");
	
	int rvPeriod = 0;
	if (request.getParameter("rvPeriod") != null) {
		rvPeriod = Integer.parseInt(request.getParameter("rvPeriod"));
	}
	
	Date rvIndate = null;
	if (request.getParameter("rvIndate") != null) {
		rvIndate = Date.valueOf((String) request.getParameter("rvIndate") + "-1");
	}
	
	String uEmail = (String) request.getParameter("uEmail");
	String uName = (String) request.getParameter("uName");
	String uPhone = (String) request.getParameter("uPhone");
	
	String cName = (String) request.getParameter("cName");
	String cBuznum = (String) request.getParameter("cName");
	String cRepersentative = (String) request.getParameter("cRepersentative");
	String cPhone = (String) request.getParameter("cPhone");
	
	//----------------------------------------------------------        서브밋 수행
	Reservation reservation = new Reservation();
	
	reservation.setRvBname(rvBname);
	reservation.setRvOname(rvOname);
	reservation.setRvPeriod(rvPeriod);
	
	//기간에 따른 할인 비율 적용 6개월 이상은 5%할인 12개월은 10%할인
	double rate = 1;
	if (rvPeriod >= 6)
		rate = 0.95;
	if (rvPeriod >= 12)
		rate = 0.9;
	int rvTotalPrice = (int) (rvPeriod * 300_000 * rate);
	
	reservation.setRvTotalprice(rvTotalPrice);
	reservation.setRvIndate(rvIndate);
	
	//indate에 period를 더해서 enddate계산
	Calendar cal = Calendar.getInstance();
	cal.setTime(rvIndate);
	cal.add(Calendar.MONTH, rvPeriod);
	cal.add(Calendar.DATE, -1);
	Date rvEnddate = new Date(cal.getTimeInMillis());
	
	reservation.setRvIndate(rvIndate);
	reservation.setRvEnddate(rvEnddate);
	reservation.setRvStatus("예약중");
	reservation.setRvEmail(uEmail);
	reservation.setRvType(rvType);
	
	//개인과 기업에따라 메소드를 달리함
	try {
		companyDAO.setAutoCommitFalse();
		if (rvType.equals("개인")) {
			reservationDAO.insertReservation(reservation);
		} else if (rvType.equals("기업")) {
			Companyinfo_history company;
			Companyinfo_history latestCompany = companyDAO.selectLatestCompany(uEmail);
	
			//히스토리에 자료가 없거나 있지만 가장최근 자료가 현재 입력한 회사와 다를때 새로운 회사 입력
			if (latestCompany.getcName() == null || !latestCompany.getcName().equals(cName)) {
				company = new Companyinfo_history();
				company.setcEmail(uEmail);
				company.setcBuznum(cBuznum);
				company.setcRepersentative(cRepersentative);
				company.setcName(cName);
				company.setcPhone(cPhone);
				companyDAO.insertCompany(company);
			} else {
			}
	
			reservationDAO.insertReservation(reservation);
		}
		
		companyDAO.commit();
		writer.println("<script>");
		writer.println("alert('예약에 성공했습니다')");
		writer.println("location.href = '../pagemain/mainpage.jsp'");
		writer.println("</script>");
	} catch (Exception e) {
		companyDAO.rollback();
		e.printStackTrace();
		writer.println("<script>");
		writer.println("alert('예약에 실패했습니다')");
		writer.println("history.back()");
		writer.println("</script>");
	} finally{
		companyDAO.setAutoCommitTrue();
	}

// System.out.println(rvType+","+rvBname+","+rvOname+","+rvPeriod+","+rvIndate+","+uEmail+","+uName+","+uPhone+",
// 		"+cName+","+cBuznum+","+cRepersentative+","+cPhone+",");
%>