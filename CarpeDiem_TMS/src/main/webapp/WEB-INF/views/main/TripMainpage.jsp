<%@page import="com.cp.tms.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지입니다.</title>
</head>
<body data-spy="scroll" data-target=".fixed-top">
	<%@include file="/WEB-INF/views/header/TMS_header.jsp"%>
	<script>
		function onSignIn(googleUser) {
			// Useful data for your client-side scripts:
			var profile = googleUser.getBasicProfile();

			//구글 로그인
			console.log('Given Name: ' + profile.getGivenName());
			console.log("Email: " + profile.getEmail());

			var name = profile.getEmail();

			// The ID token you need to pass to your backend:
			var id_token = googleUser.getAuthResponse().id_token;
			console.log("ID Token: " + id_token);

		}

		function signOut() {
			var auth2 = gapi.auth2.getAuthInstance();
			auth2.SignOut().then(function() {
				console.log('User signed out.');
			});
			auth2.disconnect();

		}
	</script>
	<!-- Header -->
	<header id="header" class="header">
		<div id="home" class="slider">
			<div id="main_slider" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#main_slider" data-slide-to="0" class="active"></li>
					<li data-target="#main_slider" data-slide-to="1"></li>
					<li data-target="#main_slider" data-slide-to="2"></li>
					<li data-target="#main_slider" data-slide-to="3"></li>
					<li data-target="#main_slider" data-slide-to="4"></li>
					<li data-target="#main_slider" data-slide-to="5"></li>
					<li data-target="#main_slider" data-slide-to="6"></li>
					<li data-target="#main_slider" data-slide-to="7"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img class="d-block w-100" src="images/mainimg/basic-0.jpg" alt="basic-0.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/mainimg/basic-1.jpg" alt="basic-1.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" style="width: 1260px; height: " src="images/mainimg/basic-2.jpg" alt="basic-2.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/mainimg/basic-3.jpg" alt="basic-3.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/mainimg/basic-4.jpg" alt="basic-4.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/mainimg/basic-5.jpg" alt="basic-5.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/mainimg/basic-6.jpg" alt="basic-6.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/mainimg/basic-7.jpg" alt="basic-7.jpg">
						<div class="ovarlay_slide_cont"></div>
					</div>
					<a class="carousel-control-prev" href="#main_slider" role="button"data-slide="prev"><img src="images/left.png"/></a>
					<a class="carousel-control-next" href="#main_slider" role="button" data-slide="next"><img src="images/right.png"/></a>
				</div>
			</div>
		</div>
	</header>
	<!-- end of header -->


	<!-- Intro -->
	<div id="intro" class="basic-1">
		<div class="container">
			<div class="row">
				<div class="col-lg-5">
					<table class="memList" style="font-size: 20px; padding-bottom: 10px;">
						<thead>
							<tr style="padding-bottom: 10px;">
								<th>현재 접속 목록</th>
							</tr>
						</thead>
						<tbody class="accessmembers" style="padding-bottom: 10px;">
						</tbody>
					</table>
					<hr>
					<c:if test="${mDto.email != null}">
						<table class="myChatList" style="font-size: 20px;">
							<tr>
								<th style="padding-bottom: 10px;">내 채팅 리스트</th>
							</tr>
							<c:forEach var="myChatLists" items="${myChatLists}"
								varStatus="vs">
								<tr>
									<td class="mychatname">${fn:substring(myChatLists.chatyourid,0,fn:indexOf(myChatLists.chatyourid,'@')+1)}${fn:toUpperCase(fn:substring(myChatLists.chatyourid,fn:indexOf(myChatLists.chatyourid,'@')+1,fn:indexOf(myChatLists.chatyourid,'@')+2))}</td>
									<td><input type="button" class="btn btn-primary" value="채팅하기" onclick="goSocket2('${myChatLists.chatgroupid}','${myChatLists.chatmyid}','${myChatLists.chatyourid}')"></td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</div>
				<!-- end of col -->
				<div class="col-lg-7">
					<div class="image-container" style="display: inline-block;">
						<img class="img-fluid" src="images/mainimg/main-chatimg.jpg"
							alt="alternative">
					</div>
						
				</div>
			</div>
		</div>
	</div>
	<%@include file="../footer/TMS_footer.jsp"%>
</body>
</html>