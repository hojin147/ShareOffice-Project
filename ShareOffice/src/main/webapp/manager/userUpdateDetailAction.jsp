<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.UserDAO" import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="office.User_account" scope="page" />
<jsp:setProperty name="user" property="uEmail" />
<jsp:setProperty name="user" property="uPassword" />
<jsp:setProperty name="user" property="uName" />
<jsp:setProperty name="user" property="uPhone" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>User Update(관리자)</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();

		//비밀번호는 4자~12자 사이
		if(user.getuPassword().length() < 4 || user.getuPassword().length() > 12) {
			script.println("<script>");
			script.println("alert('비밀번호는 4자에서 12자 사이로 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
				
		//수정 성공
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.updateUser(user);
			script.println("<script>");
			script.println("alert('정보수정이 완료되었습니다.')");
			script.println("location.href = 'userManager.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>