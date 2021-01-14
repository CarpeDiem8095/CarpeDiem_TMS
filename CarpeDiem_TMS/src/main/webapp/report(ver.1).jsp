<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기(ver.1)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
	#container {
		width: 500px;
		height: 500px;
		margin: 40px auto;
	}
</style>
</head>
<body>
	<div id="container">
		<h3 style="padding-bottom: 10px;">신고하기(ver.1)</h3>
		<form class="form-horizontal" action="#">
			<table class="table">
				<tr>
					<th style="width: 110px; vertical-align: middle;">신고대상</th>
					<td>
						<input type="text" class="form-control" style="width: 400px" name="" value="원본글 작성자(신고대상)" readonly>
					</td>
				</tr>
				<tr>
					<th style="width: 110px; vertical-align: middle;">신고자</th>
					<td>
						<input type="text" class="form-control" style="width: 400px" name="" value="신고글 작성자" readonly>
					</td>
				</tr>
				<tr>
					<th style="width: 110px; padding-top: 15px;">신고사유</th>
					<td style="padding-top: 10px">
						<input type="radio" name="report_type">&nbsp;&nbsp;부적절한 홍보 게시글<br>
						<input type="radio" name="report_type">&nbsp;&nbsp;음란성 또는 청소년에게 부적합한 내용<br>
						<input type="radio" name="report_type">&nbsp;&nbsp;명예훼손/사생활 침해 및 저작권 침해 등<br>
						<input type="radio" name="report_type">&nbsp;&nbsp;기타<br>
						<textarea rows="5" cols="50" style="margin-top: 5px"></textarea>
					</td>
				</tr>
			</table>
			<div style="text-align: center;">
				<input type="submit" class="btn-primary" value="신고하기">
				<input type="button" class="btn-primary" value="취소" onClick="self.close()">
			</div>
		</form>
	</div>
</body>
</html>