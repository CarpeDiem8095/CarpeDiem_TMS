<%@page import="com.cp.tms.dto.UserDto"%>
<%@page import="com.cp.tms.dto.ChatingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<%
	UserDto userdto = (UserDto) session.getAttribute("userdto");
%>
<script type="text/javascript">
	$(document).ready(function() {
		wss();
	})

	var wss = function() {
		var ws = null;
		var show = null;
		
		// 웹소켓 서버
		var grId = "main"
		$(".memList").children().remove();
		$(".memList").append("<tr><th colspan='2'>접속 목록</th></tr>");
		$.ajax({
			url : "./viewChatList.do",
			type : "post",
			success : function(data) {
			for( var k in data.list) {
					if (data.list[k] == grId) {
						if(k !="<%=userdto.getUserid()%>"){
							var gr_id = "<%=userdto.getUserid()%>,"+k;
						$(".memList").append("<tr>"
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
</script>
<body>
	<table class="memList"></table>
	<hr>
	<table class="myChatList">
	<tr>
		<th colspan="2">내 채팅 리스트</th>
	</tr>
	<c:set var="myid" value="<%=userdto.getUserid()%>" ></c:set>
	<c:forEach var="mychat" items="${myChatList}">
		<tr>
				<c:choose>
				<c:when test="${mychat.chatyourid eq myid}">
					<td class="mychatname">${mychat.chatmyid}</td>
					<td><input type="button" value="채팅하기" onclick="goSocket2('${mychat.chatgroupid}','${mychat.chatmyid}','${mychat.chatyourid}')"></td>
				</c:when>
				<c:otherwise>
				<td class="mychatname">${mychat.chatyourid}</td>
				<td><input type="button" value="채팅하기" onclick="goSocket2('${mychat.chatgroupid}','${mychat.chatmyid}','${mychat.chatyourid}')"></td>
				</c:otherwise>
				</c:choose>
		</tr>
	</c:forEach>
	</table>
</body>
</html>