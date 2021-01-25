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
<%@include file="../header/TMS_header.jsp" %>
<div id="intro" class="basic-1" style="margin: 90px;">
<div class="container">
<form action="./searchboardwrite.do" method="post">
<input type="hidden" name="userid" value="${mDto.email}">
<input type="hidden" name="nickname" value="${mDto.nickname}">
<table class="table">
	<tr>
		<th class="th">작성자</th>
		<td><input class="input" type="text" value="${mDto.nickname}(${fn:substring(mDto.email,0,fn:indexOf(mDto.email,'@')+1)}${fn:toUpperCase(fn:substring(mDto.email,fn:indexOf(mDto.email,'@')+1,fn:indexOf(mDto.email,'@')+2))})" readonly="readonly"></td>
	</tr>
	<tr>
		<th class="th">제목</th>
		<td><input type="text" name="boardtitle" required></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" class="btn-outline-sm" value="작성완료">
			<input type="reset" style="background-color: #007bff;" class="btn-outline-sm" value="초기화">
			<input type="button" style="background-color: #e83e8c;" class="btn-outline-sm" value="취소" onclick="location.href='./boardsearch.do'">
		</td>
	</tr>
</table>
</form>
</div>
</div>
<%@include file="../footer/TMS_footer.jsp" %>
</body>
</html>