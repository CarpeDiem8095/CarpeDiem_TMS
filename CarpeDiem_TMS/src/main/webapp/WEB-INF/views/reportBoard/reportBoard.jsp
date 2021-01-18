<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	
	th {
		text-align: center;
	}
	
	a {
		text-decoration: none;
		vertical-align: -webkit-baseline-middle;
		margin-left: 10px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/support.js"></script>
</head>
<body>
	<div id="container">
		<h3>신고처리 게시판</h3>
		<div>
			<table class="table table-bordered">
				<tr class="info">
					<th>글 번호</th>
					<th>신고사유</th>
					<th>등록일</th>
					<th>신고대상</th>
					<th>처리여부</th>
					<th>게시판 종류</th>
				</tr>
				<c:forEach var="dto" items="${reDto}">
				<tr>
					<td style="text-align: center; vertical-align: middle; width: 90px;">${dto.seq}</td>
					<td style="text-align: center; vertical-align: middle; height: 56px;"><a href="./reportDetail.do?seq=${dto.seq}">${dto.report_type}</a></td>
					<td style="text-align: center; vertical-align: middle;"><fmt:formatDate value="${dto.text_regdate}" pattern="yyyy-MM-dd"/></td>
					<td style="text-align: center; vertical-align: middle;">${dto.email}</td>
					<td style="text-align: center; vertical-align: middle;">${dto.processing_status}</td>
					<td style="text-align: center; vertical-align: middle;">${dto.board_type}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<!-- 페이징 -->
		<div class="center" style="text-align: center;">
			<ul class="pagination">
				<c:if test="${page.startPage ne 1}">
					<li><a href="./reportBoard.do?page=1">◀◀</a></li>
					<li><a href="./reportBoard.do?page=${page.startPage-1}">◁</a></li>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}" step="1">
					<li><a href="./reportBoard.do?page=${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</a></li>
				</c:forEach>
				<c:if test= "${page.startPage+page.countPage le page.totalPage}">
					<li><a href="./reportBoard.do?page=${page.endPage+1}">▷</a></li>
					<li><a href="./reportBoard.do?page=${page.totalPage}">▶▶</a></li>
				</c:if>
			</ul>
		</div>
		
		<div>
			<input type="button" class="btn btn-warning" value="메인으로" onclick="location.href='./mainpage.do'">
		</div>
		
	</div>
</body>
</html>