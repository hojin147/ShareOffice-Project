<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="office.User_account" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="user1" class="dao.UserDAO" scope="page" />
<%@ page import="dao.UserDAO" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>회원 정보 수정(관리자)</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style.css">
</head>

<body>

	<%
		String E_mail = request.getParameter("E_mail");
		User_account user = user1.selectOneuser(E_mail);
		
		String Email = user.getuEmail();
		String Password = user.getuPassword();
		String Name = user.getuName();
		String Phone = user.getuPhone();
	%>
	
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center"><div class="col-md-6 text-center mb-5"></div></div>
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="login-wrap p-4 p-md-5">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="fa fa-user-o"></span>
						</div>
						<h3 class="text-center mb-4">회원 정보 수정(관리자)</h3>
						<form class="login-form" method="post">
							<div class="form-group">
								아이디<br>
								<input type="email" class="form-control rounded-left" name="uEmail" value="<%=Email%>" readonly>
							</div>
							<div class="form-group">
								비밀번호<br>
								<input type="text" class="form-control rounded-left" name="uPassword" value="<%=Password%>" required>
							</div>
							<div class="form-group">
								이름<br>
								<input type="text" class="form-control rounded-left" name="uName" value="<%=Name%>" required>
							</div>
							<div class="form-group">
								연락처<br>
								<input type="text" class="form-control rounded-left" name="uPhone" value="<%=Phone%>" required>
							</div>
				            <div style="float: left; width: 47%" class="form-group">
								<input type="submit" class="form-control btn btn-primary rounded submit px-3" value="수정하기"
										onclick="javascript: form.action='userUpdateDetailAction.jsp';">
							</div>
							<div style="float: right; width: 47%" class="form-group">
								<input type="submit" class="form-control btn btn-primary rounded submit px-3" value="삭제하기"
										onclick="javascript: form.action='userDeleteManagerAction.jsp';">
							</div>
							<div class="form-group">
								<button type="button" class="form-control btn btn-primary rounded submit px-3"
										onclick="location.href='userManager.jsp'">돌아가기</button>
							</div>
	          			</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>