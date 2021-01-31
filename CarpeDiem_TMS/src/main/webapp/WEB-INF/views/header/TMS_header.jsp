<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="389178713167-flq59s0etrbsa3k33baj0efa48e4ret1.apps.googleusercontent.com">
<meta charset="UTF-8">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:500,700&display=swap&subset=latin-ext"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600&display=swap&subset=latin-ext"
	rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/swiper.css" rel="stylesheet">
<link href="css/magnific-popup.css" rel="stylesheet">
<link href="css/fontawesome-all.css" rel="stylesheet">
<link rel="icon" href="images/favicon.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"/>
<link href="css/styles.css" rel="stylesheet">
</head>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://apis.google.com/js/platform.js" defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script type="text/javascript" src="./js/member/main_member_chat.js"></script>
<script>
	$(document).ready(function(){
		var id = '${mDto.email}';
		if(id =='' || id == null){
			$(".userboard").css("display","none");
		}else{
			$(".login").css('display','none');
			$(".join").css('display','none');
			accessChating();
		}
	});
</script>
<body>
	<!-- Preloader -->
	<div class="spinner-wrapper">
		<div class="spinner">
			<div class="bounce1"></div>
			<div class="bounce2"></div>
			<div class="bounce3"></div>
		</div>
	</div>
	<!-- end of preloader -->


	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-md navbar-dark navbar-custom fixed-top">
		<!-- Text Logo - Use this if you don't have a graphic logo -->
		<!-- <a class="navbar-brand logo-text page-scroll" href="index.html">Aria</a> -->

		<!-- Image Logo -->
		<a class="navbar-brand logo-image" href="./mainpage.do"><img
			src="images/calo2.png" alt="alternative" style="width: 165px; height: 50px;"></a>

		<!-- Mobile Menu Toggle Button -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarsExampleDefault"
			aria-controls="navbarsExampleDefault" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-awesome fas fa-bars"></span> <span
				class="navbar-toggler-awesome fas fa-times"></span>
		</button>
		<!-- end of mobile menu toggle button -->

		<div class="collapse navbar-collapse" id="navbarsExampleDefault">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link page-scroll"
					href="#header">HOME <span class="sr-only">(current)</span></a></li>
				<li class="nav-item"><a
					class="nav-link page-scroll checklogining_schedules"
					onclick="checklogining_schedules()">일정 관리</a></li>
				<li class="nav-item"><a class="nav-link page-scroll"
					href="./oneBoardList.do">리뷰 보기</a></li>
				<li class="nav-item"><a class="nav-link page-scroll"
					id="boardserch" onclick="checklogining()">동행찾기 게시판</a></li>
				<li class="nav-item"><a class="nav-link page-scroll"
					href="./questionBoard.do">문의하기</a></li>
				<c:if test="${mDto.auth eq 'A'}">
					<li class="nav-item"><a class="nav-link page-scroll"
						href="./reportBoard.do">신고처리</a></li>
				</c:if>
				<li class="userboard nav-item"><a class="nav-link page-scroll"
					href="./mypage.do">마이페이지(${mDto.email})</a></li>
				<li class="userboard nav-item"><a class="nav-link page-scroll"
					href="./questionBoardAdmin.do">관리자페이지</a></li>
				<c:if test="${mDto.auth eq 'A'}"></c:if>
				<li>
					<button type="button" class="btn btn-primary join"
						data-toggle="modal" data-target="#myModal">회원가입</button>
					<button type="button" class="btn btn-primary login"
						data-toggle="modal" data-target="#loginModal">로그인</button>
				</li>
				<li class="userboard nav-item">회원 아이디 :${mDto.email} <br><br>
					회원 이름 :${mDto.nickname} <a href="./logout.do" onclick="SignOut()">로그아웃</a>
				</li>
			</ul>
		</div>
	</nav>
	<!-- end of navbar -->
	<!-- end of navbar -->
	<input type="hidden" id="userid" value="${mDto.email}">


	<!-- 모든 인증이 완료되면 회원가입실행 -->
	<input type="hidden" id="allcheckemail" value="0">
	<input type="hidden" id="allchecknum" value="0">
	<input type="hidden" id="allcheckninkname" value="0">
	<input type="hidden" id="allcheckpwd1" value="0">
	<input type="hidden" id="allcheckpwd2" value="0">

	<input type="hidden" id="checkNum">
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">CarpeDiem</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form action="./joinform.do" class="form-horizontal" method="POST"
						id="Frm" name="Frm" onsubmit="return checkall();">
						<div class="modal-body" style="padding: 30px 50px; height: 620px;">
							<div class="form-group" style="text-align: left; width: 72%"
								id="divEmail">
								<!-- 이메일 확인 -->
								<label for="email"> <span
									class="glyphicon glyphicon-user"></span> 이메일
								</label> <input type="text" class="email form-control" id="email"
									name="email" placeholder="이메일을 입력하세요" onkeyup="emailCheck()">
								<span id="emailCheck" class="glyphicon glyphicon-user email"></span>
							</div>

							<div class="form-group"
								style="float: right; margin-top: -53px; margin-right: 10px"
								id="divinputCheckNum">
								<button type="button" class="btn btn-primary btn-block"
									id="sendCheckNum">
									<span class="glyphicon glyphicon-envelope"></span>인증
								</button>
							</div>

							<!-- 인증번호 -->
							<div class="form-group" style="text-align: left; width: 72%"
								id="divCheckNum">
								<label for="checknum"><span
									class="glyphicon glyphicon-envelope"></span> 인증번호</label> <input
									type="text" class="form-control" id="inputCheckNum"
									name="inputCheckNum" placeholder="인증번호를 입력하세요"> <span
									id="Checkinput"
									class="glyphicon glyphicon-envelope inputCheckNum"></span>
							</div>
							<!-- 인증번호 확인및 완료 -->
							<div class="form-group"
								style="float: right; margin-top: -53px; margin-right: 10px"
								id="divCheckConfirm">
								<button type="button" class="btn btn-primary btn-block"
									id="checkConfirm" name="checkConfirm" onclick="emailOk()">
									<span class="glyphicon glyphicon-ok"></span>확인
								</button>

							</div>
							<hr>
							<!-- 닉네임 확인 -->
							<div class="form-group" id="divNickname"
								style="text-align: left;">
								<label for="nickname"> <span
									class="glyphicon glyphicon-apple"></span> 닉네임
								</label> <input type="text" class="pwd form-control" id="nickname"
									name="nickname" placeholder="사용하실 닉네임을 입력하세요.(2자리 이상)"
									onkeyup="nicknameCheck()"> <span id="nicknameCheck"
									class="glyphicon glyphicon-apple nickname"></span>
							</div>
							<!-- 비밀번호 -->
							<div class="form-group" id="divPwd" style="text-align: left;">
								<label for="psw"> <span
									class="glyphicon glyphicon-eye-open"></span> 1차 비밀번호
								</label> <input type="password" class="pwd form-control" id="pwd"
									name="password" placeholder="1차 비밀번호를 입력하세요(8자리 이상)"
									onkeyup="passwordcheck()"> <span id="passwordch1"
									class="glyphicon glyphicon-eye-open passwordch1"></span>
							</div>
							<!-- 2차비밀번호 -->
							<div class="form-group" id="divPwd2" style="text-align: left;">
								<label for="psw"><span
									class="glyphicon glyphicon-eye-open"></span> 2차 비밀번호</label> <input
									type="password" class="form-control" id="pwd2" name="pwd2"
									placeholder="2차 비밀번호를 입력하세요(8자리 이상)" onkeyup="passwordch2()">
								<span id="passwordch2"
									class="glyphicon glyphicon-eye-open passwordch2"></span>
							</div>
						</div>

						<!-- 완료 -->
						<div class="modal-footer">

							<button type="submit" id="signYes" name="signYes"
								class="btn btn-success btn-default pull-left" value="Send"
								style="margin: 10px;">
								<span class="glyphicon glyphicon-plus"></span>완 료
							</button>

							<button type="button" id="button" onclick="history.go(0);"
								class="btn btn-danger btn-default pull-left"
								data-dismiss="modal" value="Reset" style="margin: 10px">
								<span class="glyphicon glyphicon-remove"></span>취 소
							</button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>

	<!-- 로그인 모달 -->

	<div class="modal fade" id="loginModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">CarpeDiem</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form method="post" name="frm">
						<div class="form-group has-feedback">
							<input type="text" id="InputEmail" class="form-control"
								placeholder="이메일" onkeyup="loginEmail()"> <span
								id="loginEmail"
								class="glyphicon glyphicon-exclamation-sign form-control-feedback InputEmail"></span>
						</div>

						<div class="form-group has-feedback">
							<input type="password" id="InputPassword" class="form-control"
								placeholder="비밀번호" onkeyup="enterkey()"> <span
								class="glyphicon glyphicon-lock form-control-feedback"></span>
						</div>

						<div class="row" style="margin-left: 10px">
							<div class="col-xs-4" style="margin-top: -5px;">
								<input type="button" id="login" name="login" value="로그인"
									onclick="loginChkeck()"
									class="btn btn-primary btn-block btn-flat"> <a
									href="./findpw.do">비밀번호 찾기</a><br>
							</div>
						</div>
						<hr>
						<div id="naver_id_login"></div>
						<hr>
							<div class="g-signin2" data-onsuccess="onSignIn"
								data-theme="dark"></div>	
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="./js/chatting/mainchat.js"></script>