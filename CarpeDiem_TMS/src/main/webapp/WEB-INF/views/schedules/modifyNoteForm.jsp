<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>노트 수정 폼 입니다.</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
	<form style="text-align: center;" id="frm">
		<p>당신의 노트를 수정해 주세요</p>
		<input type="hidden" name="seq" value="${seq}">
	 	<input type="text" name="title" value="${note_Title}" maxlength="15" required="required">
	 	<input type="button" value="변경하기" id="modifySubmit">
	</form>
</body>

<script type="text/javascript">
	$('input[type="text"]').keydown(function() {
 	 if (event.keyCode === 13) {
    event.preventDefault();
  		};
	});
	
	$("#modifySubmit").click(function(){
        var frm = $("#frm").serialize();
        $.ajax({
            type : "post", // post방식으로 전송
            url : "./modifyNote.do",
            data : frm, 
            success : function(data){
            	alert("성공");
                self.close();
                window.opener.location.reload();
            },error : function() {
				alert("타이틀을 입력해주세요");
			}
        });
    });
	

</script>
</html>