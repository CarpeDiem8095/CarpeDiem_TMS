<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>노트 작성 폼</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
	<form style="text-align: center;" id="frm">
		<p>당신의 노트를 생성해 주세요</p>
	 	<input type="text" name="title">
	 	<input type="button" value="작성하기" id="writeSubmit">
	</form>

</body>
<script type="text/javascript">
	$('input[type="text"]').keydown(function() {
 	 if (event.keyCode === 13) {
    event.preventDefault();
  		};
	});
	
	$("#writeSubmit").click(function(){
        var frm = $("#frm").serialize(); 
        $.ajax({
            type : "post", // post방식으로 전송
            url : "./writeNote.do",
            data : frm, 
            success : function(data){
            	alert("노트가 생성 되었습니다.");
                self.close();
                window.opener.location.reload();
            }
        });
    });
</script>
</html>