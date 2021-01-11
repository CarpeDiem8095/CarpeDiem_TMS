<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		.frameTD{
			width: 150px;
			height: 150px;
			border: 1px solid black;
		}
	</style>
<meta charset="UTF-8">
<title>전체 노트 페이지</title>
</head>
<body>
	<form action="./delMultiNote.do" method="post">
		<table style="margin: 0px auto;">
			<tr>
				<c:forEach var="note" items="${pageList}" varStatus="vs">
					<td class="frameTD">
					<div>
						<div>
							<input type = "button" value="X" style="float: right;" onclick="delOneNote(${note.note_seq})">
						</div>
						<div>
							<input type="checkbox" name="box" value="${note.note_seq}">
							<a href="./detailNote.do?seq=${note.note_seq}">${note.note_title}</a><br>
							<a href="./calendar.do?seq=${note.note_seq}">${note.note_title}</a>
						</div>
						<div>
							<input type = "button" value="수정" style="float: right;" onclick="modifyNote(${note.note_seq})">
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
			<input type = "button" value="노트생성" onclick="writeNote()" style="text-align: center;">
			<input type = "submit" value="다중삭제" style="margin: 0px auto;" style="text-align: center;">
		</div>
	</form>
	
	<div>
	${pageList}
	</div>
	<div>
	${page}
	</div>
	
</body>
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