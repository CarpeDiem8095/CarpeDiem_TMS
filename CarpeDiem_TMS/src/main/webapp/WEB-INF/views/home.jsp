<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>카르페디엠</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<a href="./index.jsp"> <b>CarpeDiem</b>&nbsp; 일정여행관리
	</a>
	<!-- 회원가입  -->
	<div class="container" style="text-align: right;">

		<!-- 버튼 클릭시 모달창 생성 -->
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#myModal">회원가입</button>
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#loginModal">로그인</button>
		<!-- The Modal -->
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
						<form class="form-horizontal" method="POST" id="Frm" name="Frm">

							<div class="modal-body"
								style="padding: 30px 50px; height: 360px;">

								<div class="form-group" style="text-align:left; width: 72%"
									id="divEmail">
									
								<!-- 이메일 확인 -->
									<label for="email"><span
										class="glyphicon glyphicon-user"></span> 이메일</label> <input
										type="text" class="email form-control" id="email" name="email"
										placeholder="이메일을 입력하세요">
								</div>
								<div class="form-group" style="float: right; margin-top: -53px"
									id="divEmailCheck">
									<button type="button" class="btn btn-primary btn-block"
										name="emailCheck" id="emailCheck">
										<span class="glyphicon glyphicon-off"></span> 중복확인
									</button>
								</div>
								<!-- 닉네임 확인 -->
							<div class="form-group" id="divNickname" style="text-align: left;">
							<label for="nickname">
							<span class="glyphicon glyphicon-apple"></span> 닉네임</label>
							<input type="text" class="pwd form-control" id="nickname" name="nickname"
								placeholder="사용하실 닉네임을 입력하세요.(2자리 이상)">
							</div>
								<!-- 비밀번호 -->
								<div class="form-group" id="divPwd" style="text-align: left;">
							<label for="psw">
							<span class="glyphicon glyphicon-eye-open"></span> 1차 비밀번호</label>
							<input type="password" class="pwd form-control" id="pwd" name="pwd"
								placeholder="1차 비밀번호를 입력하세요(8자리 이상)">
						</div>
								<!-- 2차비밀번호 -->
								<div class="form-group" id="divPwd2" style="text-align: left;">
							<label for="psw"><span

								class="glyphicon glyphicon-eye-open"></span> 2차 비밀번호</label> <input
								type="password" class="form-control" id="pwd2" name="pwd2"
								placeholder="2차 비밀번호를 입력하세요(8자리 이상)">
							</div>
							<!-- 인증번호 -->
							<div class="form-group" style="text-align: left; width : 60%" id="divCheckNum">
							<label for="checknum"><span	class="glyphicon glyphicon-envelope"></span> 인증번호</label> 
							<input type="text" class="form-control" id="inputCheckNum" name="inputCheckNum" 
								   placeholder="인증번호를 입력하세요">
						</div>
						<!-- 인증번호 확인및 완료 -->
						<div class="form-group" style="float: right; margin-top: -53px" id="divCheckConfirm" >
							<button type="button" class="btn btn-primary btn-block" id="checkConfirm" name="checkConfirm">
								<span class="glyphicon glyphicon-ok"></span>확인
							</button>
						</div>
						<div class="form-group" style="float: right; margin-top: -53px; margin-right: 10px" id="divinputCheckNum">
							<button type="button" class="btn btn-primary btn-block"	id="sendCheckNum">
								<span class="glyphicon glyphicon-envelope"></span>인증</button>
						</div>
							</div>
						</form>
					</div>
					
					<!-- 완료 -->
					<div class="modal-footer">
					<button type="button" id="signYes" name="signYes" class="btn btn-success btn-default pull-left"  
						value="Send" style="margin: 10px; margin-right: 270px" disabled>
						<span class="glyphicon glyphicon-plus"></span>완 료</button>
						
						<button type="button" class="btn btn-danger btn-default pull-left" data-dismiss="modal" value="Input Button" style="margin: 10px">
						<span class="glyphicon glyphicon-remove"></span>취 소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 로그인 모달 -->	
<!-- The Modal -->
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
   
        <form action="${path}/views/loginPost" method="post">
            <div class="form-group has-feedback">
                <input type="text" name="Email" class="form-control" placeholder="이메일">
                <span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>
            </div>
            </form>
            <div class="form-group has-feedback">
                <input type="password" name="password" class="form-control" placeholder="비밀번호">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
             <div class="row" style="margin-left: 10px">
                
                    <div class="col-xs-4" style="margin-top: -5px;">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">
                        <i class="fa fa-sign-in"></i> 로그인
                    </button>
                    <a href="#">비밀번호 찾기</a><br>
               </div>
         </div>
         <hr>
         <div id="naver_id_login" style="text-align: center">
            <a href="#" class="btn btn-success">
             	N+네이버 계정 로그인
            </a>
            <a href="#" class="btn btn-primary">
                <i class="fa">&#xf0d5;</i> 구글 계정으로 로그인
            </a>
        </div>
         
         </div>
         
         
		</div>
	</div>
</div>
	<script>
	//이메일 중복확인
	$('#emailCheck').keyup(function(){
		
		$.ajax({
			type: "GET",
			url: "./authenticate.do",
			data: {"email":$('#emailCheck').val()},
			success: function(data){
				var result = data;
				if (result == 'success') {
					emailCheck = true;
					$('emailCheck').swal("사용 가능한 이메일입니다.");
					
				}else{
					emailCheck = false;
					$('#emailCheck').swal("이미 존재하는 이메일입니다.");
				}
			}
		});
	});
	
</script>
</body>
</html>