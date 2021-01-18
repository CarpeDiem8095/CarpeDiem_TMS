<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고처리 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
	#container {
		width: 800px;
		height: 540px;
		margin: 40px auto;
	}
</style>
<script type="text/javascript" src="../js/support.js"></script>
</head>
<body>
	<div id="container">
		<h3>신고처리 게시판</h3>
		<form action="#">
			<input type = "hidden" name="seq" value="${seq}">
			<table class="table">
				<tr>
					<!-- 신고한 사람 -->
					<th>신고자</th>
					<td>
						<input type="text" class="form-control" name="reporter" value="신고한 사람" readonly>
					</td>
				</tr>
				<tr>
					<!-- 신고당한 사람 -->
					<th>신고대상</th>
					<td>
						<input type="text" class="form-control" name="report_subject" value="${detail.email}" readonly>
					</td>
				</tr>
				<tr>
					<th>신고사유</th>
					<td>
						<input type="text" class="form-control" name="report_type" value="${detail.report_type}" readonly>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<textarea rows="5" cols="65" class="form-control" name="content" readonly>${detail.content}</textarea>
					</td>
				</tr>
			</table>
			<div style="text-align: center;">
				<!-- email전송 test용 버튼 -->
				<input type="button" class="btn-warning" value="메일작성" onclick="location.href='./mailForm.do'">
				<input type="button" class="btn-warning" value="회원탈퇴" onclick="changeWithdrawal(${mDto.email})">
				<input type="button" class="btn-primary" value="신고처리" onclick="changeProcessingStatus(${detail.seq})">
				<input type="button" class="btn-primary" value="전체글목록" onclick="location.href='./reportBoard.do'">
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	function changeWithdrawal(val) {
		location.href="./changeWithdrawal.do?email=" + val;
	}

	function changeProcessingStatus(val) {
		location.href="./changeProcessingStatus.do?seq=" + val;
	}
</script>
</html>