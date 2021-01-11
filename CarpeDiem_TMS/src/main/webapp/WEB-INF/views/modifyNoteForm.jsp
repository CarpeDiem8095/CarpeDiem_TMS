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
		<input type="hidden" name="seq" value="${seq}">
		<input type="hidden" name="email" value="${email}">
	 	<input type="text" name="title">
	 	<input type="button" value="수정하기" id="modifySubmit">
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
            }
        });
    });

</script>
</html>