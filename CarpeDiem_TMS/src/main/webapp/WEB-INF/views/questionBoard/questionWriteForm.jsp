<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 양식</title>
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
		<h3 style="padding-bottom: 10px">글쓰기</h3>
		<form action="./write.do" method="post">
		<input type="hidden" name="email" value="${mDto.email}">
			<table class="table">
				<tr>
					<th>작성자</th>
					<td>
						<!-- 비회원 -->
						<c:if test="${mDto.auth eq null}">
							<input class="form-control" type="text" name="writer" placeholder="닉네임을 입력해 주세요." required>
						</c:if>
						<!-- 회원은 session 가져옴 -->
						<c:if test="${mDto.auth ne null}">
							<input class="form-control" type="text" name="writer" value="${mDto.nickname}(${fn:substring(mDto.email,0,fn:indexOf(mDto.email,'@')+1)}${fn:toUpperCase(fn:substring(mDto.email,fn:indexOf(mDto.email,'@')+1,fn:indexOf(mDto.email,'@')+2))})" readonly>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input class="form-control" type="text" name="title" placeholder="제목을 입력해 주세요." required>
					</td>
				</tr>
				<!-- 비회원/회원만 보이게 -->
				<c:if test="${mDto.auth ne 'A'}">
					<tr>
						<th>비밀번호</th>
						<td>
							<input class="form-control" type="password" name="text_pw" placeholder="4자리 숫자를 입력해 주세요." maxlength="4" required>
						</td>
					</tr>
				</c:if>
				<tr>
					<th></th>
					<td>
						<textarea class="form-control" rows="10" cols="90" name="content" placeholder="내용을 입력하세요." required></textarea>
					</td>
				</tr>
				<!-- 관리자만 보이게 -->
				<c:if test="${mDto.auth eq 'A'}">
					<tr>
						<th>공개여부</th>
						<td>
							<input type="radio" name="public_status" checked> 공개글&nbsp;&nbsp;
							<input type="radio" name="public_status" value="${questionLists.public_status}"> 비밀글
						</td>
					</tr>
				</c:if>
			</table>
			<div class="form-group" style="text-align: right">
				<input type="submit" class="btn btn-primary" value="등록">
				<input type="button" class="btn btn-primary" value="취소" onclick="location.href='./questionBoard.do'">
			</div>
		</form>
	</div>
</body>
</html>