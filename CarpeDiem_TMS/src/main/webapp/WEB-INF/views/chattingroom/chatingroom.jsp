<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방입니다.</title>
<link type="text/css" rel="stylesheet" href="./css/chat.css">
</head>
<% String chat_id=(String)session.getAttribute("chat_id"); %>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
      var ws = null ;
      var url = null ;
      var nick = null ; 
      var allContent = "";
      
      $(document).ready(function() { 
    	  chatwss();
      }); 
      
      
      function chatwss(){
          replace();
    	  nick = $("#nickName").val();
          $(".chat_div").show();
          $(".chat").focus();
          
          ws = new WebSocket("ws://172.30.1.15:8091/CarpeDiem_TMS/tripChat.do");
          
          /// 웹소켓 서버가 오픈 됐을때
          ws.onopen = function() {
             ws.send("#$nick_"+nick);
          };
          
          // 메세지 보낼때
          ws.onmessage = function(event) {
          	var msg = event.data;
          	var id = "<%=chat_id%>";
          	// alert("메세지 출력 결과 : "+msg); // ex: user01:안녕
            var msgArr = msg.split(":") // ex: [user01], [안녕] [user02],[아녕]
          	var send = msgArr[0]; // ex: user01
			var sendmsg = msgArr[1]; // ex: 안녕
          	
          	if(msg.startsWith("<font color=")){	//입장,퇴장
            	$(".receive_msg").append($("<div class = 'noticeTxt'>").append(msg+"<br/>"));
          	}else if(send=="<%=chat_id%>"){
	          	$(".receive_msg").append($("<div id='sendDiv' class='"+send+"'>").append($("<span id='sender'class='"+send+"'>").text(send))).append("<br>");
	          	$(".receive_msg").append($("<div id='sendDiv' class='"+send+"'>").append($("<span id='sender'class='"+send+" sendmsg'>").text(sendmsg))).append("<br><br><br><br><br><br>");
          	}else{
	          	$(".receive_msg").append($("<div id='receiveDiv' class='"+send+"'>").append($("<span id='receiver' class='"+send+"'>").text(send))).append("<br>");
	          	$(".receive_msg").append($("<div id='receiveDiv' class='"+send+"'>").append($("<span id='receiver'class='"+send+" receivemsg'>").text(sendmsg))).append("<br><br><br><br><br><br>");
          	}
          	$(".receive_msg").scrollTop($(".receive_msg")[0].scrollHeight);
          	chatSave();
          	
          }
          
          // 메세지 보내기 버튼 클릭시
          $(".chat_btn").bind("click",function() {
             if($(".chat").val() == '' ) {
                alert("내용을 입력하세요");
                return ;
             }else {
                ws.send(nick+" : "+$(".chat").val());
                $(".chat").val('');
                $(".chat").focus();
             }
          });  
          
    }         
    
   // 대화내용 저장
      function chatSave(){
    	var chatmember = document.getElementById("chatmember").value; // chatmember에 mem_id, gr_id 를 담음 -> ex: user01, user02 // (그룹)구디, user01
      		allContent = document.getElementById("receive_msg").innerHTML;
      		$.ajax({
      					url : "./chatboardcontentinsert.do",
      					type : "post",	
      					//업데이트를 위해 db의 chatmember, content을 보냄
      					data : "chatgroupid="+chatmember+"&chatcontent="+allContent,
      					success : function(msg) {
      					}
      				});
      }
      
      
   // 나가기 버튼 눌렀을때
      function roomClose(){
    	  var chatmember = document.getElementById("chatmember").value;
    	 allContent = document.getElementById("receive_msg").innerHTML;
  		$.ajax({
  					url : "./chatboardcontentinsert.do",
  					type : "post",
  					dataType :"json",
  					data : "chatgroupid="+chatmember+"&chatcontent="+allContent,
  					success : function(data) {
  						alert(data);
  					},
  					error: function(data){
  						alert(data);
  					}
  				});
    	  alert("서버와의 연결이 종료되었습니다.");
    	  self.close();
    	  disconnect();
   }
   
   //삭제 버튼 눌렀을때
   function delchat(){
	   var chatmember = document.getElementById("chatmember").value;
	   var chatmyid = "<%=chat_id%>";
	   alert(chatmyid);
	   alert(chatmember);
	   $.ajax({
				url : "./delchatboard.do",
				type : "post",
				dataType :"json",
				data : "chatgroupid="+chatmember+"&chatmyid="+chatmyid,
				success : function(data) {
					alert(data);
				},error : function(data){
					alert(data);
				}
			});
	   alert("서버와의 연결이 종료되었습니다."); 
 	  self.close();
 	  disconnect();
   }
   
   // ws server 종료
      function disconnect() {
         ws.close();
         ws = null ;
      }      	

      function replace(){
      	// 대화내용(메세지)를 왼쪽 오른쪽 구분하기
          var sendDiv = $('#sendDiv').attr('class');
          var receiveDiv = $('#receiveDiv').attr('class');
      	var sender = $('#sender').attr('class');
          var receiver = $('#receiver').attr('class');
          var memId = '${mychatid}';
          
    	  if(sendDiv != memId){
    		  $('#sendDiv').attr('id', 'receiverDiv');
    		  $('#receiveDiv').attr('id', 'senderDiv');
    	  }
    	  
    	  if(sender != memId){
    		  $('#sender').attr('id', 'receivers');
    		  $('#receiver').attr('id', 'senders');
    	  }
      	
      }     
	function chatreport(){
// 		alert("작동");
		var groupid="${chatDto.chatgroupid}";
		alert(groupid);
		$.ajax({
			url : "./reportchatboard.do",
			type : "post",
			dataType :"json",
			data :"groupid="+groupid,
			success : function(data) {
				alert(data);
			},error: function(data){
				alert(data);
			}
		});
		roomClose();
	  	self.close();
  	    disconnect();
	}
</script>
<body>
	<br>
	<input type="hidden" id="nickName" value="<%=chat_id%>" />
	<div style="text-align: center;">
		<a style="font-size: x-large;">${chatDto.chatyourid}</a>
	</div>
	<div style="display: inline-block;">
		<div class="out_btn" onclick="roomClose()"></div>
		<div class="delchat_btn" onclick="delchat()"></div>
		<div id="reportchat_btn" onclick="chatreport()"></div>
	</div>
	<br>
	<table>
		<tr>
			<td width="360x" height="390px" align="center">
				<div id="receive_msg" class="receive_msg" onload="replace();">
					${chatDto.chatcontent}</div>
			</td>
		</tr>
	</table>
	<div class="chat_div" style="display: none; margin-top: 10px;">
		<textarea class="chat"
			onKeypress="if(event.keyCode==13) $('.chat_btn').click();"></textarea>
		<div class="chat_btn"></div>
	</div>
	<div>
		<input type="hidden" id="chatmember" value="${chatDto.chatgroupid}">
	</div>
</body>
</html>