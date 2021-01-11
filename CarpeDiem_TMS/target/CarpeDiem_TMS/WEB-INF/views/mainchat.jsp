<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인입니다.</title>
<style type="text/css">
.mainaccess {
	margin-left: 15px;
	font-size: 13px;
	padding: 5px;
	border-bottom: 0.5px solid #B4B4B4;
}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.js"></script>
<!-- <script type="text/javascript" src="./js/tripsearchboard.js"></script> -->
<script type="text/javascript">
	//접속자 목록 조회

	$(document).ready(function() {
		// 		console.log('작동');
		wss();
	})

	var wss = function() {
		// 		alert("성공");

		var ws = null;
		// 웹소켓 서버
		ws = new WebSocket("ws://172.30.1.15:8091/CarpeDiem_TMS/tripChat.do");
		var grId = "'main'"
		var myId = <%=session.getAttribute("chatlogin_id")%>
		$(".memList").children().remove();
		$(".memList").append("<tr><td colspan='2'>접속 목록</td></tr>");
		$.ajax({
			url : "./viewChatList.do",
			type : "post",
			success : function(data) {
			for( var k in data.list) {
					if (data.list[k] == grId) {
						$(".memList").append("<tr>"
						+"<td class='mainaccess'>"+k+"</td>"
						+"<td class='chatbutton'><input type='button' value='채팅하기' onclick='goSocket('sung960607@gmail.com')'></td>"
						+"</tr>");
					}
				}
			},
			error : function() {
				console.log('의미 심장한 애러 발생 (╯°□°）╯︵ ┻━┻');
			}
		});
	}
	
	function goSocket(gr_id,mem_id){
		window.open("./tripsocketOpen.do?mem_id="+mem_id+"&gr_id="+gr_id, "그룹채팅", "width = 500, height = 600, resizable = no, toolbar = no, menubar = no, location = no, fullscreen = no, left = 300, top = 50");
}
</script>
<body>
	<table class="memList"></table>

</body>
</html>