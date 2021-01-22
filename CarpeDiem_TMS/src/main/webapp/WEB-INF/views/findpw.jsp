<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
//이메일 중복검사
function emailCheck(){
	//이메일 정규식
	var emailRule = /^[0-9a-zA-Z]([-.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	 var email = $("#email").val();
	if(!emailRule.test(email)) {
	   $("#emailCheck").css("color","red");
	   $("#emailCheck").html("잘못된 형식입니다.");
	   $("#allcheckemail").attr("value","0");
	}else{
		$("#emailCheck").css("color","green");
		$("#emailCheck").html("올바른 형식입니다.");
		$("#allcheckemail").attr("value","1");
		$("#sendCheckNum").attr("onclick","emailsend()");
	}
	
}
//이메일 인증 처리
function emailsend(){
// 	alert("작동");
	var email = $("#email").val();
	$.ajax({
		
		type:"POST",
		url:"./mailCCk.do",
		data:"email="+email,
		success:function(data){
			if (data.checkNum=="flase") {
				alert("존재하지 않는 이메일 입니다.");
				$("#checkNum").attr("value",data.checkNum);	
			}else{
				alert("인증 번호 전송");
			}

		}
	});
}

function emailOk(){
	var Checkinput = $("#inputCheckNum").val();
	var checkrm = $("#checkNum").val();
// // 	alert(checkrm);
// 	console.log(Checkinput);
// 	console.log(checkNum);
	if (Checkinput==checkrm) {
		$("#Checkinput").css("color","green");
		$("#Checkinput").html("인증번호가 일치합니다.");
		$("#sendCheckNum").css('display','none');
		$("#checkConfirm").css('display','none');
		$("#inputCheckNum").attr("readonly","readonly")
		$("#allchecknum").attr("value","1");
	}else{
		$("#Checkinput").css("color","red");
		$("#Checkinput").html("인증번호가 일치하지않습니다.");
		$("#allchecknum").attr("value","0");
	}

}

	function finBtn() {
		alert("작동");

	}

	function checkall(){
		var allemail = $("#allcheckemail").val();
		var allnum = $("#allchecknum").val();

		if (allemail==0) {
			$("#allcheckemail").focus();
			alert("이메일이 확인이 되지 않았습니다.");
			return false;
		}else if (allnum==0) {
			$("#allchecknum").focus();
			alert("인증번호가 확인이 되지 않았습니다.");
			return false;
		}else{
			return true;
		}



	}

</script>
<style type="text/css">
.mybtn {
	width: 150px;
	height: 40px;
	padding: 0;
	display: inline;
	border-radius: 4px;
	background: #212529;
	color: #fff;
	margin-top: 20px;
	border: solid 2px #212529;
	transition: all 0.5s ease-in-out 0s;
}

.mybtn:hover .mybtn:focus {
	background: white;
	color: #212529;
	text-decoration: none;
}
</style>
<title>비밀번호 찾기</title>
</head>
<body>
<input type="hidden" id="allcheckemail" value="0">
<input type="hidden" id="allchecknum" value="0">
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4 w3-auto"
			style="width: 720px; height: 620px; padding: 30px 50px;">
			<div class="w3-center w3-large w3-margin-top" >
				<h3>비밀번호 찾기</h3>
				<hr>
				<div class="form-group" style="text-align: left; width: 72%">  
				<label for="email"> <span class="glyphicon glyphicon-user">
				</span> 이메일 :</label> <input type="text" class="email form-control" id="email"
					name="email" placeholder="이메일을 입력하세요" onkeyup="emailCheck()">
				<span id="emailCheck" class="glyphicon glyphicon-user email"></span>
				
				<div class="form-group"
					style="float: right;"
					id="divinputCheckNum">
					<button type="button" class="btn btn-primary btn-block"
						id="sendCheckNum">
						<span class="glyphicon glyphicon-envelope"></span>인증
					</button>
				</div>
		</div>
			
			
			<hr>
			<!-- 인증번호 -->
			<div class="form-group" style="text-align: left; width: 72%"
				id="divCheckNum">
				<label for="checknum"><span
					class="glyphicon glyphicon-envelope"></span> 인증번호 :</label> <input
					type="text" class="form-control" id="inputCheckNum"
					name="inputCheckNum" placeholder="인증번호를 입력하세요"> <span
					id="Checkinput" class="glyphicon glyphicon-envelope inputCheckNum"></span>
			
			<!-- 인증번호 확인및 완료 -->
			<div class="form-group"
				style="float: right;"
				id="divCheckConfirm">
				<button type="button" class="btn btn-primary btn-block"
					id="checkConfirm" name="checkConfirm" onclick="emailOk()">
					<span class="glyphicon glyphicon-ok"></span>확인
				</button>

			</div>
			</div>
				</div>
			<p class="w3-center">
				<button type="button" id="findBtn"
					class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn findBtn"
					onclick="finBtn()">찾기</button>
				<button type="button" onclick="history.go(-1);"
					class="w3-button w3-hover-white w3-ripple w3-margin-top w3-round mybtn">로그인으로</button>
			</p>
		</div>
	</div>

</body>
</html>