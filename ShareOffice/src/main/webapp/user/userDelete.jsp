<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
import="java.sql.*" import="office.User_account"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="userDAO" class="dao.UserDAO" scope="page" />
<!DOCTYPE html>
<html lang="ko">
<head>
<title>User Delete</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../css/style.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center"><div class="col-md-6 text-center mb-5"></div></div>
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="login-wrap p-4 p-md-5">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="fa fa-user-o"></span>
						</div>
						<%
							String uEmail = (String) session.getAttribute("uEmail");
							User_account user = userDAO.selectOneuser(uEmail);
						%>
						<h3 class="text-center mb-4">회원 탈퇴</h3>
						<form id="form-1" action="userDeleteAction.jsp" class="login-form"
							method="post">
							<div class="form-group">
								아이디<br> <input type="email"
									class="form-control rounded-left" name="uEmail"
									value="<%=user.getuEmail()%>" readonly>
							</div>
							<div class="form-group">
								비밀번호<br> <input type="password"
									class="form-control rounded-left" name="uPassword" required>
							</div>
							<div class="form-group">
								비밀번호 확인<br> <input type="password"
									class="form-control rounded-left" name="uPassword2" required>
							</div>
							<div style="float: left; width: 47%" class="form-group">
								<button type="button"
									class="form-control btn btn-primary rounded submit px-3" onclick="deleteUser();">회원
									탈퇴</button>
							</div>
							<div style="float: right; width: 47%" class="form-group">
								<button type="button"
									class="form-control btn btn-primary rounded submit px-3"
									onclick="location.href='../pagemain/mainpage.jsp'">돌아가기</button>
							</div>
							<br>
							<br>
						</form>
						<%
							userDAO.close();
						%>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<script>
	function deleteUser() {
		if (confirm("정말 탈퇴하시겠습니까?")) {
			$("#form-1").submit();
		}
	}
</script>
</body>
</html>