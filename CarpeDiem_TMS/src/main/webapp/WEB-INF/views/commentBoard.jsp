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
<body>


	<div><a href="./iLikeit.do">♡</a></div>
		
 <div class="container">
        <label for="content">comment</label>
		<form action="./writeComment.do" method="post">
		<div class="input-group">
			<input type="hidden" name="oneday_seq" value="${oneday_seq}">
			<input type="text" class="form-control" name="content" placeholder="내용을 입력하세요.">
			   <span class="input-group-btn">
                    <button class="btn btn-default" type="submit">등록</button>
               </span>
               </div>
		</form>
</div>
 <div class="container">
        <div class="commentList">
        </div>

	<c:forEach var="i" items="${commentList}" varStatus="vs">
	<div>
		<div class="showMeTheForm">
			${i.email}${i.content}<input type="button" value="답글">
		</div>
	<form action="./writeReply.do" method="post">
		<input type="hidden" name="oneday_seq" value="${oneday_seq}">
<%-- 	<input type="hidden" name="comm_seq" value="${comm_seq}" > --%>
		<div class="re_Form">  
			<input type="text"><input type="submit" value="작성">
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


// 대댓글 등록
// function commentInsert(insertData){
//     $.ajax({
//         url : '/writeReply.do',
//         type : 'post',
//         data : insertData,
//         success : function(data){
//             if(data == 1) {
//                 commentList(); //댓글 작성 후 댓글 목록 reload
//                 $('[name=content]').val('');
//             }
//         }
//     });
// }



// 버튼 클릭 시 댓글 작성 폼 보이기

$(document).ready(function() {	
	$(".re_Form").hide();
	$(".showMeTheForm").click(function(){
		$(this).parent().find(".re_Form").slideToggle('slow');
	});
 });
</script>
</body>
</html>