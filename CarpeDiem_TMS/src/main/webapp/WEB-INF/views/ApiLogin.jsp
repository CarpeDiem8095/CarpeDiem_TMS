<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="389178713167-flq59s0etrbsa3k33baj0efa48e4ret1.apps.googleusercontent.com">
<title>로그인페이지입니다.</title>
<meta charset="UTF-8">
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script type="text/javascript" src="./js/naveridlogin_js_sdk_2.0.0.js"></script>
<body>
			<div class="usm-agree">
				<input type="checkbox" id="i_agree3" name="i_agree3" onclick="agrre_1()"><label
					for="i_agree3">회원탈퇴 주의사항(필수)</label>
			</div>
			<div class="usm-join-box">
				<p class="tit">제1장 총칙</p>
				<dl>
					<dt>
						<strong>개인정보보호법 제15조(개인정보의 수집·이용)에 의거 홈페이지 회원가입을 위한 개인정보를
							다음과 같이 수집·이용하고자 합니다.</strong>
					</dt>

					<dt>
						<strong>[개인정보의 수집 및 이용 목적]</strong>
					</dt>
					<dd>- 카르페디엠 홈페이지는 다음과 같은 목적을 위하여 개인정보를 수집, 이용합니다.</dd>
					<dd>- 카르페디엠 통합홈페이지 통합 회원관리</dd>
					<dd>- 제한적 본인 확인제에 따른 본인확인, 비밀번호 분실 시 본인확인 등</dd>
					<dd>- 개인식별, 부정이용 방지, 비인가 사용방지, 가입의사 확인</dd>
					<dd>- 만14세 미만 회원의 법정 대리인 동의여부 확인</dd>
					<dd>- 불만처리 등 민원처리, 공지사항 전달</dd>

					<dt>
						<strong>[개인정보 수집에 관한 사항]</strong>
					</dt>
					<dd>① 필수항목 : 이메일, 닉네임, 비밀번호, 본인확인인증정보, 14세미만 법정대리인
						인증정보</dd>
					<dd>② 선택항목 : 생년월일, 졸업년도(졸업생)</dd>

					<dt>
						<strong>[개인정보 보유 및 이용기간]</strong>
					</dt>
					<dd class="usm-clr-blue">귀하께서 입력하신 개인정보는 2년간 보유되며, 가입 후 매 2년이
						되는 시점에 회원의 동의에 의해 그 기간은 연장되며, 회원 탈퇴시 개인정보는 그 즉시 삭제됩니다.</dd>
					<dd class="usm-clr-blue">삭제 요청 및 홈페이지 탈퇴 시 까지의 개인정보는 회원으로 가입 한
						학교와 충청북도교육연구정보원 개인정보처리방침에 의거 보유 및 이용됩니다.</dd>
					<dd class="usm-clr-blue">다만, 탈퇴자의 아이디는 동일한 아이디의 중복 가입을 방지하기 위해
						보존하며, 기타 관계법령의 규정에 의하여 보존할 필요가 있는 경우 관계법령에 따릅니다.</dd>

					<dt>
						<strong>[개인정보 수집·이용에 대한 동의를 거부할 권리]</strong>
					</dt>
					<dd>귀하께서는 상기의 개인정보 수집 및 이용에 대하여 동의를 거부할 수 있습니다.</dd>
					<dd>필수항목의 경우 회원 가입 시 필요한 항목으로 동의 거부 시 회원가입이 제한되며, 선택 항목은 동의하지
						않아도 회원가입 및 서비스 거부를 하지 않습니다.(선택항목에 대하여 차후에 회원정보수정을 통하여 정보를 입력할 수
						있으며 입력된 항목은 동의를 한 것으로 간주 합니다.)</dd>
				</dl>
			
<div>
    <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
</div>
</div>
    <script>
      function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
        console.log('Full Name: ' + profile.getNickname());
//         console.log('Given Name: ' + profile.getGivenName());
//         console.log('Family Name: ' + profile.getFamilyName());
//         console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());

        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
        $.ajax({
      	  url:"./loginafter.do",
      	  type:"POST",
      	  data:{"id":profile.getNickname(),"email":profile.getEmail()},
      	  dataType:"json",
      	  success:function(){
      		  alert("성공");
      	  },
      	  error:function(){
      		  alert("실패");
// 		location.href="./loginafter.do";
      	  }
        });
      }
      
      //네이버
     var naver_id_login = new naver_id_login("XSNm6RA9OmQcBhrv9Ezg", "http//:localhost:8091/CarpeDiem_TMS/ApiLogin.jsp"); // 역시 마찬가지로 'localhost'가 포함된 CallBack URL
		
		// 접근 토큰 값 출력
		alert(naver_id_login.oauthParams.access_token);
		
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			alert(naver_id_login.getProfileData('email'));
			alert(naver_id_login.getProfileData('nickname'));
		}
      
    </script>
    <div>
<!--     <ul> -->
<%--     <li class="userboard nav-item">회원 아이디 :${mDto.email} <br> --%>
<%-- 					회원 이름 :${mDto.ninkname}  --%>
<!-- 					<a href="./logout.do">로그아웃</a> -->
<!-- 		</li> -->
<!-- 		</ul> -->
    </div>
</body>
</html>