<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var oneday_seq = '${i.oneday_seq}'; // 하루일정 번호 

$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});

//댓글 목록 
function commentList(){
    $.ajax({
        url : '/commentList.do',
        type : 'get',
        data : {'oneday_seq':oneday_seq},
        success : function(data){
            var a =''; 
            $.each(data, function(key, value){ 
                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="commentInfo'+i.comm_seq+'">'+'댓글번호 : '+i.comm_seq+' / 작성자 : '+i.email;
                a += '<a onclick="commentUpdate('+i.comm_seq+',\''+i.content+'\');"> 수정 </a>';
                a += '<a onclick="commentDelete('+i.comm_seq+');"> 삭제 </a> </div>';
                a += '<div class="commentContent'+i.comm_seq+'"> <p> 내용 : '+i.content +'</p>';
                a += '</div></div>';
            });
            $(".commentList").html(a);
        }
    });
}

//댓글 등록
function commentInsert(insertData){
    $.ajax({
        url : '/writeComment.do',
        type : 'post',
        data : insertData,
        success : function(data){
            if(data == 1) {
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
            }
        }
    });
}

$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});

</script>

