<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.sql.*" import="dao.UserDAO" import="office.User_account"
import="dao.UserDAO" import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user1" class="dao.UserDAO" scope="page" />
<jsp:useBean id="user" class="office.User_account" scope="page" />
<jsp:setProperty name="user" property="uEmail" />
<jsp:setProperty name="user" property="uPassword" />
<jsp:setProperty name="user" property="uName" />
<jsp:setProperty name="user" property="uPhone" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User DeleteManager</title>
</head>
<body>
	<%	
		PrintWriter script = response.getWriter();
		String email = request.getParameter("uEmail");
		UserDAO userDAO = new UserDAO();
		userDAO.deleteUserManager(email);
		
		script.println("<script>");
		script.println("alert('탈퇴되었습니다.')");
		script.println("location.href = 'userManager.jsp'");
		script.println("</script>");	
	%>
</body>
</html>