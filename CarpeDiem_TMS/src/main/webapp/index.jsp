<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인입니다.</title>
</head>
<body>
<h1><a href="./boardsearch.do?auth=ADMIN">관리자 동행찾기로 이동</a></h1>
<h1><a href="./boardsearch.do?auth=USER">유저 동행찾기로 이동</a></h1>
<h1><a href="./notePaging.do">노트로 이동</a></h1>
	<a href="./questionboard.do">문의 게시판</a>
<form action="./mainchat.do" method="post">
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" name="userid" value="sung9606071@gmail.com"> </td>
	</tr>
	<tr>
		<td><input type="submit" value="로그인"> </td>
	</tr>
</table>
</form>
<form action="./mainchat.do" method="post">
<table>
	<tr>
		<th>아이디</th>
		<td><input type="text" name="userid" value="happy0104@gmail.com"> </td>
	</tr>
	<tr>
		<td><input type="submit" value="로그인"> </td>
	</tr>
</table>
</form>
</body>
</html>