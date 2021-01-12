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
						<!-- 체크박스는 관리자만 보이게 -->
						<th><input type="checkbox" id="allCheck" onclick="checkAll(this.checked)"></th>
						<th>글 번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
						<!-- 관리자는 삭제여부 필요 -->
					</tr>
						
					<jsp:useBean id="data" class="com.cp.tms.usebean.SupportInputData" scope="page"/>
					<jsp:setProperty property="lists" name="data" value="${lists}"/>
					<jsp:getProperty property="listForm" name="data"/>
				</table>
			</div>
			
			<div class="center" style="text-align: center;">
				<ul class="pagination">
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
				</ul>
			</div>
			
			<div style="text-align: center; padding-bottom: 20px;">
	  			<input class="btn btn-primary" type="button" value="글쓰기" onclick="location.href='./writeForm.do'">
	  			<!-- 관리자만 보이게 -->
				<input class="btn btn-primary" type="submit" value="삭제" style="width: 68px">
			</div>
		</form>
		
		<!-- 수정 modal -->
		<div id="modify" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="modal-title">글 수정</h3>
					</div>
					<div class="modal-body">
					<form action="#" class="form-margin" method="post" id="frmModify">
						<div class='form-group'>
							<input type='hidden' value='${dto.seq}' name='seq'>
							<label for='writer'>작성자</label>
						</div>
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