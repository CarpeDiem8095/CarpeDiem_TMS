<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<body>
<div class="modal_box">
	<div class="title_box">
		<!--비밀번호 찾기-->비밀번호 찾기	<img src="/res/img/modal/common/modal_close_btn.gif" class="modal_btn_close" alt="" onclick="et_modal_close();">
	</div>
	<div class="modal_content">
		<form action="/member/find_pw" method="post">
		<div class="input_title">
			<!--가입한 이메일-->이메일 주소		</div>
		<input type="text" name="email_address" id="email_address" class="modal_input" onkeyup="vali_mail();">
		<div class="input_sub_desc">
			등록한 이메일 주소를 입력해 주세요.<br>비밀번호 설정 방법을 이메일로 보내드립니다.<br>장시간 메일이 오지 않을 경우 스팸 메일함을 확인해<br>주세요.			
		</div>
	</form></div>
	<div class="modal_footer">
		<input type="button" class="m_btn_submit" id="form_submit" value="비밀번호 재설정">
	</div>
</div>
</head>
</body>
</html>