<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
	<div style="text-align: center;">
		<form style="text-align: center;" id="frm">
			<input type="hidden" name="onedaySeq" value="${onedaySeq}">
			<div>
		 		<input type="text" name="oneTitle" value="${oneDto.oneday_title}" ><br>
		 	</div>
		 	<div>
		 		<input type="text" name="oneDate" value="${fn:substring(oneDto.onedate, 0, 10)}" maxlength="10">
		 	</div>
		 	<div>
		 		<input type="button" value="수정하기" id="modifySubmit">
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
	
	$("#modifySubmit").click(function(){
        var frm = $("#frm").serialize(); 
        $.ajax({
            type : "post", // post방식으로 전송
            url : "./modifyOneday.do",
            data : frm, 
            success : function(data){
            	alert("성공");
                self.close();
                window.opener.location.reload();
            }
        });
    });
</script>
</body>
</html>