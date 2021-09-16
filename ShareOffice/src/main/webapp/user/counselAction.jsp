<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="dao.CounselDAO" import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="coun" class="office.Counsel" scope="page" />
<jsp:setProperty name="coun" property="sUseremail" />
<jsp:setProperty name="user" property="sSubject" />
<jsp:setProperty name="user" property="sContent" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Counsel</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
			
		CounselDAO counselDAO = new CounselDAO();
		int result = counselDAO.input(coun);
		
		if(result == -1) {
			script.println("<script>");
			script.println("alert('등록실패')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('상담신청이 정상적으로 등록되었습니다.')");
			script.println("location.href = '../pagemain/mainpage.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>