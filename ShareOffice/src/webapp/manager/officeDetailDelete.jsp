<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.OfficeDAO" import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="office" class="office.Office" scope="page" />
<jsp:setProperty name="office" property="oNum" property="oName"
property="oFloor" property="oPeople" property="oMonthlyRent" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Office Delete(관리자)</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		
		OfficeDAO officeDAO = new OfficeDAO();
		officeDAO.deleteOffice(office.getoNum());

		script.println("<script>");
		script.println("alert('삭제가 완료되었습니다.')");
		script.println("location.href = 'officeManager.jsp'");
		script.println("</script>");
	%>
</body>
</html>