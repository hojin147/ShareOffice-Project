<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Log in</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/style.css">
</head>

<body>	
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-7 col-lg-5">
					<div class="login-wrap p-4 p-md-5">
						<div class="icon d-flex align-items-center justify-content-center">
							<span class="fa fa-user-o"></span>
						</div>
						<h3 class="text-center mb-4">로그인</h3>
						<form class="login-form" method="post" action="loginAction.jsp">
							<div class="form-group">
								<input type="text" class="form-control rounded-left" placeholder="Email" name="uEmail" required>
							</div>
							<div class="form-group d-flex">
								<input type="password" class="form-control rounded-left" placeholder="Password" name="uPassword" required>
							</div>
							<div style="float: left; width: 47%" class="form-group">
								<input type="submit" class="form-control btn btn-primary rounded submit px-3" value="로그인">
							</div>
							<div style="float: right; width: 47%" class="form-group">
								<input type="button" class="form-control btn btn-primary rounded button px-3" value="회원가입" onclick="location.href='signup.jsp'">
							</div>
							<div class="form-group">
								<input type="button" class="form-control btn btn-primary rounded button px-3" value="돌아가기" onclick="location.href='../pagemain/mainpage.jsp'">
							</div>
							<div class="form-group d-md-flex">
								<div class="w-50">
									<a href="#">아이디 찾기</a>
								</div>
								<div class="w-50 text-md-right">
									<a href="#">비밀번호 찾기</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>