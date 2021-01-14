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
</head>
<body>
	<div id="container">
		<h3>신고처리 게시판</h3>
		<table class="table">
			<tr>
				<th>신고대상</th>
				<td>
					<input type="text" class="form-control" name="" value="원본글 작성자(신고대상)" readonly>
				</td>
			</tr>
			<tr>
				<th>신고자</th>
				<td>
					<input type="text" class="form-control" name="" value="신고글 작성자" readonly>
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
					<input type="text" class="form-control" name="content" value="${detail.content}" readonly>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>