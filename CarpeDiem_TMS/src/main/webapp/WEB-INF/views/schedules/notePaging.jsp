<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 노트 페이지</title>
<%@ include file="/WEB-INF/views/header/TMS_header.jsp" %>
	<style type="text/css">
	body {
  		width: 100%;
  		height: 500px;
	}

		.frameTD{
			width: 150px;
			height: 150px;
			border: 1px solid black;
		}
		
		
		.marform{
			margin-top: 300px;
			margin-bottom: 400px; 
		}
		
	a {
		color: #2e00ff;
		text-decoration: underline;
	}
	
	.btn-update{
		background-color: #EB7415;
		color: white;
	}
	
	.btn-delete{
		background-color: #9E265E;
		color: white;
	}
	
	.btn-create{
	background-color: #1E9E68;
	color: white;
	}
	
	.btn-delete2{
		background-color: #EB7415;
		color: white;
	}
	

	</style>
</head>
	
<body>
	<form action="./delMultiNote.do" method="post" class="marform">
		<table style="margin: 0px auto;">
			<tr>
				<c:forEach var="note" items="${pageList}" varStatus="vs">
					<td class="frameTD">
					<div>
						<div>
							<input type = "button" value="X" style="float: right;" onclick="delOneNote(${note.note_seq})" class="btn-update">
						</div>
						<div>
							<input type="checkbox" name="box" value="${note.note_seq}">
							<a href="./calendar.do?seq=${note.note_seq}&page=${page.page}">${note.note_title}</a><br>
						</div>
						<div>
							<input type = "button" value="수정" style="float: right;" onclick="modifyNote(${note.note_seq})" class="btn-delete">
						</div>
					</div>
					</td>
				</c:forEach>
			</tr>
			<tr>
				<td colspan="5" style="text-align: center;">
				<c:if test= "${page.startPage ne 1}">
					<a href="./notePaging.do?page=1">◁◁</a>
					<a href="./notePaging.do?page=${page.startPage-1}">◀</a>
				</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}" step="1">
					<a href="./notePaging.do?page=${i}">&nbsp;&nbsp;&nbsp;&nbsp;${i}&nbsp;&nbsp;&nbsp;</a>
					</c:forEach>
				<c:if test= "${page.startPage+page.countPage le page.totalPage}">
					<a href="./notePaging.do?page=${page.endPage+1}">▶</a>
					<a href="./notePaging.do?page=${page.totalPage}">▷▷</a>
				</c:if>
				</td>
			</tr>
		</table>
		<div style="text-align: center;">
			<input type = "button" value="노트생성" onclick="writeNote()" style="text-align: center;" class="btn-create">
			<input type = "submit" value="다중삭제" style="margin: 0px auto;" style="text-align: center;" class="btn-delete2">
		</div>
	</form>
	
	
<%@ include file="/WEB-INF/views/footer/TMS_footer.jsp" %>	
<script type="text/javascript">
	function delOneNote(seq){
		var delConfirm = confirm('당신의 노트가 삭제됩니다.');
		   if (delConfirm) {
					var form = document.forms[0];
					form.action = "./delOneNote.do?seq="+seq;
					form.method = "post";
					form.submit();
			   }
			   else {
			      alert('삭제가 취소되었습니다.');
			  }
	}
	
	function modifyNote(seq){
		var url = "./modifyNoteForm.do?seq="+seq;
		var title = "노트 수정 폼 입니다.";
		var attr = "width=400px, height=200px";
		var modifyNote = window.open(url, title, attr);
	}
	
	function writeNote(){
		var url = "./writeNoteForm.do"
		var title = "노트 입력 폼 입니다.";
		var attr = "width=400px, height=200px";
		var wirteNote = window.open(url, title, attr);
	}
	</script>
</html>