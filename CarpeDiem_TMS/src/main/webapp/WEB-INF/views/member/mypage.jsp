<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

function Withdrawal(){
	$("#myForm").attr("action","./delete.do");
	$("#myForm").submit();
}



function nicknameCheck(){
	var nickNameCheck = /^[가-힣a-zA-Z0-9]{2,10}$/;
	var nickname = $("#nickname").val();
// 	alert(nickname);
	
	if (!nickNameCheck.test(nickname)) {
		$("#nicknameCheck").css("color","orange");
		$("#nicknameCheck").html("잘못된 형식입니다.");
		$("#allcheckninkname").attr("value","0");
	}else{
		$("#nicknameCheck").css("color","green");
		$("#nicknameCheck").html("올바른 형식입니다.");
		$("#allcheckninkname").attr("value","1");
		
	}	
	
}

//비밀번호 정규화
function passwordcheck(){
// 	alert("작동");
	var regExpPw = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;

	var passwordch1 = $("#pwd").val();
	if(!regExpPw.test(passwordch1)) {
		$("#passwordch1").css("color","orange");
		$("#passwordch1").html("잘못된 형식입니다.");
		$("#allcheckpwd1").attr("value","0");
	}else{
		$("#passwordch1").css("color","green");
		$("#passwordch1").html("올바른 형식입니다.");
		$("#allcheckpwd1").attr("value","1");
	}
}

function passwordch2(){
	var passwordch1 = $("#pwd").val();
	var passwordch2 = $("#pwd2").val();
	
	
	if (passwordch1==passwordch2) {
		$("#passwordch2").css("color","green");
		$("#passwordch2").html("비밀번호가 일치합니다.");
		$("#allcheckpwd2").attr("value","1");
	}else{
		$("#passwordch2").css("color","orange");
		$("#passwordch2").html("비밀번호가 일치하지 않습니다.");
		$("#allcheckpwd2").attr("value","0");
	}
	
	
}

function checkChange(){
	var CCname = $("#allcheckninkname").val();
	var CCpwd1 = $("#allcheckpwd1").val();
	var CCpwd2 = $("#allcheckpwd2").val();
	
	if (CCname==0) {
		$("#allcheckninkname").focus();
		alert("닉네임이 존재합니다.");
		return false;
	}else if (CCpwd1==0) {
		$("#allcheckpwd1").focus();
		alert("비밀번호 확인이 되지 않았습니다.");
		return false;
	}else if (CCpwd2==0) {
		$("#allcheckpwd2").focus()
		alert("비밀번호가 확인이 되지 않았습니다.");
		return false;
	}else{
		return true;
	}
}


</script>
<title>마이페이지</title>
</head>
<body>
<!-- 닉네임, 비밀번호, 새로운 비밀번호가 일치되면 회원 변경 -->
<input type="hidden" id="allcheckninkname" value="0">
<input type="hidden" id="allcheckpwd1" value="0">
<input type="hidden" id="allcheckpwd2" value="0">

	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>My Page</h3>
			</div>
			<div>
				<form id="myForm" action="./update_mypage.do" method="post">
					<p>
						<label>Email</label> 
						<input class="w3-input" type="text" id="email" name="email" value="${mDto.email}" readonly="readonly"> 
					</p>
					<p>
						<label>NICKNAME</label> 
						<input class="w3-input" type="text" id="nickname" name="nickname" onkeyup="nicknameCheck()" required="required"> 
						<span id="nicknameCheck" class="glyphicon glyphicon-apple nickname"></span>
					</p>
					
					<p>
						<label>New Password</label> 
						
						<input class="w3-input" id="pwd" name="password" type="password" onkeyup="passwordcheck()" required="required" >
						<span id="passwordch1" class="glyphicon glyphicon-eye-open passwordch1"></span>
					</p>
					<p>
						<label>Confirm</label>
						<input class="w3-input" type="password" id="pwd2" name="pwd2" type="password" onkeyup="passwordch2()" required="required" >
						<span id="passwordch2" class="glyphicon glyphicon-eye-open passwordch2"></span>
					</p>
					<p class="w3-center">
						<button type="submit" id="joinBtn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round joinBtn" onclick="joinBtn()">회원정보 변경</button>
						<button type="button" onclick="history.go(-1);" class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">메인창으로</button>
						<button type="button" onclick="Withdrawal()" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" >회원탈퇴</button>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>