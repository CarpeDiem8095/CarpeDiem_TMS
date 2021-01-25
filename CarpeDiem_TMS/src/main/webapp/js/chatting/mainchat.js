$(document).ready(function(){
	wss();
});
var wss = function() {
		var userid = $("#userid").val();
		var grId = "main";
		$(".accessmembers").children().remove();
		$.ajax({
			url : "./viewChatList.do",
			type : "post",
			success : function(data) {
			for( var k in data.list) {
					if (data.list[k] == grId) {
						var spuserid= k.split('@');
						spuserid[1] = spuserid[1].substr(0,1);
						var gr_id = userid+","+k;
						if(userid == '' || userid ==null){
								$(".accessmembers").append("<tr><td class='main_mem_access' colspan='2'>"+
								spuserid[0]+"@"+spuserid[1].toUpperCase()+"</td></tr>");
						}
						else if(k != userid){
						$(".accessmembers").append("<tr><td class='main_mem_access'>"+spuserid[0]+"@"+spuserid[1].toUpperCase()
						+"</td>"+"<td class='chatbutton'>"+"<input type='button' value='채팅하기' onclick="+"goSocket('"+gr_id+"','"+k+"')"+"></td></tr>");
							}
						}
					}
				
			},
			error : function() {
				console.log('의미 심장한 애러 발생 (╯°□°）╯︵ ┻━┻');
			}
		});
	}
		
	function goSocket(gr_id,chatyour_id){	// 내가 만든기
		window.open("./socketOpen.do?chatgroupid="+gr_id+"&chatyourid="+chatyour_id, "그룹채팅", "width = 500, height = 600, resizable = no, toolbar = no, menubar = no, location = no, fullscreen = no, left = 300, top = 50");
	}
	
	function goSocket2(gr_id,chatmy_id,chatyour_id){	// 내꺼 접속할때
		window.open("./socketOpen2.do?chatgroupid="+gr_id+"&chatmyid="+chatmy_id+"&chatyourid="+chatyour_id, "그룹채팅", "width = 500, height = 600, resizable = no, toolbar = no, menubar = no, location = no, fullscreen = no, left = 300, top = 50");
	}