<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"/>
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
	
	.form-textPw {
		height: 150px;
		text-align: center;
	}
	
	#text_pw {
		width: 100px;
		padding: 0;
		margin: 0;
		margin: 30px auto;
		margin-top: 5px;
		margin-bottom: 5px;
	}
	
	.modal-dialog {
		width: 400px;
		margin: 110px auto;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script type="text/javascript" src="./js/support.js"></script>
</head>
<body>
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
	  			<!-- 관리자만 보이게 -->
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
					<div class="modal-header textPw-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="modal-title" style="text-align: center">글 비밀번호를 입력해 주세요.</h3>
					</div>
					<div class="modal-body textPw-body">
						<form action="#" class="form-margin" method="post" id="frmPW">
							<input type="hidden" value="${dto.seq}" name="seq">
							<div class="form-group form-textPw">
								<br>
								<br>
								<label for="text_pw">비밀번호</label>
								<input type="password"  class="form-control"id="text_pw" name="text_pw" maxlength="4" required>
							</div>
							<div class="modal-footer" style="text-align: center">
								<input type="button" class="btn-primary" value="확인" onclick="checkPw()"/>
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
</body>
<script type="text/javascript">
	function checkAll(bool){
		console.log(bool);
		var chkval = document.getElementsByName('chkVal'); // nodeList

		for (var i = 0; i < chkval.length; i++) {
			chkval[i].checked = bool;
		}
	}
	
	function chkbox(){
		var chkval = document.getElementsByName('chkVal');
		var n = 0;
		for (var i = 0; i < chkval.length; i++) {
			if(chkval[i].checked){
				n++;
			}
		}	
		if(n>0){
			document.getElementById("frm").action = "./multiDel.do";
		} else {
			swal("삭제 오류","한개 이상의 글을 선택하세요");
			return false;
		}
	}
</script>
</html>