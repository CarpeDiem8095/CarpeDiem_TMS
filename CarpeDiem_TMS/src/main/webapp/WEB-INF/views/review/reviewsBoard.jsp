<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"/>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./js/support.js"></script>
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
	
	.table>tbody>tr>td {
		padding: 0;
	}
	
	.table>tbody>tr>td>div>div {
		padding: 10px;
	}
</style>
<body>
<%-- ${oneBoardList} --%>
<div id="#container">
<table class="table table-bordered">
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>여행일</th>
		</tr>
	<c:forEach var="board" items="${oneBoardList}" varStatus="vs">
		<tr>
			<td>${board.oneday_seq}</td>
			<td><a href="./selOneBoard.do?oneday_seq=${board.oneday_seq}">${board.oneday_title}</a></td>
			<td>${board.email}</td>
			<td>${board.one_readcnt}</td>
			<td>${board.onedate}</td>
		</tr>
	</c:forEach>
</table>
	
	<!-- 페이징 -->
			<div class="center" style="text-align: center;">
				<ul class="pagination">
					<c:if test="${pb.startPage ne 1}">
						<li><a href="./oneBoardList.do?page=1">◀◀</a></li>
						<li><a href="./oneBoardList.do?page=${pb.startPage-1}">◁</a></li>
					</c:if>
					<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}" step="1">
						<li><a href="./oneBoardList.do?page=${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</a></li>
					</c:forEach>
					<c:if test= "${pb.startPage+pb.countPage le pb.totalPage}">
						<li><a href="./oneBoardList.do?page=${pb.endPage+1}">▷</a></li>
						<li><a href="./oneBoardList.do?page=${pb.totalPage}">▶▶</a></li>
					</c:if>
				</ul>
			</div>
		
</div>
</body>
</html>