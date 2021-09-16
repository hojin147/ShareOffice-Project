<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.UserDAO" import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="office.User_account" scope="page" />
<jsp:useBean id="userDAO" class="dao.UserDAO" scope="page" />
<jsp:setProperty name="user" property="uEmail" property="uPassword"
property="uName" property="uPhone" />
<%
	PrintWriter script = response.getWriter();
	int result = userDAO.deleteUser(user);
	if (result == 1) {
		script.println("<script>");
		script.println("alert('탈퇴되었습니다.')");
		script.println("location.href='../pagemain/mainpage.jsp'");
		script.println("</script>");
	} else{
		script.println("<script>");
		script.println("alert('탈퇴에 실패했습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>

