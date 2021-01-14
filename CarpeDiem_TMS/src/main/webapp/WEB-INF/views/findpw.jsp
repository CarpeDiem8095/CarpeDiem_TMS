<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<head>
<body>
	<div style="color: green;">입력한 이메일로 인증번호를 입력해주세요(인증번가 일치해야 비밀번호를 변경하실수 있습니다)</div>
	<br><br>
	<div style="text-align: center;">
		<form action="pass_injeug.do${dice},${e_mail}" method="POST">
			<div>
				인증번호 입력 : <input type="number" name="pass_injeug" placeholder="인증버호를 입력하세요">
			</div>
			<br><br>
			<button type="submit" name="submit">인증번호 전송</button>
		</form>
	</div>
	
	<span style="color: green; font-weight: bold;">변경할 비밀번호를 입력해주세요.</span> <br> <br>    
        <br> <br>
        
        <hr>
        
        <div style="text-align:center;">
            
                    <form action="pass_change.do${e_mail}" method="post">
                    
                    
                        <br>
                        <div>
                            변경할 비밀번호 입력 : <input type = "number" name = "member_pass"
                                                  placeholder = "비밀번호를 입력하세요." >
                        </div>                                        
 
                        <br> <br>
                        <button type="submit" name="submit">비밀번호 변경</button>
 
			        </form>
                        </div>
                 
        
	
</body>
</html>