<%@page import="org.springframework.http.HttpRequest"%>
<%@page import="com.cp.tms.dto.CommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 게시판</title>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style type="text/css">
#container {
	width: 650px;
	height: 540px;
	margin: 40px auto;
	text-align: left;
    height: expression( this.scrollHeight > 530 ? "540px" : "auto" );
   	max-height: 540px;
}

a {
	text-decoration: none;
	vertical-align: -webkit-baseline-middle;
	margin-left: 10px;
}
</style>
<body>
<%@include file="../header/TMS_header.jsp" %>
<div id="services" class="cards-2">
	<div id="container">

		<h3>하루 일정</h3> 
<%-- 		<h4>세션 : ${mDto.email}</h4> --%>
<%-- 		<h4>이메일 : ${commentList[0].email}</h4> --%>

		<div class="w3-show-inline-block">
			<div class="w3-bar w3-light-grey">
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${mDto.email eq null}"> --%>
<%-- 				<<a href="./selOneBoard.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button">일정 보기</a> --%>
<%-- 				</c:when> --%>
<%-- 				<c:otherwise> --%>
				<a href="./selDetailOneday.do?seq=${oneday_seq}" class="w3-bar-item w3-button">일정 보기</a>
<%-- 				</c:otherwise> --%>
				<a href="./onedayTableList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button">일정표 보기</a> 
				<a href="./commnetList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button w3-dark-grey">댓글 보기</a>
