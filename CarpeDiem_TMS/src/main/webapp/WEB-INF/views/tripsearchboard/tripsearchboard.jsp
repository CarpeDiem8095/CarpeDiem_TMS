<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행찾기 게시판</title>
</head>
<body>
<%@include file="../header/TMS_header.jsp" %>
<div id="intro" class="basic-1" style="margin: 90px; font-size: 15px;">
<div class="container">
	<div style="font-size: 50px; margin-bottom: 30px;">&lt;동행찾기 게시판&gt;</div>
<table class="table">
	<thead>
	<tr>
		<th>연번</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>삭제</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="tripboard" items="${serchDto}">
	<tr>
		<td>${tripboard.rn}</td>
		<td>${tripboard.boardtitle}</td>
		<td>${tripboard.nickname}(${fn:substring(tripboard.userid,0,fn:indexOf(tripboard.userid,'@')+1)}${fn:toUpperCase(fn:substring(tripboard.userid,fn:indexOf(tripboard.userid,'@')+1,fn:indexOf(tripboard.userid,'@')+2))})
		</td>
		<td><fmt:formatDate value="${tripboard.tripregdate}" pattern="yyyy-MM-dd HH:mm"/></td>
		<c:choose>
		<c:when test="${mDto.auth == 'A'}">
		<td>
		<input type="button" value="삭제가능" onclick="location.href='./deltripboard.do?seq=${tripboard.seq}&auth=${mDto.auth}'">
		</td>
		</c:when>
		<c:when test="${tripboard.userid == mDto.email}">		
		<td>
		<input type="button" value="삭제가능" onclick="location.href='./deltripboard.do?seq=${tripboard.seq}&userid=${mDto.email}&auth=${mDto.auth}'">
		</td>
		</c:when>
		<c:otherwise>
			<td><h3>X</h3></td>
		</c:otherwise>
		</c:choose>
		
	</tr>
	</c:forEach>
	</tbody>
	
	
	<tr>
		<td colspan="5" style="text-align: center;">
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
			<input type="button" class="btn-outline-sm" value="글작성" onclick="location.href='./serchboardmove.do'">
			<input type="button" style="background-color: #007bff;" class="btn-outline-sm" value="뒤로가기" onclick="location.href='javascript:history.back();'">
		</td>
	</tr>
</table>
</div>
</div>
<%@include file="../footer/TMS_footer.jsp" %>
</body>
</html>