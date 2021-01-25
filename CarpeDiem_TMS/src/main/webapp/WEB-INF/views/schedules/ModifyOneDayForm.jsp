<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.standalone.min.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script type="text/javascript" src="./js/datepicker/popper.min.js"></script>
<body>
<div id="container">
	<div style="text-align: center;">
		<form style="text-align: center;" id="frm">
			<input type="hidden" name="onedaySeq" value="${onedaySeq}">
			<div>
		 		<input type="text" name="oneTitle" value="${oneDto.oneday_title}" maxlength="15" required="required"><br>
		 	</div>
		 	<div>
		 	<input class="from_date " name="oneDate" placeholder="여행일을 선택해 주세요" contenteditable="false" type="text">
<%-- 		 		<input type="text" name="oneDate" value="${fn:substring(oneDto.onedate, 0, 10)}" maxlength="10" required="required"> --%>
		 	</div>
		 	<div>
		 		<input type="button" value="수정하기" id="modifySubmit">
			</div>
		</form>
	</div>
</div>
</body>

<script type="text/javascript">


$('.from_date').datepicker({ 
    weekStart: 1, // 1이면 월요일부터 0이 디폴트
	autoclose: true,
	format : 'yyyy-mm-dd'
})
	.on('changeDate', function(selected){
		startDate = new Date(selected.date.valueOf()); // 선택한 날짜를 받아옴
	}); 
	
</script>


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
            },error : function() {
				alert("타이틀이나 날짜를 입력해주세요");
			}
        });
    });
</script>

</body>
</html>