<%-- 			</c:choose>  --%>
			</div>
		</div>
		<div class="commentList">
			<div>
				<label for="content">comment</label>
			</div>
			<form action="./writeComment.do" id="writeForm" method="post">
				<div class="input-group">
				<c:choose>
				<c:when test="${mDto.email eq null}">
					<input type="text" class="form-control" id="content" name="content" readonly="readonly" placeholder="로그인 후 이용하세요."> 
					<span class="input-group-btn"> 
						<input type="button" class="btn btn-default disabled" value="등록">
					</span>
				</c:when>
				<c:otherwise>
					<input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요."> 
					<input type="hidden" name="oneday_seq" value="${oneday_seq}"> 
					<span class="input-group-btn"> 
						<input type="submit" class="btn btn-default" value="등록">
					</span>
				</c:otherwise>
				</c:choose>
				</div>
			</form>


			<c:forEach var="i" items="${commentList}" varStatus="vs">
				<div id="commentId">

					<form name="sub1" class="updateComment" method="post" action="./delComment.do">
						<input type="hidden" name="comm_seq" value="${i.comm_seq}">
						<input type="hidden" name="oneday_seq" value="${i.oneday_seq}">
						<input type="hidden" name="depth" value="${i.depth}">
						<input type="hidden" name="reffer" value="${i.reffer}">
						<div>
							<div style="width: 550px; height: 35px; float: left;" class="modifyPlace">
								${i.comm_seq}
									<jsp:useBean id="format" class="com.cp.tms.usebean.replyPhoto" scope="page"/>
									<jsp:setProperty property="depth" name="format" value="${i.depth}"/>
									<jsp:getProperty property="photo" name="format"/>
								${i.email}
								${i.content}
							</div>
							<div style="width:102px; float: right;" >
								<c:if test="${mDto.email eq i.email}">
								<input type="button" onclick="modifyCommForm($(this),'${i.comm_seq}')" class="btn btn-default btnModi" value="수정" style="float: right;">
								<input type="button" onclick="delComment($(this))" class="btn btn-default" value="삭제" style="float: right;"> 
								</c:if>
							</div>	
						</div>
					</form>
					
					<div style="width: 51px; float: right;" class="showMeTheForm">
					<c:if test="${mDto.email ne null}">
						<input type="button" class="btn btn-default" value="답글" style="float: right;">
					</c:if>
					</div>
					<form action="./writeReply.do" method="post">
						<input type="hidden" name="oneday_seq" value="${i.oneday_seq}">
						<input type="hidden" name="comm_seq" value="${i.comm_seq}">
						<div class="re_Form">
							<div class="input-group">
								<input type="text" name="content" class="form-control" placeholder="답글 내용을 입력하세요."> 
								<span class="input-group-btn">
									<button class="btn btn-default" type="submit">등록</button>
								</span>
							</div>
						</div>
					</form>
				</div>
			</c:forEach>
		</div>
	</div>
	<script>
		// 댓글 삭제

		function delComment(thisVal) {
			var delVal = thisVal.parent().parent(); // 해당 폼 
// 			alert(delVal.find('.updateComment').prop('tagName'));
			delVal.filter('.updateComment').submit();
    
			
			
// 			var formData = $('#updateComment').serialize();
// 			console.log(formData);
// 			//alert(formData.val());
// 			if (confirm("댓글을 삭제 하시겠습니까?") == true) {

// 				$.ajax({
// 					type : 'get',
// 					url : 'delComment.do',
// 					data : formData,
// 					dataType : 'json',
// 					contentType : 'application/json; charset=utf-8',
// 					success : function(data) {
// 						//alert(data.result);
// 						location.reload();
// 					},
// 					error : function(err) {
// 						alert("잘못된 요청입니다." + err);
// 					}

// 				})
// 			} else { //취소
// 				return;
// 			}
		}

		// 댓글 수정 폼 생성
		function modifyCommForm(a,val) {
			$('.showMeTheForm').hide();
			//alert(val);
			var comm_seq = val;
			//alert(comm_seq);

			var oneday_seq = <%=request.getParameter("oneday_seq")%>;
			//alert(oneday_seq)
// 			alert(a.parent().parent().find('.modifyPlace').html());
			var modiPlace = a.parent().parent().find('.modifyPlace');

			$.ajax({
						type : 'get',
						url : 'modifyCommForm.do',
						data : {
							"comm_seq" : comm_seq,
							"oneday_seq" : oneday_seq
						},
						dataType : 'json',
						contentType : 'application/json; charset=utf-8',
						success : function(data) {
							//alert(data.content)
							//alert(data.comm_seq)
							html = "<div class='input-group mb-3'>";
							html += "	<input type='text' class ='form-control' class='modifyVal' value='"+data.content+"'>";
							html += "	<input type='hidden' name='comm_seq' value='"+data.comm_seq+"'>";
							html += "	<div class='input-group-append'>";
							html += "		<input type='button' class='btn btn-default' value='등록' onclick='modifyComment()'>";
							html += "		<input type='button' class='btn btn-default' value='취소' onclick='location.reload()'>";
							html += "	</div>";
							html += "</div>";

							modiPlace.html(html);
							
						},
						error : function(err) {
							alert("잘못된 요청입니다." + err);
						}

					})
		}

		// 댓글 수정 
		function modifyComment() {
			var modifyVal = document.getElementsByClassName("modifyVal").value;

			var comm_seq = document.getElementsByName("comm_seq")[0].value;

			var moval_comm_seq = "";
			moval_comm_seq = modifyVal + "/" + comm_seq;
			//alert(modifyVal);
			//alert(comm_seq);
			

			$.ajax({
				type : 'post',
				url : "modifyComment.do?moval_comm_seq=" + moval_comm_seq,
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(data) {
					//alert(data.result);
					alert("댓글이 수정 되었습니다.");
					location.reload();
				},
				error : function(err) {
					alert("잘못된 요청입니다." + err)
				}

			})

		}

		// 버튼 클릭 시 댓글 작성 폼 보이기

		$(document).ready(function() {
			$(".re_Form").hide();
			$(".showMeTheForm").click(function() {
				$(this).parent().find(".re_Form").slideToggle('fast');
			});
		});
		
	</script>
</div>
<%@include file="../footer/TMS_footer.jsp" %>
</body>
</html>