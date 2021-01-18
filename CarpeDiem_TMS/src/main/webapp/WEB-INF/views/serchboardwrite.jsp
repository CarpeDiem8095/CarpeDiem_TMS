<%@page import="com.cp.tms.dto.ChatingDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행찾기 게시판 글쓰기 폼</title>
</head>
<body>
<form action="./searchboardwrite.do" method="post">
<input type="hidden" name="userid" value="${mDto.email}">
<input type="hidden" name="nickname" value="${mDto.nickname}">
<table>
	<tr>
		<th>작성자</th>
		<td><input type="text" value="우성(sung960607@G)" readonly="readonly"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="boardtitle" required></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="작성완료">
			<input type="reset" value="초기화">
			<input type="button" value="취소" onclick="./boardsearch.do">
		</td>
	</tr>
</table>
</form>
</body>
</html>