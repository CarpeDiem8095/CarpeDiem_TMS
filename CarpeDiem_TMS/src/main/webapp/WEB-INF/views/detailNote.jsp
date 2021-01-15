<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>노트 상세 조회 페이지</title>
</head>
	<style type="text/css">
		.frameTD{
			width: 150px;
			height: 150px;
			border: 1px solid black;
		}
	</style>
<body>
<%-- ${fn:length(detail.odto)} --%>

	<c:if test="${fn:length(ndto[0].odto) eq 0}">
		<div style="text-align: center;">
			하루일정을 생성해 주세요
		</div>
	</c:if>
		<div style="border: 1px solid black; font-style: bold; background-color: white;">
		
		</div>
	<form>
		<table style="margin: 0px auto;">
			<c:forEach var="ndto" items="${ndto}">
				<tr>
					<c:forEach var="onedto" items="${ndto.odto}">
						<td class="frameTD" style="text-align: center;">
							<a href="./insertPlacePage.do?seq=${onedto.oneday_seq}&noteSeq=${seq}">${onedto.oneday_title}</a>
							<input type = "button" value="X" style="float: right;" onclick="delOneday(${onedto.oneday_seq})">
						<input type = "button" value="수정" onclick="modifyNote(${onedto.oneday_seq})" style="text-align: center; float: right;">
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
		<div style="text-align: center;">
			<input type="button" value="뒤로가기" onclick="location.href='./notePaging.do?page=${page}'">
			<input type = "button" value="하루일정생성" onclick="writeOneday(${seq})">
			<input type = "hidden" value="${seq}" id="noteSeq">
		</div>
		<div style="text-align: center;">
		<%-- ${fn:length(ndto[0].odto)} --%>
		<c:if test="${fn:length(ndto[0].odto) > 1}">
		<div>
			<input type = "button" value="하루 일정 묶음 조회" onclick="location.href='./NoteCollectOneday.do?note_seq=${seq}&page=${page}'" style="width: 450px">
		</div>
		</c:if>
		</div>
	</form>
</body>

<script type="text/javascript">
	function writeOneday(seq){
		alert(seq+"가 넘어와야 합니다");
		var url = "./writeOneDayForm.do?seq="+seq;
		var title = "하루 일정 작성 폼 입니다.";
		var attr = "width=400px, height=200px";
		var wirteOneDay = window.open(url, title, attr);
	}

	function delOneday(seq){
		var noteSeq = document.getElementById("noteSeq").value;
		
		var delConfirm = confirm('당신의 하루 일정이 삭제됩니다.');
		   if (delConfirm) {
					var form = document.forms[0];
					form.action = "./delOneday.do?seq="+seq+"&noteSeq="+noteSeq;
					form.method = "post";
					form.submit();
			   }
			   else {
			      alert('삭제가 취소되었습니다.');
			  }
	}
	
</script>
</html>
