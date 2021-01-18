<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
	#container {
		width: 500px;
		height: 500px;
		margin: 40px auto;
	}
</style>
<script type="text/javascript">
	function RadioCheck(){
		// 체크된 번호 확인
		size = document.getElementsByName("report_type").length;
// 		alert("size: " + size);
		for (var i = 0; i < size; i++) {
			if (document.getElementsByName("report_type")[i].checked) {
				alert("value: " + document.getElementsByName("report_type")[i].value);
			}
		}
	}
</script>
</head>
<body>
	<div id="container">
		<h3 style="padding-bottom: 10px;">신고하기</h3>
		<hr>
		<form action="./report.do" method="post">
			<input type="hidden" name="seq" value="${seq}">
			<!-- session이 담고 있는 신고하는 사람의 email -->
			<input type="hidden" name="email" value="${email}">
			<div class="form-group">
				<!-- 신고대상 글 제목-->
				<label for="title">제목</label>
				<input type="text" class="form-control" name="title" value="${qDto.title}" readonly>
			</div>
			<div class="form-group">
				<!-- 신고대상 글 작성자 -->
				<label for="writer">작성자</label>
				<input type="text" class="form-control" name="writer" value="${qDto.writer}" readonly>
			</div>
			<hr>
			<div class="form-group">
				<label for="report_type">신고사유</label>
				<div class="radio">
					<label style="margin-left: 10px; margin-bottom: 5px;">
						<input type="radio" name="report_type" value="욕설/비방" onclick="RadioCheck()">욕설/비방<br>
						<input type="radio" name="report_type" value="부적절한 홍보 게시글" onclick="RadioCheck()">부적절한 홍보 게시글<br>
						<input type="radio" name="report_type" value="음란성 또는 청소년에게 부적합한 내용" onclick="RadioCheck()">음란성 또는 청소년에게 부적합한 내용<br>
						<input type="radio" name="report_type" value="명예훼손/사생활 침해 및 저작권 침해 등" onclick="RadioCheck()">명예훼손/사생활 침해 및 저작권 침해 등<br>
						<input type="radio" name="report_type" value="기타" onclick="RadioCheck()">기타
					</label><br>
					<textarea rows="5" cols="65" style="margin-top: 5px; margin-left: 10px;" name="content"></textarea>
				</div>
			</div>
				<div class="form-group" style="text-align: center"></div>
			<div style="text-align: center;">
				<input type="submit" class="btn-primary" value="신고하기">
				<input type="button" class="btn-primary" value="취소" onclick="location.href='./questionBoard.do'">
			</div>
		</form>
	</div>
</body>
</html>