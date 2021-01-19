<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하루일정 작성 폼</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
	<div style="text-align: center;">
		<form style="text-align: center;" id="frm">
			<input type="hidden" name="seq" value="${seq}">
			<div>
		 		<input type="text" name="title" value="제주도 N일차" maxlength="10"><br>
		 	</div>
		 	<div>
		 		<input type="hidden" name="oneDate" value="${year}${month}${date}">
		 	</div>
		 	<div>
		 		<input type="button" value="작성하기" id="writeSubmit">
			</div>
		</form>
	</div>
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
            url : "./writeOneDay.do",
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