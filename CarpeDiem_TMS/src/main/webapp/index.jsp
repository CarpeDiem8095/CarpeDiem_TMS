<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>CarpeDiem</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <a class="navbar-brand" href="#">CarpeDiem</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="./register.do">회원가입</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">로그인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">확인</a>
      </li>    
    </ul>
  </div>  
</nav>
	<h1><a href="./boardsearch.do?auth=ADMIN">관리자 동행찾기로 이동</a></h1>
	
	<h1><a href="./boardsearch.do?auth=USER">유저 동행찾기로 이동</a></h1>
	<h1><a href="./notePaging.do">노트로 이동</a></h1>
	<h1><a href="./questionBoard.do">문의 게시판</a></h1>
	<h1><a href="./commnetList.do?one_seq=2">댓글 게시판</a></h1>
	<h1><a href="./reviewsList.do?seq=2&one_seq=4">하루일정 조회 게시판</a></h1>
	<form action="./mainchat.do" method="post">
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="userid" value="sung9606071@gmail.com"> </td>
		</tr>
		<tr>
			<td><input type="submit" value="로그인"> </td>
		</tr>
	</table>
	</form>
	<form action="./mainchat.do" method="post">
	<table>
		<tr>
			<th>아이디</th>
			<td><input type="text" name="userid" value="happy0104@gmail.com"> </td>
		</tr>
		<tr>
			<td><input type="submit" value="로그인"> </td>
		</tr>
	</table>
	</form>
	<hr>
	<h6>
		신고하기 test &nbsp;
		<input type="button" value="신고하기(ver.1)" onclick="report1()"> &nbsp;
		<input type="button" value="신고하기(ver.3)" onclick="report3()">
	</h6>
	<h3><a href="./reportBoard.do">신고처리 게시판</a></h3>
</body>
<script type="text/javascript">
	function report1() {
		open("./report(ver.1).jsp", "", "width=600px, height=600px");
	}
	
	function report3() {
		open("./report(ver.3).jsp", "", "width=600px, height=600px");
	}
</script>
</html>