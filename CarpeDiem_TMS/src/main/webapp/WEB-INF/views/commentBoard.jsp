<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 게시판</title>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

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
</style>
<body>


	<div><a href="./iLikeit.do">♡</a></div>
		
 <div class="container">
 	
 		<h3>하루 일정</h3>
		
<div class="w3-show-inline-block">
	<div class="w3-bar w3-light-grey">
		<a href="./selDetailOneday.do?seq=${oneday_seq}" class="w3-bar-item w3-button">일정 보기</a> 
		<a href="./onedayTableList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button">일정표 보기</a> 
		<a href="./commnetList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button w3-dark-grey">댓글 보기</a>
	</div>
</div> 	
 	
        <div><label for="content">comment</label></div>
		<form action="./writeComment.do" id="writeForm" method="post">
		<div class="input-group">
			<input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요.">
			<input type="hidden" name="oneday_seq" value="${oneday_seq}">
			   <span class="input-group-btn">
                    <input type="submit" class="btn btn-default" value="등록">
               </span>
        </div>
		</form>
</div>
 <div class="container">
        <div class="commentList">
        </div>

	<c:forEach var="i" items="${commentList}" varStatus="vs">
	<div>
	
	<form action="./delComment.do" id="delComment" method="get">
	<input type="hidden" name="comm_seq" value="${i.comm_seq}">
	<input type="hidden" name="oneday_seq" value="${i.oneday_seq}">
	<input type="hidden" name="reffer" value="${i.reffer}">
	<input type="hidden" name="step" value="${i.step}">
		<div style="width:665px; height:35px; float:left;">
			${i.comm_seq}${i.email}${i.content}
			<input type="button" onclick ="replyWrite()" class="btn btn-default" value="삭제" style="float:right;">
			<input type="button" class="btn btn-default" value="수정" style="float:right;">
		</div>
	</form>
	
		<span class="showMeTheForm"><input type="button" class="btn btn-default" value="답글" style="float:right;"></span>
	<form action="./writeReply.do" method="post">
		<input type="hidden" name="oneday_seq" value="${i.oneday_seq}">
		<input type="hidden" name="comm_seq" value="${i.comm_seq}">
		<div class="re_Form">
		<div class="input-group" style="width:670px;">
			<input type="text" name="content" class ="form-control" placeholder="답글 내용을 입력하세요.">
			  <span class="input-group-btn">
                    <button class="btn btn-default" type="submit">등록</button>
               </span>
		</div>  
		</div>
	</form>
	</div>
	</c:forEach>
	</div>

<script>

// 아작스 전송 
//댓글 목록 
// $(document).ready(function() {
// 	
//       });
      
// function commentList(){
//     $.ajax({
//         url : '/commentList.do',
//         type : 'post',
//         data : {'oneday_seq':oneday_seq},
//         success : function(data){
//             var html = '';
//             var commData = data;
//             alert(commData);
//                 html += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
//                 html += '<div class="commentInfo'+i.comm_seq+'">'+'댓글번호 : '+i.comm_seq+' / 작성자 : '+i.email;
//                 html += '<a onclick="commentUpdate('+i.comm_seq+',\''+i.content+'\');"> 수정 </a>';
//                 html += '<a onclick="commentDelete('+i.comm_seq+');"> 삭제 </a> </div>';
//                 html += '<div class="commentContent'+i.comm_seq+'"> <p> 내용 : '+i.content +'</p>';
//                 html += '</div></div>';
//             $(".commentList").html(a);
//         }
//     });
// }

// 댓글 삭제
function replyWrite(){
	var formData = $('#delComment').serialize();
	console.log(formData);
	
	$.ajax({
		type:'get',
		url : 'delComment.do',
		data : formData,
		dataType:'json',
		async:false,
		contentType:'application/json; charset=utf-8',
		success:function(data){
        	alert(data);
        	alert(성공);
        	location.reload();
		},
	      error : function(err){
	         alert("잘못된 요청입니다."+err);
	      }
		
	})
}


// 대댓글 등록
// function commentInsert(insertData){
//     $.ajax({
//         url : '/writeReply.do',
//         type : 'post',
//         data : {"content":content}
//         success : function(data){
//             if(data == 1) {
//                 commentList(); //댓글 작성 후 댓글 목록 reload
//                 $("#replyContent").val("");
//             }
//         }
//     });
// }



// 버튼 클릭 시 댓글 작성 폼 보이기

$(document).ready(function() {	
	$(".re_Form").hide();
	$(".showMeTheForm").click(function(){
		$(this).parent().find(".re_Form").slideToggle('fast');
	});
 });
</script>
</body>
</html>