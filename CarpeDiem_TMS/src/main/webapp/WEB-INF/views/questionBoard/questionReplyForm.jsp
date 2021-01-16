<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변 양식</title>
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
		<h3 style="padding-bottom: 10px">답변쓰기</h3>
		<form action="./reply.do" method="post">
			<input type = "hidden" name="seq" value="${seq}">
			<table class="table">
				<tr>
					<th>작성자</th>
					<td>
						<!-- session 가져옴 -->
						<input class="form-control" type="text" name="writer" value="${mDto.nickname}(${fn:substring(mDto.email,0,fn:indexOf(mDto.email,'@')+1)}${fn:toUpperCase(fn:substring(mDto.email,fn:indexOf(mDto.email,'@')+1,fn:indexOf(mDto.email,'@')+2))})" required readonly>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<!-- root글의 title -->
						<input class="form-control" type="text" name="title" value="${qDto.title}" required readonly>
					</td>
				</tr>
				<tr style="display: none;">
					<!-- root글의 text_pw -->
					<th>비밀번호</th>
					<td>
						<input class="form-control" type="password" name="text_pw" value="${qDto.text_pw}" maxlength="4" required readonly>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<textarea class="form-control" rows="10" cols="90" name="content" placeholder="내용을 입력하세요." required></textarea>
					</td>
				</tr>
			</table>
			<div class="form-group" style="text-align: right">
				<input type="submit" value="등록">
				<input type="button" value="취소" onclick="location.href='./questionBoard.do'">
			</div>
		</form>
	</div>
</body>
</html>