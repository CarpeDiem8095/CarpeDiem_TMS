<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 작성 양식</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
	#container {
		width: 800px;
		height: 540px;
		margin: 40px auto;
	}
</style>
</head>
<body>
	<!-- 신고자에게 보내는 메일 -->
	<div id="container" class="table-responsive">
		<h3>메일 작성</h3>
		<form action="./sendEmail.do" method="post">
			<input type = "hidden" name="seq" value="${seq}">
			<input type = "hidden" name="reporter_email" value="${rDto.reporter_email}">
			<table class="table">
				<tr>
					<th>받는 사람</th>
					<td>
						<input type="email" class="form-control" name="receiver" value="${rDto.reporter_email}" readonly>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" class="form-control" name="title" value="회원님께서 신고하신 내역에 대한 답변입니다." readonly>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea class="form-control" rows="10" cols="90" name="content" required></textarea>
					</td>
				</tr>
			</table>
			<div style="text-align: center; padding-bottom: 20px;">
				<input type="submit" class="btn btn-info" value="메일전송">
  				<input type="reset" class="btn btn-info" value="다시작성">
				<input type="button" class="btn btn-info" value="취소" onclick="location.href='./reportDetail.do?seq=${rDto.seq}'" style="width: 82px;">
			</div>
		</form>
	</div>
</body>
</html>