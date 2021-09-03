<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.OfficeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="office" class="office.Office" scope="page" />
<jsp:setProperty name="office" property="oNum" />
<jsp:setProperty name="office" property="oName" />
<jsp:setProperty name="office" property="oFloor" />
<jsp:setProperty name="office" property="oPeople" />
<jsp:setProperty name="office" property="oMonthlyRent" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Office Update(관리자)</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		
		OfficeDAO officeDAO = new OfficeDAO();
		officeDAO.updateOffice(office);

		script.println("<script>");
		script.println("alert('정보수정이 완료되었습니다.')");
		script.println("location.href = 'officeManager.jsp'");
		script.println("</script>");
	%>
</body>
</html>