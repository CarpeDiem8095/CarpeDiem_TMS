	function loginChkeck(){
	var email = $("#InputEmail").val();
	var password = $("#InputPassword").val();
	$.ajax({ 
				type:"post",
				url:"./loginCheckMap.do",
				data:"email="+email+"&password="+password,
				success:function(msg){
					if(msg.isc=="성공"){
					$(".login").css('display','none');
					$(".join").css('display','none');
					$(".userboard").css('display','block');
					selmychatboard();
					}else{
						alert("이메일 또는 비밀번호가 맞지 않습니다.");
					}
					location.reload();
				},
				error:function(){
					alert("로그인에 문제가 발생했습니다.");
				}
			});
	}
	
	function accessChating(){
		var email = $("#userid").val();
		$.ajax({
			type:"post",
			url:"./mainchat.do",
			data:"userid="+email,
			success:function(){
			},error:function(){
				alert("채팅접속에 문제가 발생하였습니다.");
			}
		});
	}
	
	function selmychatboard(){
		$.ajax({
			type:"post",
			url:"./selmychatboard.do",
			success:function(){
				alert("채팅목록 성공");
			},error:function(){
				alert("채팅목록 실패");
			}
		});
	}
	
	function checklogining(){
		var email = $("#userid").val();
		if(email==null || email==''){
			alert("로그인을 하셔야 합니다.");
		}else{
			$("#boardserch").prop('href', "./boardsearch.do");
		}
	}
	
	function checklogining_schedules(){
		var email = $("#userid").val();
		if(email==null || email==''){
			alert("로그인을 하셔야 합니다.");
		}else{
			$(".checklogining_schedules").prop('href', "./notePaging.do");
		}
	}
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
//	 	alert("작동");
		var email = $("#email").val();
		$.ajax({
			
			type:"POST",
			url:"./mailCheck.do",
			data:"email="+email,
			success:function(data){
				if (data.checkNum=="false") {
					alert("이미 존재하는 이메일 입니다.");
				}else{
					alert("인증번호전송");
					$("#checkNum").attr("value",data.checkNum);	
				}

			}
		});
	}

	function emailOk(){
		var Checkinput = $("#inputCheckNum").val();
		var checkrm = $("#checkNum").val();
//	 	alert(checkrm);
		console.log(Checkinput);
		console.log(checkNum);
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

	//닉네임 정규화
	function nicknameCheck(){
//	 	alert("작동");
		var nickNameCheck = /^[가-힣a-zA-Z0-9]{2,10}$/;
		var nickname = $("#nickname").val();
//	 	alert(nickname);
		
		if(!nickNameCheck.test(nickname)){
			$("#nicknameCheck").css("color","red");
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
//	 	alert("작동");
		var regExpPw = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;

		var passwordch1 = $("#pwd").val();
		if(!regExpPw.test(passwordch1)) {
			$("#passwordch1").css("color","red");
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
			$("#passwordch2").css("color","red");
			$("#passwordch2").html("비밀번호가 일치하지 않습니다.");
			$("#allcheckpwd2").attr("value","0");
		}
		
		
	}

	function checkall(){
		var allemail = $("#allcheckemail").val();
		var allnum = $("#allchecknum").val();
		var allninkname = $("#allcheckninkname").val();
		var allpwd1= $("#allcheckpwd1").val();
		var allpwd2= $("#allcheckpwd2").val();

		if (allemail==0) {
			$("#allcheckemail").focus();
			alert("이메일이 확인이 되지 않았습니다.");
			return false;
		}else if (allnum==0) {
			$("#allchecknum").focus();
			alert("인증번호가 확인이 되지 않았습니다.");
			return false;
		}else if (allninkname==0) {
			$("#allcheckninkname").focus();
			alert("닉네임이 확인이 되지 않았습니다.");
			return false;
		}else if (allpwd1==0) {
			$("#allcheckpwd1").focus();
			alert("비밀번호가 확인이 되지 않았습니다.");
			return false;
		}else if (allpwd2==0) {
			$("#allcheckpwd2").focus();
			alert("비밀번호가 확인이 되지 않았습니다.");
			return false;
		}else{
			return true;
		}



	}
	//로그인 중복검사
	function loginEmail(){

		var emailRul = /^[0-9a-zA-Z]([-.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		 var InputEmail = $("#InputEmail").val();
//	 	 alert(InputEmail)
		if(!emailRul.test(InputEmail)) {
		   $("#emailRul").css("color","red");
//		   $("#emailRul").html("잘못된 형식입니다.");
//	 	   $("#InputEmail").attr("value","0");
		}else{
			$("#emailRul").css("color","green");
//			$("#emailRul").html("올바른 형식입니다.");
//	 		$("#InputEmail").attr("value","1");
//	 		$("#sendCheckNum").attr("onclick","emailsend()");
		}
		
	}
	function gg_login(){
		// $('#content_wrap').hide();
		// parent.$('#modal_view').css('background','transparent');
		// $('#loading_wrap').show();
		// window.open('/gauth','earthtory login','width=400, height=450, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
		//location.href='/gauth';
		window.open('./loginapi.do','earthtory_login','width=400, height=450, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
	}