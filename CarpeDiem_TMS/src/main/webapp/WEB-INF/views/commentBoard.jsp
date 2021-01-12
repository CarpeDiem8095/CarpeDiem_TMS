<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 게시판</title>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>


	<div><a href="./iLikeit.do">♡</a></div>
		
	<div><input type="text"><input type="submit" value="작성"></div>

	<div>
	<c:forEach var="i" items="${commentList}" varStatus="vs">
	<div>
		<div class="showMeTheForm">
			${i.comm_seq}${i.email}${i.content}<input type="button" value="답글">
		</div>
		<div class="re_Form">  
			<input type="text"><input type="button" value="작성">
		</div>
	</div>
	</c:forEach>
	</div>

<script>
// 버튼 클릭 시 댓글 작성 폼 보이기

$(document).ready(function() {	
	$(".showMeTheForm").click(function(){
		$(this).parent().find(".re_Form").slideToggle('slow');
	});
 });
</script>
</body>
</html>