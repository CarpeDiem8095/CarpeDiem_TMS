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
			<input type = "hidden" name="reporter_email" value="${detail.reporter_email}">
			<input type = "hidden" name="subject_email" value="${detail.subject_email}">
			<table class="table">
				<tr>
					<!-- 신고한 사람 -->
					<th>신고자</th>
					<td>
						<input type="text" class="form-control" name="reporter" value="${detail.reporter_email}" readonly>
					</td>
				</tr>
				<tr>
					<!-- 신고당한 사람 -->
					<th>신고대상</th>
					<td>
						<input type="text" class="form-control" name="report_subject" value="${detail.subject_email}" readonly>
					</td>
				</tr>
				<tr>
					<th>신고사유</th>
					<td>
						<input type="text" class="form-control" name="report_type" value="${detail.report_type}" readonly>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="5" cols="65" class="form-control" name="content" readonly>${detail.content}</textarea>
					</td>
				</tr>
			</table>
			<div style="text-align: center;">
				<input type="button" class="btn-primary" value="to.신고자" onclick="location.href='./mailForm.do?seq=${detail.seq}&reporter_email=${detail.reporter_email}'">
				<input type="button" class="btn-primary" value="to.신고대상" onclick="location.href='./mailForm2.do?seq=${detail.seq}&subject_email=${detail.subject_email}'">
				<input type="button" class="btn-primary" value="신고처리 완료" onclick="changeWithdrawal('${detail.subject_email}', '${detail.seq}')">
<%-- 				<input type="button" class="btn-primary" value="신고처리" onclick="changeProcessingStatus(${detail.seq})"> --%>
				<input type="button" class="btn-primary" value="전체글목록" onclick="location.href='./reportBoard.do'">
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	function changeWithdrawal(email, seq) {
		location.href="./reportProcessing.do?email=" + email + "&seq=" + seq;
	}
</script>
</html>