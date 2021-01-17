<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	<div id="container">
		<h3 style="padding-bottom: 10px;">신고하기</h3>
		<hr>
		<form action="./report.do" method="post">
			<input type="hidden" name="seq" value="${seq}">
			<div class="form-group">
				<label for="">제목</label>
				<input type="text" class="form-control" id="title" name="title" value="원본글(신고대상)" readonly>
			</div>
			<div class="form-group">
				<label for="">작성자</label>
				<input type="text" class="form-control" id="writer" name="writer" value="원본글 작성자(신고대상)" readonly>
			</div>
			<hr>
			<div class="form-group">
				<label for="">신고사유</label>
				<div class="radio" id="">
					<label style="margin-left: 10px; margin-bottom: 5px;"><input type="radio" name="optradio">욕설/비방</label><br>
					<label style="margin-left: 10px; margin-bottom: 5px;"><input type="radio" name="optradio">부적절한 홍보 게시글</label><br>
					<label style="margin-left: 10px; margin-bottom: 5px;"><input type="radio" name="optradio">음란성 또는 청소년에게 부적합한 내용</label><br>
					<label style="margin-left: 10px; margin-bottom: 5px;"><input type="radio" name="optradio">명예훼손/사생활 침해 및 저작권 침해 등</label><br>
					<label style="margin-left: 10px; margin-bottom: 5px;"><input type="radio" name="optradio">기타</label><br>
					<textarea rows="5" cols="65" style="margin-top: 5px; margin-left: 10px;"></textarea>
				</div>
			</div>
				<div class="form-group" style="text-align: center">
				</div>
			<div style="text-align: center;">
				<input type="submit" class="btn-primary" value="신고하기">
				<input type="button" class="btn-primary" value="취소" onclick="self.close()">
			</div>
		</form>
	</div>
</body>
</html>