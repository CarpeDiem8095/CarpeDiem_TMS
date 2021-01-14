$(document).ready(function() {
		wss();
	})

	var wss = function() {
		var ws = null;
		var show = null;
		
		// 웹소켓 서버
		var grId = "main"
		$(".accessmembers").children().remove();
		$.ajax({
			url : "./viewChatList.do",
			type : "post",
			success : function(data) {
			for( var k in data.list) {
					if (data.list[k] == grId) {
						if(k !="<%=userdto.getUserid()%>"){
							var gr_id = "<%=userdto.getUserid()%>,"+k;
						$(".accessmembers").append("<tr>"
						+"<td class='main_mem_access'>"+k+"</td>"
						+"<td class='chatbutton'>"+
						"<input type='button' value='채팅하기' onclick="+"goSocket('"+gr_id+"','"+k+"')"+"></td>"
						+"</tr>");
						}
					}
				}
			},
			error : function() {
				console.log('의미 심장한 애러 발생 (╯°□°）╯︵ ┻━┻');
			}
		});
	}
		
	function goSocket(gr_id,chatyour_id){	//내가 만든기
		window.open("./socketOpen.do?chatgroupid="+gr_id+"&chatyourid="+chatyour_id, "그룹채팅", "width = 500, height = 600, resizable = no, toolbar = no, menubar = no, location = no, fullscreen = no, left = 300, top = 50");
	}
	
	function goSocket2(gr_id,chatmy_id,chatyour_id){	//내꺼 접속할때 
		window.open("./socketOpen2.do?chatgroupid="+gr_id+"&chatmyid="+chatmy_id+"&chatyourid="+chatyour_id, "그룹채팅", "width = 500, height = 600, resizable = no, toolbar = no, menubar = no, location = no, fullscreen = no, left = 300, top = 50");
	}