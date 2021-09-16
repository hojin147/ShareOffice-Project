<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<title>Sign up</title>
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
						<h3 class="text-center mb-4">회원가입</h3>
						<form action="joinAction.jsp" class="login-form" method="post">
							<div class="form-group">
								아이디<br>
								<input type="email" class="form-control rounded-left" placeholder="아이디 (Email형식)" name="uEmail" required>
							</div>
							<div class="form-group">
								<button type="button" class="form-control btn btn-primary rounded submit px-3">email 인증하기</button>
							</div>
							<div class="form-group">
								비밀번호<br>
								<input type="password" class="form-control rounded-left" placeholder="비밀번호"  name="uPassword" required>
							</div>
							<div class="form-group">
								비밀번호 확인<br>
								<input type="password" class="form-control rounded-left" placeholder="비밀번호 확인"  name="uPassword2" required>
							</div>
							<div class="form-group">
								이름<br>
								<input type="text" class="form-control rounded-left" placeholder="이름"  name="uName" required>
							</div>
							<div class="form-group">
								연락처<br>
								<input type="text" class="form-control rounded-left" placeholder="연락처"  name="uPhone" required>
							</div>
				            <div style="float: left; width: 47%" class="form-group">
								<button type="submit" class="form-control btn btn-primary rounded submit px-3">등록하기</button>
							</div>
							<div style="float: right; width: 47%" class="form-group">
								<button type="button" class="form-control btn btn-primary rounded submit px-3" onclick="location.href='../pagemain/mainpage.jsp'">취소</button>
							</div>
							<br><br>
	          			</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
</body>
</html>