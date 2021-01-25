<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>리뷰 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
	
	a {
		text-decoration: none;
		vertical-align: -webkit-baseline-middle;
		margin-left: 10px;
	}
	
	.table>tbody>tr>td {
		padding: 0;
		padding-left: 20px;
	}
	
	.table>tbody>tr>td>div>div {
		padding: 10px;
	}
	
	th {
		text-align: center;
	}
	.pagination>li>a{
		color: #607d8b;
	}
	.center{
		text-align: center;
		display: inline-block;
	}
</style>
<body>
<%-- ${oneBoardList} --%>
<%@include file="../header/TMS_header.jsp" %>
<div id="intro" class="basic-1">
<div id="container">
<h3 style="text-align: left;"> 후기 조회 </h3>
<div style="text-align: left;"> 방문했던 공간에 대한 기억들을 함께 공유해주세요 </div>
<p></p>
<p></p>
<p></p>
<p></p>
<table class="table table-bordered table-hover w3-table">
		<tr class="w3-blue-grey">
			<th>글 번호</th>
			<th class="w3-center">제목</th>
			<th class="w3-center">작성자</th>
			<th class="w3-center">여행일</th>
			<th class="w3-center">조회수</th>
		</tr>
	<c:forEach var="board" items="${oneBoardList}" varStatus="vs">
		<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${board.onedate}" />
		<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd" var="onedate" />
		<tr>
			<td>${board.oneday_seq}</td>
			<td><a href="./selOneBoard.do?oneday_seq=${board.oneday_seq}">${board.oneday_title}</a></td>
			<td>${board.email}</td>
<%-- 			<td>${board.email}(${fn:substring(board.email,0,fn:indexOf(board.email,'@')+1)}${fn:toUpperCase(fn:substring(board.email,fn:indexOf(tripboard.userid,'@')+1,fn:indexOf(board.email,'@')+2))}) --%>
			<td><c:out value="${onedate}"/></td>
			<td>${board.one_readcnt}</td>
		</tr>
	</c:forEach>
</table>
	
	<!-- 페이징 -->
			<div class="center">
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
</div>
<%@include file="../footer/TMS_footer.jsp" %>
</body>
</html>