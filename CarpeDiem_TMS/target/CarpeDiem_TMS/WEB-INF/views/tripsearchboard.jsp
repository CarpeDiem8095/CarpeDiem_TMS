<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행찾기 게시판</title>
</head>
<body>
<table style="text-align: center;">
	<tr>
		<th>연번</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>삭제</th>
	</tr>
	<c:forEach var="tripboard" items="${serchDto}">
	<tr>
		<td>${tripboard.rn}</td>
		<td>${tripboard.boardtitle}</td>
		<td>${tripboard.nickname}(${fn:substring(tripboard.userid,0,fn:indexOf(tripboard.userid,'@')+1)}${fn:toUpperCase(fn:substring(tripboard.userid,fn:indexOf(tripboard.userid,'@')+1,fn:indexOf(tripboard.userid,'@')+2))})
		</td>
		<td><fmt:formatDate value="${tripboard.tripregdate}" pattern="yyyy-MM-dd HH:mm"/></td>
		<c:choose>
		<c:when test="${auth == 'ADMIN'}">
		<td>
		<input type="button" value="삭제가능" onclick="location.href='./deltripboard.do?seq=${tripboard.seq}&auth=${auth}'">
		</td>
		</c:when>
		<c:when test="${tripboard.userid == 'sung9606071@gmail.com'}">		
		<td>
		<input type="button" value="삭제가능" onclick="location.href='./deltripboard.do?seq=${tripboard.seq}&userid=${tripboard.userid}&auth=${auth}'">
		</td>
		</c:when>
		</c:choose>
		
	</tr>
	</c:forEach>
	
	<tr>
		<td colspan="4" style="text-align: center;">
			<c:if test="${p.startpage ne 1}">
			<a href="./boardsearch.do?page=1">◁◁</a>
			<a href="./boardsearch.do?page=${p.startpage-p.countpage}">◁</a>
			</c:if>
			<c:forEach var="k" begin="${p.startpage}" end="${p.lastpage}" step="1">
			<a href="./boardsearch.do?page=${k}">&nbsp;&nbsp;${k}&nbsp;&nbsp;</a>
			</c:forEach>
			<c:if test="${p.startpage+p.countpage<=p.totalpage}">
			<a href="./boardsearch.do?page=${p.lastpage+1}">▶</a>
			<a href="./boardsearch.do?page=${p.totalpage}">▶▶</a>
			</c:if>
			</td>
	</tr>
	<tr>
		<td>
			<input type="button" value="글작성" onclick="location.href='./serchboardmove.do'">
			<input type="button" value="뒤로가기">
		</td>
	</tr>
</table>
</body>
</html>