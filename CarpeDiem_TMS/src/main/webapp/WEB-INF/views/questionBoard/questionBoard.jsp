<%@page import="com.cp.tms.dto.QuestionDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 게시판</title>
</head>
<body>
<%@include file="../header/TMS_header.jsp" %>
	<div id="container">
		<h3>문의하기</h3>
		<form action="#" method="post" id="frm" name="frm" onsubmit="return chkbox();">
			<div class="panel-group" id="accordion">
				<table class="table table-bordered">
					<tr class="info">
						<c:if test="${mDto.auth eq 'A'}">
							<th>
								<input type="checkbox" id="allCheck" onclick="checkAll(this.checked)">
							</th>
						</c:if>
						<th>글 번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
						<c:if test="${mDto.auth eq 'A'}">
							<th>공개여부</th>
							<th>삭제여부</th>
						</c:if>
					</tr>
					<jsp:useBean id="data" class="com.cp.tms.usebean.QuestionInputData" scope="page"/>
					<jsp:setProperty property="questionLists" name="data" value="${questionLists}"/>
					<jsp:setProperty property="mDto" name="data" value="${mDto}"/>
					<jsp:getProperty property="listForm" name="data"/>
				</table>
			</div>
			
			<!-- 페이징 -->
			<div class="center" style="text-align: center;">
				<ul class="pagination">
					<c:if test="${page.startPage ne 1}">
						<li><a href="./questionBoard.do?page=1">◀◀</a></li>
						<li><a href="./questionBoard.do?page=${page.startPage-1}">◁</a></li>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}" step="1">
						<li><a href="./questionBoard.do?page=${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</a></li>
					</c:forEach>
					<c:if test= "${page.startPage+page.countPage le page.totalPage}">
						<li><a href="./questionBoard.do?page=${page.endPage+1}">▷</a></li>
						<li><a href="./questionBoard.do?page=${page.totalPage}">▶▶</a></li>
					</c:if>
				</ul>
			</div>
			
			<div style="text-align: center; padding-bottom: 20px;">
	  			<input type="button" class="btn btn-primary" value="글쓰기" onclick="location.href='./writeForm.do'">
	  			관리자만 보이게
	  			<c:if test="${mDto.auth eq 'A'}">
					<input type="submit" class="btn btn-primary" value="삭제" style="width: 68px">
				</c:if>
				<input type="button" class="btn btn-warning" value="메인으로" onclick="location.href='./mainpage.do'">
			</div>
		</form>
		
		<!-- 비밀번호 입력 modal -->
		<div id="textPw" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					modal header
					<div class="modal-header textPw-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="modal-title" style="text-align: center">글 비밀번호를 입력해 주세요.</h3>
					</div>
					modal body
					<div class="modal-body textPw-body">
						<form action="#" class="form-margin" method="post" id="frmPW">
							<input type="hidden" value="${dto.seq}" name="seq">
							<div class="form-group form-textPw">
								<br>
								<br>
								<label for="text_pw">비밀번호</label>
								<input type="password" class="form-control" id="text_pw" name="text_pw" maxlength="4" required>
							</div>
							<div class="modal-footer" style="text-align: center">
								<input type="button" id="pwvaluechek" class="btn-primary" value="확인"/>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 수정 modal -->
		<div id="modify" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="modal-title" style="text-align: center">글 수정</h3>
					</div>
					<div class="modal-body">
						<form action="#" class="form-margin" method="post" id="frmModify">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="../footer/TMS_footer.jsp" %>
</body>
</html>