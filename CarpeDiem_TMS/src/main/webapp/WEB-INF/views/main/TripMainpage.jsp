<%@page import="com.cp.tms.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>메인페이지입니다.</title>
<style type="text/css">
.mainaccess {
	margin-left: 15px;
	font-size: 13px;
	padding: 5px;
	border-bottom: 0.5px solid #B4B4B4;
}	
</style>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:500,700&display=swap&subset=latin-ext" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,400i,600&display=swap&subset=latin-ext" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/swiper.css" rel="stylesheet">
	<link href="css/magnific-popup.css" rel="stylesheet">
	<link href="css/styles.css" rel="stylesheet">
	<link href="css/fontawesome-all.css" rel="stylesheet">
    <link rel="icon" href="images/favicon.png">
</head>
<script  src="https://code.jquery.com/jquery-3.5.1.js"></script>
  	<script type="text/javascript">
	$(document).ready(function(){
		var id = '${mDto.email}';
		if(id =='' || id == null){
			$(".userboard").css("display","none");
		}else{
			$(".login").css('display','none');
			$(".join").css('display','none');
			accessChating();
		}
	});
  	
	function loginChkeck(){
	var email = $("#InputEmail").val();
	var password = $("#InputPassword").val();
	$.ajax({ 
				type:"post",
				url:"./loginCheckMap.do",
				data:"email="+email+"&password="+password,
				success:function(msg){
					if(msg.isc=="성공"){
					$(".login").css('display','none');
					$(".join").css('display','none');
					$(".userboard").css('display','block');
					selmychatboard();
					}else{
						alert("이메일 또는 비밀번호가 맞지 않습니다.");
						alert(isc);
					}
					location.reload();
				},
				error:function(){
					alert("로그인에 문제가 발생했습니다.");
				}
			});
	}
	
	function accessChating(){
		var email = '${mDto.email}';
		$.ajax({
			type:"post",
			url:"./mainchat.do",
			data:"userid="+email,
			success:function(){
				alert("접속성공");
			},error:function(){
				alert("채팅접속에 문제가 발생하였습니다.");
			}
		});
	}
	
	function selmychatboard(){
		$.ajax({
			type:"post",
			url:"./selmychatboard.do",
			success:function(){
				alert("채팅목록 성공");
			},error:function(){
				alert("채팅목록 실패");
			}
		});
	}
	
	function checklogining(){
		var email = '${mDto.email}';
		if(email==null || email==''){
			alert("로그인을 하셔야 합니다.");
		}else{
			$("#boardserch").prop('href', "./boardsearch.do");
		}
	}
	
	</script>
	<c:if test="${mDto.email !=null}">
	<script type="text/javascript" src="./js/chatting/mainchat.js"></script>
	</c:if>
<body data-spy="scroll" data-target=".fixed-top">
<!-- Preloader -->
	<div class="spinner-wrapper">
        <div class="spinner">
            <div class="bounce1"></div>
            <div class="bounce2"></div>
            <div class="bounce3"></div>
        </div>
    </div>
    <!-- end of preloader -->
    

    <!-- Navbar -->
    <nav class="navbar navbar-expand-md navbar-dark navbar-custom fixed-top">
        <!-- Text Logo - Use this if you don't have a graphic logo -->
        <!-- <a class="navbar-brand logo-text page-scroll" href="index.html">Aria</a> -->

        <!-- Image Logo -->
        <a class="navbar-brand logo-image" href="index.html"><img src="images/calo.png" alt="alternative"></a>
        
        <!-- Mobile Menu Toggle Button -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-awesome fas fa-bars"></span>
            <span class="navbar-toggler-awesome fas fa-times"></span>
        </button>
        <!-- end of mobile menu toggle button -->

        <div class="collapse navbar-collapse" id="navbarsExampleDefault">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link page-scroll" href="#header">HOME <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link page-scroll" href="./notePaging.do">일정 관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link page-scroll" href="./oneBoardList.do">리뷰 보기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link page-scroll" id="boardserch" onclick="checklogining()">동행찾기 게시판</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link page-scroll" href="./questionBoard.do">문의하기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link page-scroll" href="./reportBoard.do">신고처리</a>
                </li>
                <li>
                	<button type="button" class="btn btn-primary join"
						data-toggle="modal" data-target="#myModal">회원가입</button>
					<button type="button" class="btn btn-primary login"
						data-toggle="modal" data-target="#loginModal">로그인</button>
                </li>
                <li class="userboard nav-item">
                	회원 아이디 :${mDto.email}
                	<br>
                	회원 이름  :${mDto.auth}
                	<a href="./logout.do">로그아웃</a>
                </li>
            </ul>
        </div>
    </nav> <!-- end of navbar -->
    <!-- end of navbar -->
    <input type="hidden" id="userid" value="${mDto.email}">

  <!-- The Modal -->
  <script>
//이메일 중복검사
  $('.email').on("propertychange change keyup paste input", function(){
//   	console.log("keyup 테스트");	
	var memberId = $('.email').val();	// .email에 입력되는 값	// '컨트롤에 넘길 데이터 이름' : '데이터(.email에 입력되는 값)'
  });// function 종료
  
  function emailchek(){
	  var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	  var email = $("#email").val();
	  if(!emailRule.test(email)) {
		  $("#emailcheck").css("color","green");
          $("#emailcheck").html("잘못된 형식입니다.");
		}else{
			$("#emailcheck").css("color","red");
			$("#emailcheck").html("올바른 형식입니다.");
		}
  }
  
  
  
  
/* 인증번호 이메일 전송 */
$("#sendCheckNum").click(function(){
	
	var email = $("#email").val();
// 	alert("이메일 전송");
	$.ajax({
		
		type:"GET",
		url:"./mailCheck.do?email="+email,
		success:function(data){
			console.log("data:" +data);
			
		}
	});
	
});



  

</script>
		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">CarpeDiem</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<form action="form-horizontal" class="form-horizontal" method="POST" id="Frm" name="Frm" onsubmit="return false;">
					<div class="modal-body">
							<div class="modal-body"
								style="padding: 30px 50px; height: 500px;">
								<div class="form-group" style="text-align: left; width: 72%"
									id="divEmail">
									<!-- 이메일 확인 -->
									<label for="email">
									<span
										class="glyphicon glyphicon-user"></span> 이메일</label> <input
										type="text" class="email form-control" id="email" name="email"
										placeholder="이메일을 입력하세요" onkeyup="emailchek()">
									<div id="emailcheck" class="glyphicon glyphicon-user"></div>
								</div>
			
								<div class="form-group"
									style="float: right; margin-top: -53px; margin-right: 10px"
									id="divinputCheckNum">
									<button type="button" class="btn btn-primary btn-block"
										id="sendCheckNum">
										<span class="glyphicon glyphicon-envelope"></span>인증
									</button>
								</div>
								
								<!-- 인증번호 -->
								<div class="form-group" style="text-align: left; width: 72%"
									id="divCheckNum">
									<label for="checknum"><span
										class="glyphicon glyphicon-envelope"></span> 인증번호</label> <input
										type="text" class="form-control" id="inputCheckNum"
										name="inputCheckNum" placeholder="인증번호를 입력하세요">
								</div>
								<!-- 인증번호 확인및 완료 -->
								<div class="form-group" style="float: right; margin-top: -53px; margin-right: 10px"
									id="divCheckConfirm">
									<button type="button" class="btn btn-primary btn-block"
										id="checkConfirm" name="checkConfirm">
										<span class="glyphicon glyphicon-ok"></span>확인
									</button>
									<input type="hidden" id="certificationYN" value="false">
								</div>
								<hr>
								<!-- 닉네임 확인 -->
								<div class="form-group" id="divNickname"
									style="text-align: left;">
									<label for="nickname"> <span
										class="glyphicon glyphicon-apple"></span> 닉네임
									</label> <input type="text" class="pwd form-control" id="nickname"
										name="nickname" placeholder="사용하실 닉네임을 입력하세요.(2자리 이상)">
								</div>
								<!-- 비밀번호 -->
								<div class="form-group" id="divPwd" style="text-align: left;">
									<label for="psw"> <span
										class="glyphicon glyphicon-eye-open"></span> 1차 비밀번호
									</label> <input type="password" class="pwd form-control" id="pwd"
										name="pwd" placeholder="1차 비밀번호를 입력하세요(8자리 이상)">
								</div>
								<!-- 2차비밀번호 -->
								<div class="form-group" id="divPwd2" style="text-align: left;">
									<label for="psw"><span
										class="glyphicon glyphicon-eye-open"></span> 2차 비밀번호</label> <input
										type="password" class="form-control" id="pwd2" name="pwd2"
										placeholder="2차 비밀번호를 입력하세요(8자리 이상)">
								</div>
								
								
							
					</div>

					<!-- 완료 -->
					<div class="modal-footer">
						
						<button type="submit" id="signYes" name="signYes"
							class="btn btn-success btn-default pull-left" value="Send"
							style="margin: 10px; margin-right: 270px">
							<span class="glyphicon glyphicon-plus"></span>완 료
						</button>

						<button type="button" class="btn btn-danger btn-default pull-left"
							data-dismiss="modal" value="Input Button" style="margin: 10px">
							<span class="glyphicon glyphicon-remove"></span>취 소
						</button>
					</div>
					</div>
					</form>
				</div>
			</div>
		</div>
			<!-- 로그인 모달 -->
	<!-- The Modal -->
	<div class="modal fade" id="loginModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">CarpeDiem</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<form method="post" name="frm">
						<div class="form-group has-feedback">
							<input type="text" id="InputEmail" class="form-control" placeholder="이메일">
							<span class="glyphicon glyphicon-exclamation-sign form-control-feedback"></span>
						</div>

						<div class="form-group has-feedback">
							<input type="password" id="InputPassword" class="form-control" value="tt001!" placeholder="비밀번호" onkeyup="enterkey()">
							<span class="glyphicon glyphicon-lock form-control-feedback"></span>
						</div>
						
						<div class="row" style="margin-left: 10px">
							<div class="col-xs-4" style="margin-top: -5px;">
								<input type="button" id="login" name="login" value="로그인"onclick="loginChkeck()" class="btn btn-primary btn-block btn-flat">
								<a href="./findpw.do">비밀번호 찾기</a><br>
							</div>
						</div>
						<hr>
						
						<div id="naver_id_login" style="text-align: center">
							<a href="#" class="btn btn-success"> N+네이버 계정 로그인 </a> <a
								href="#" class="btn btn-primary"> <i class="fa">&#xf0d5;</i>
								구글 계정으로 로그인
							</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

    <!-- Header -->
    <header id="header" class="header">
 	<div id="home" class="slider">
         <div id="main_slider" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
               <li data-target="#main_slider" data-slide-to="0" class="active"></li>
               <li data-target="#main_slider" data-slide-to="1"></li>
               <li data-target="#main_slider" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
               <div class="carousel-item active">
                  <img class="d-block w-100" src="images/slide1.jpg" alt="slider_img">
               </div>
               <div class="carousel-item">
                  <img class="d-block w-100" src="images/about.jpg" alt="slider_img">
               </div>
               <div class="carousel-item">
                  <img class="d-block w-100" src="images/slide1.jpg" alt="slider_img">
                  <div class="ovarlay_slide_cont">
               </div>
            </div>
            <a class="carousel-control-prev" href="#main_slider" role="button" data-slide="prev">
            <img src="images/left.png"/>
            </a>
            <a class="carousel-control-next" href="#main_slider" role="button" data-slide="next">
            <img src="images/right.png"/>
            </a>
         </div>
      </div>
      </div>
    </header> <!-- end of header -->
    <!-- end of header -->


    <!-- Intro -->
    <div id="intro" class="basic-1">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                    <table class="memList">
                    <thead>
                    <tr>
                    	<th colspan="2">현재 접속 목록</th>
                    </tr>
                    </thead>
                    <tbody class="accessmembers">
                    </tbody>
                    </table>
	<hr>
<c:if test="${mDto.email != null}">
	<table class="myChatList">
	<tr>
		<th colspan='2'>내 채팅 리스트</th>
	</tr>
	<c:forEach var="myChatLists" items="${myChatLists}" varStatus="vs">
		<tr>
				<td class="mychatname">${fn:toUpperCase(fn:substring(myChatLists.chatyourid,fn:indexOf(myChatLists.chatyourid,'@')+1,fn:indexOf(myChatLists.chatyourid,'@')+2))}</td>
				<td><input type="button" value="채팅하기" onclick="goSocket2('${myChatLists.chatgroupid}','${myChatLists.chatmyid}','${myChatLists.chatyourid}')"></td>
		</tr>
	</c:forEach>
	</table>
</c:if>
                </div> <!-- end of col -->
                <div class="col-lg-7">
                    <div class="image-container">
                        <img class="img-fluid" src="images/intro-office.jpg" alt="alternative">
                    </div> <!-- end of image-container -->
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of basic-1 -->
    <!-- end of intro -->


    <!-- Description -->
    <div class="cards-1">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    
                    <!-- Card -->
                    <div class="card">
                        <span class="fa-stack">
                            <span class="hexagon"></span>
                            <i class="fas fa-binoculars fa-stack-1x"></i>
                        </span>
                        <div class="card-body">
                            <h4 class="card-title">Environment Analysis</h4>
                            <p>The starting point of any success story is knowing your current position in the business environment</p>
                        </div>
                    </div>
                    <!-- end of card -->

                    <!-- Card -->
                    <div class="card">
                        <span class="fa-stack">
                            <span class="hexagon"></span>
                            <i class="fas fa-list-alt fa-stack-1x"></i>
                        </span>
                        <div class="card-body">
                            <h4 class="card-title">Development Planning</h4>
                            <p>After completing the environmental analysis the next stage is to design and  plan your development strategy</p>
                        </div>
                    </div>
                    <!-- end of card -->

                    <!-- Card -->
                    <div class="card">
                        <span class="fa-stack">
                            <span class="hexagon"></span>
                            <i class="fas fa-chart-pie fa-stack-1x"></i>
                        </span>
                        <div class="card-body">
                            <h4 class="card-title">Execution & Evaluation</h4>
                            <p>In this phase you will focus on executing the actions plan and evaluating the results after each marketing campaign</p>
                        </div>
                    </div>
                    <!-- end of card -->

                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of cards-1 -->
    <!-- end of description -->


    <!-- Services -->
    <div id="services" class="cards-2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">SERVICES</div>
                    <h2>Choose The Service Package<br> That Suits Your Needs</h2>
                </div> <!-- end of col -->
            </div> <!-- end of row -->
            <div class="row">
                <div class="col-lg-12">
                    
                    <!-- Card -->
                    <div class="card">
                        <div class="card-image">
                            <img class="img-fluid" src="images/services-1.jpg" alt="alternative">
                        </div>
                        <div class="card-body">
                            <h3 class="card-title">Off The Ground Off The Ground</h3>
                            <p>Perfect for fresh ideas or young startups, this package will help get the business off the ground</p>
                            <ul class="list-unstyled li-space-lg">
                                <li class="media">
                                    <i class="fas fa-square"></i>
                                    <div class="media-body">Environment and competition</div>
                                </li>
                                <li class="media">
                                    <i class="fas fa-square"></i>
                                    <div class="media-body">Designing the marketing plan</div>
                                </li>
                            </ul>
                            <p class="price">Starting at <span>$199</span></p>
                        </div>
                        <div class="button-container">
                            <a class="btn-solid-reg page-scroll" href="#callMe">DETAILS</a>
                        </div> <!-- end of button-container -->
                    </div>
                    <!-- end of card -->

                    <!-- Card -->
                    <div class="card">
                        <div class="card-image">
                            <img class="img-fluid" src="images/services-2.jpg" alt="alternative">
                        </div>
                        <div class="card-body">
                            <h3 class="card-title">Accelerated Growth</h3>
                            <p>Use this service pack to give your company the necessary impulse to become an industry leader</p>
                            <ul class="list-unstyled li-space-lg">
                                <li class="media">
                                    <i class="fas fa-square"></i>
                                    <div class="media-body">Business strategy planning</div>
                                </li>
                                <li class="media">
                                    <i class="fas fa-square"></i>
                                    <div class="media-body">Taking the planned actions</div>
                                </li>
                            </ul>
                            <p class="price">Starting at <span>$299</span></p>
                        </div>
                        <div class="button-container">
                            <a class="btn-solid-reg page-scroll" href="#callMe">DETAILS</a>
                        </div> <!-- end of button-container -->
                    </div>
                    <!-- end of card -->

                    <!-- Card -->
                    <div class="card">
                        <div class="card-image">
                            <img class="img-fluid" src="images/services-3.jpg" alt="alternative">
                        </div>
                        <div class="card-body">
                            <h3 class="card-title">Market Domination</h3>
                            <p>You already are a reference point in your industry now you need to learn about acquisitions</p>
                            <ul class="list-unstyled li-space-lg">
                                <li class="media">
                                    <i class="fas fa-square"></i>
                                    <div class="media-body">Maintaining the leader status</div>
                                </li>
                                <li class="media">
                                    <i class="fas fa-square"></i>
                                    <div class="media-body">Acquisitions the right way</div>
                                </li>
                            </ul>
                            <p class="price">Starting at <span>$299</span></p>
                        </div>
                        <div class="button-container">
                            <a class="btn-solid-reg page-scroll" href="#callMe">DETAILS</a>
                        </div> <!-- end of button-container -->
                    </div>
                    <!-- end of card -->

                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of cards-2 -->
    <!-- end of services -->
    

    <!-- Details 1 -->
	<div id="details" class="accordion">
		<div class="area-1">
		</div><!-- end of area-1 on same line and no space between comments to eliminate margin white space --><div class="area-2">
            
            <!-- Accordion -->
            <div class="accordion-container" id="accordionOne">
                <h2>Accelerate Business Growth To Improve Revenue Numbers</h2>
                <div class="item">
                    <div id="headingOne">
                        <span data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" role="button">
                            <span class="circle-numbering">1</span><span class="accordion-title">How Can Aria Help Your Business</span>
                        </span>
                    </div>
                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionOne">
                        <div class="accordion-body">
                            At Aria solutions, we’ve taken the consultancy concept one step further by offering a full service management organization with expertise.
                        </div>
                    </div>
                </div> <!-- end of item -->
            
                <div class="item">
                    <div id="headingTwo">
                        <span class="collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" role="button">
                            <span class="circle-numbering">2</span><span class="accordion-title">Great Strategic Business Planning</span>
                        </span>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionOne">
                        <div class="accordion-body">
                            Aria partners with businesses to business growth and development ideas including environment analysis, plan execution and evaluation.
                        </div>
                    </div>
                </div> <!-- end of item -->
            
                <div class="item">
                    <div id="headingThree">
                        <span class="collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" role="button">
                            <span class="circle-numbering">3</span><span class="accordion-title">Online Marketing Campaigns</span>
                        </span>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionOne">
                        <div class="accordion-body">
                            An awesome online marketing plan won't save your bad product but paired with a good product, the sky is the limit for what can be achieved.
                        </div>
                    </div>
                </div> <!-- end of item -->
            </div> <!-- end of accordion-container -->
            <!-- end of accordion -->

		</div> <!-- end of area-2 -->
    </div> <!-- end of accordion -->
    <!-- end of details 1 -->


    <!-- Details 2 -->
	<div class="tabs">
        <div class="area-1">
            <div class="tabs-container">
                
                <!-- Tabs Links -->
                <ul class="nav nav-tabs" id="ariaTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="nav-tab-1" data-toggle="tab" href="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true"><i class="fas fa-th"></i> Business</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="nav-tab-2" data-toggle="tab" href="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false"><i class="fas fa-th"></i> Expertise</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="nav-tab-3" data-toggle="tab" href="#tab-3" role="tab" aria-controls="tab-3" aria-selected="false"><i class="fas fa-th"></i> Quality</a>
                    </li>
                </ul>
                <!-- end of tabs links -->
                
                <!-- Tabs Content -->
                <div class="tab-content" id="ariaTabsContent">

                    <!-- Tab -->
                    <div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="tab-1">
                        <h4>Business Services For Companies</h4>
                        <p>Aria provides the most innovative and customized business services in the industry. Our <a class="green page-scroll" href="#services">Services</a> section shows how flexible we are for all types of budgets.</p>
                        
                        <!-- Progress Bars -->
                        <div class="progress-container">
                            <div class="title">Business Development 100%</div>
                            <div class="progress">
                                <div class="progress-bar first" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="title">Opportunity Spotting 76%</div>
                            <div class="progress">
                                <div class="progress-bar second" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="title">Online Marketing 90%</div>
                            <div class="progress">
                                <div class="progress-bar third" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div> <!-- end of progress-container -->
                        <!-- end of progress bars -->
                        
                    </div> <!-- end of tab-pane --> 
                    <!-- end of tab -->

                    <!-- Tab -->
                    <div class="tab-pane fade" id="tab-2" role="tabpanel" aria-labelledby="tab-2">
                        <ul class="list-unstyled li-space-lg first">
                            <li class="media">
                                <div class="media-bullet">1</div>
                                <div class="media-body"><strong>High quality</strong> is on top of our list when it comes to the way we deliver the services</div>
                            </li>
                            <li class="media">
                                <div class="media-bullet">2</div>
                                <div class="media-body"><strong>Maximum impact</strong> is what we look for in our actions</div>
                            </li>
                            <li class="media">
                                <div class="media-bullet">3</div>
                                <div class="media-body"><strong>Quality standards</strong> are important but meant to be exceeded</div>
                            </li>
                        </ul>
                        <ul class="list-unstyled li-space-lg last">
                            <li class="media">
                                <div class="media-bullet">4</div>
                                <div class="media-body"><strong>We're always looking</strong> for industry leaders to help them win their market position</div>
                            </li>
                            <li class="media">
                                <div class="media-bullet">5</div>
                                <div class="media-body"><strong>Evaluation</strong> is a key aspect of this business and important</div>
                            </li>
                            <li class="media">
                                <div class="media-bullet">6</div>
                                <div class="media-body"><strong>Ethic</strong> procedures ar alwasy at the base of everything we do</div>
                            </li>
                        </ul>
                    </div> <!-- end of tab-pane -->
                    <!-- end of tab -->

                    <!-- Tab -->
                    <div class="tab-pane fade" id="tab-3" role="tabpanel" aria-labelledby="tab-3">
                        <p><strong>We strive to achieve</strong> 100% customer satisfaction for both types of customers: hiring companies and job seekers. Types of customers: <a class="green" href="#your-link">with huge potential</a></p>
                        <p><strong>Our goal is to help</strong> your company achieve its full potential and establish long term stability for <a class="green" href="#your-link">the stakeholders</a></p>
                        <ul class="list-unstyled li-space-lg">
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">It's easy to get a quotation, just call our office anytime</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">We'll get back to you with an initial estimate soon</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">Get ready to see results even after only 30 days</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">Ask for a quote and start improving your business</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">Just fill out the form and we'll call you right away</div>
                            </li>
                        </ul>
                    </div> <!-- end of tab-pane -->
                    <!-- end of tab -->

                </div> <!-- end of tab-content -->
                <!-- end of tabs content -->

            </div> <!-- end of tabs-container -->
        </div><!-- end of area-1 on same line and no space between comments to eliminate margin white space --><div class="area-2"></div> <!-- end of area-2 -->
    </div> <!-- end of tabs -->
    <!-- end of details 2 -->

    <!-- Call Me -->
    <div id="callMe" class="form-1">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="text-container">
                        <div class="section-title">CALL ME</div>
                        <h2 class="white">Have Us Contact You By Filling And Submitting The Form</h2>
                        <p class="white">You are just a few steps away from a personalized offer. Just fill in the form and send it to us and we'll get right back with a call to help you decide what service package works.</p>
                        <ul class="list-unstyled li-space-lg white">
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">It's very easy just fill in the form so we can call</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">During the call we'll require some info about the company</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">Don't hesitate to email us for any questions or inquiries</div>
                            </li>
                        </ul>
                    </div>
                </div> <!-- end of col -->
                <div class="col-lg-6">
                   
                    <!-- Call Me Form -->
                    <form id="callMeForm" data-toggle="validator" data-focus="false">
                        <div class="form-group">
                            <input type="text" class="form-control-input" id="lname" name="lname" required>
                            <label class="label-control" for="lname">Name</label>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control-input" id="lphone" name="lphone" required>
                            <label class="label-control" for="lphone">Phone</label>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control-input" id="lemail" name="lemail" required>
                            <label class="label-control" for="lemail">Email</label>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <select class="form-control-select" id="lselect" required>
                                <option class="select-option" value="" disabled selected>Interested in...</option>
                                <option class="select-option" value="Off The Ground">Off The Ground</option>
                                <option class="select-option" value="Accelerated Growth">Accelerated Growth</option>
                                <option class="select-option" value="Market Domination">Market Domination</option>
                            </select>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group checkbox white">
                            <input type="checkbox" id="lterms" value="Agreed-to-Terms" name="lterms" required>I agree with Aria's stated <a class="white" href="privacy-policy.html">Privacy Policy</a> and <a class="white" href="terms-conditions.html">Terms & Conditions</a>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="form-control-submit-button">CALL ME</button>
                        </div>
                        <div class="form-message">
                            <div id="lmsgSubmit" class="h3 text-center hidden"></div>
                        </div>
                    </form>
                    <!-- end of call me form -->
                    
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of form-1 -->
    <!-- end of call me -->


    <!-- Projects -->
	<div id="projects" class="filter">
		<div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">PROJECTS</div>
                    <h2>Projects That We're Proud Of</h2>
                </div> <!-- end of col -->
            </div> <!-- end of row -->
            <div class="row">
                <div class="col-lg-12">
                    <!-- Filter -->
                    <div class="button-group filters-button-group">
                        <a class="button is-checked" data-filter="*"><span>SHOW ALL</span></a>
                        <a class="button" data-filter=".design"><span>DESIGN</span></a>
                        <a class="button" data-filter=".development"><span>DEVELOPMENT</span></a>
                        <a class="button" data-filter=".marketing"><span>MARKETING</span></a>
                        <a class="button" data-filter=".seo"><span>SEO</span></a>
                    </div> <!-- end of button group -->
                    <div class="grid">
                        <div class="element-item development">
                            <a class="popup-with-move-anim" href="#project-1"><div class="element-item-overlay"><span>Online Banking</span></div><img src="images/project-1.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item development">
                            <a class="popup-with-move-anim" href="#project-2"><div class="element-item-overlay"><span>Classic Industry</span></div><img src="images/project-2.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item design development marketing">
                            <a class="popup-with-move-anim" href="#project-3"><div class="element-item-overlay"><span>BoomBap Audio</span></div><img src="images/project-3.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item design development marketing">
                            <a class="popup-with-move-anim" href="#project-4"><div class="element-item-overlay"><span>Van Moose</span></div><img src="images/project-4.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item design development marketing seo">
                            <a class="popup-with-move-anim" href="#project-5"><div class="element-item-overlay"><span>Joy Moments</span></div><img src="images/project-5.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item design marketing seo">
                            <a class="popup-with-move-anim" href="#project-6"><div class="element-item-overlay"><span>Spark Events</span></div><img src="images/project-6.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item design marketing">
                            <a class="popup-with-move-anim" href="#project-7"><div class="element-item-overlay"><span>Casual Wear</span></div><img src="images/project-7.jpg" alt="alternative"></a>
                        </div>
                        <div class="element-item design marketing">
                            <a class="popup-with-move-anim" href="#project-8"><div class="element-item-overlay"><span>Zazoo Apps</span></div><img src="images/project-8.jpg" alt="alternative"></a>
                        </div>
                    </div> <!-- end of grid -->
                    <!-- end of filter -->
                    
                </div> <!-- end of col -->
            </div> <!-- end of row -->
		</div> <!-- end of container -->
    </div> <!-- end of filter -->
    <!-- end of projects -->


    <!-- Project Lightboxes -->
    <!-- Lightbox -->
    <div id="project-1" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-1.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Online Banking</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-2" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-2.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Classic Industry</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-3" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-3.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>BoomBap Audio</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-4" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-4.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Van Moose</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-5" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-5.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Joy Moments</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-6" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-6.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Spark Events</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-7" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-7.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Casual Wear</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->

    <!-- Lightbox -->
    <div id="project-8" class="lightbox-basic zoom-anim-dialog mfp-hide">
        <div class="row">
            <button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
            <div class="col-lg-8">
                <img class="img-fluid" src="images/project-8.jpg" alt="alternative">
            </div> <!-- end of col -->
            <div class="col-lg-4">
                <h3>Zazoo Apps</h3>
                <hr class="line-heading">
                <h6>Strategy Development</h6>
                <p>Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current needs</p>
                <p>By offering the best professional services and quality products in the market. Don't hesitate and get in touch with us.</p>
                <div class="testimonial-container">
                    <p class="testimonial-text">Need a solid foundation for your business growth plans? Aria will help you manage sales and meet your current requirements.</p>
                    <p class="testimonial-author">General Manager</p>
                </div>
                <a class="btn-solid-reg" href="#your-link">DETAILS</a> <a class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a> 
            </div> <!-- end of col -->
        </div> <!-- end of row -->
    </div> <!-- end of lightbox-basic -->
    <!-- end of lightbox -->
    <!-- end of project lightboxes -->


    <!-- Team -->
    <div class="basic-2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Our Team Of Consultants</h2>
                    <p class="p-heading">We're only as strong and as knowledgeable as our team. So here are the men and women which help customers meet goals and grow companies</p>
                </div> <!-- end of col -->
            </div> <!-- end of row -->
            <div class="row">
                <div class="col-lg-12">

                    <!-- Team Member -->
                    <div class="team-member">
                        <div class="image-wrapper">
                            <img class="img-fluid" src="images/team-1.png" alt="alternative">
                        </div> <!-- end of image-wrapper -->
                        <p class="p-large">John Whitelong</p>
                        <p class="job-title">General Manager</p>
                        <span class="social-icons">
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-facebook-f fa-stack-1x"></i>
                                </a>
                            </span>
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-twitter fa-stack-1x"></i>
                                </a>
                            </span>
                        </span>
                    </div> <!-- end of team-member -->
                    <!-- end of team member -->

                    <!-- Team Member -->
                    <div class="team-member">
                        <div class="image-wrapper">
                            <img class="img-fluid" src="images/team-2.png" alt="alternative">
                        </div> <!-- end of image wrapper -->
                        <p class="p-large">Veronique Smith</p>
                        <p class="job-title">Business Developer</p>
                        <span class="social-icons">
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-facebook-f fa-stack-1x"></i>
                                </a>
                            </span>
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-twitter fa-stack-1x"></i>
                                </a>
                            </span>
                        </span>
                    </div> <!-- end of team-member -->
                    <!-- end of team member -->

                    <!-- Team Member -->
                    <div class="team-member">
                        <div class="image-wrapper">
                            <img class="img-fluid" src="images/team-3.png" alt="alternative">
                        </div> <!-- end of image wrapper -->
                        <p class="p-large">Chris Zimerman</p>
                        <p class="job-title">Online Marketer</p>
                        <span class="social-icons">
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-facebook-f fa-stack-1x"></i>
                                </a>
                            </span>
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-twitter fa-stack-1x"></i>
                                </a>
                            </span>
                        </span>
                    </div> <!-- end of team-member -->
                    <!-- end of team member -->

                    <!-- Team Member -->
                    <div class="team-member">
                        <div class="image-wrapper">
                            <img class="img-fluid" src="images/team-4.png" alt="alternative">
                        </div> <!-- end of image wrapper -->
                        <p class="p-large">Mary Villalonga</p>
                        <p class="job-title">Community Manager</p>
                        <span class="social-icons">
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-facebook-f fa-stack-1x"></i>
                                </a>
                            </span>
                            <span class="fa-stack">
                                <a href="#your-link">
                                    <span class="hexagon"></span>
                                    <i class="fab fa-twitter fa-stack-1x"></i>
                                </a>
                            </span>
                        </span>
                    </div> <!-- end of team-member -->
                    <!-- end of team member -->

                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of basic-2 -->
    <!-- end of team -->


    <!-- About -->
    <div id="about" class="counter">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-xl-6">
                    <div class="image-container">
                        <img class="img-fluid" src="images/about.jpg" alt="alternative">
                    </div> <!-- end of image-container -->
                </div> <!-- end of col -->
                <div class="col-lg-7 col-xl-6">
                    <div class="text-container">
                        <div class="section-title">ABOUT</div>
                        <h2>We're Passionate About Delivering Growth Services</h2>
                        <p>Our goal is to provide the right business growth services at the appropriate time so companies can benefit from the created momentum and thrive for a long period of time</p>
                        <ul class="list-unstyled li-space-lg">
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">Everything we recommend has direct positive impact</div>
                            </li>
                            <li class="media">
                                <i class="fas fa-square"></i>
                                <div class="media-body">You will become an important partner of our company</div>
                            </li>
                        </ul>

                        <!-- Counter -->
                        <div id="counter">
                            <div class="cell">
                                <div class="counter-value number-count" data-count="231">1</div>
                                <div class="counter-info">Happy<br>Users</div>
                            </div>
                            <div class="cell">
                                <div class="counter-value number-count" data-count="121">1</div>
                                <div class="counter-info">Issues<br>Solved</div>
                            </div>
                            <div class="cell">
                                <div class="counter-value number-count" data-count="159">1</div>
                                <div class="counter-info">Good<br>Reviews</div>
                            </div>
                        </div>
                        <!-- end of counter -->

                    </div> <!-- end of text-container -->      
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of counter -->
    <!-- end of about -->


    <!-- Contact -->
    <div id="contact" class="form-2">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="text-container">
                        <div class="section-title">CONTACT</div>
                        <h2>Get In Touch Using The Form</h2>
                        <p>You can stop by our office for a cup of coffee and just use the contact form below for any questions and inquiries</p>
                        <ul class="list-unstyled li-space-lg">
                            <li class="address"><i class="fas fa-map-marker-alt"></i>22nd Innovative Street, San Francisco, CA 94043, US</li>
                            <li><i class="fas fa-phone"></i><a href="tel:003024630820">+81 720 22 126</a></li>
                            <li><i class="fas fa-phone"></i><a href="tel:003024630820">+81 720 22 128</a></li>
                            <li><i class="fas fa-envelope"></i><a href="mailto:office@aria.com">office@aria.com</a></li>
                        </ul>
                        <h3>Follow Aria On Social Media</h3>

                        <span class="fa-stack">
                            <a href="#your-link">
                                <span class="hexagon"></span>
                                <i class="fab fa-facebook-f fa-stack-1x"></i>
                            </a>
                        </span>
                        <span class="fa-stack">
                            <a href="#your-link">
                                <span class="hexagon"></span>
                                <i class="fab fa-twitter fa-stack-1x"></i>
                            </a>
                        </span>
                        <span class="fa-stack">
                            <a href="#your-link">
                                <span class="hexagon"></span>
                                <i class="fab fa-pinterest fa-stack-1x"></i>
                            </a>
                        </span>
                        <span class="fa-stack">
                            <a href="#your-link">
                                <span class="hexagon"></span>
                                <i class="fab fa-instagram fa-stack-1x"></i>
                            </a>
                        </span>
                        <span class="fa-stack">
                            <a href="#your-link">
                                <span class="hexagon"></span>
                                <i class="fab fa-linkedin-in fa-stack-1x"></i>
                            </a>
                        </span>
                        <span class="fa-stack">
                            <a href="#your-link">
                                <span class="hexagon"></span>
                                <i class="fab fa-behance fa-stack-1x"></i>
                            </a>
                        </span>
                    </div> <!-- end of text-container -->
                </div> <!-- end of col -->
                <div class="col-lg-6">
                    
                    <!-- Contact Form -->
                    <form id="contactForm" data-toggle="validator" data-focus="false">
                        <div class="form-group">
                            <input type="text" class="form-control-input" id="cname" required>
                            <label class="label-control" for="cname">Name</label>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control-input" id="cemail" required>
                            <label class="label-control" for="cemail">Email</label>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control-textarea" id="cmessage" required></textarea>
                            <label class="label-control" for="cmessage">Your message</label>
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group checkbox">
                            <input type="checkbox" id="cterms" value="Agreed-to-Terms" required>I agree with Aria's stated <a href="privacy-policy.html">Privacy Policy</a> and <a href="terms-conditions.html">Terms Conditions</a> 
                            <div class="help-block with-errors"></div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="form-control-submit-button">SUBMIT MESSAGE</button>
                        </div>
                        <div class="form-message">
                            <div id="cmsgSubmit" class="h3 text-center hidden"></div>
                        </div>
                    </form>
                    <!-- end of contact form -->

                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of form-2 -->
    <!-- end of contact -->


    <!-- Footer -->
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="text-container about">
                        <h4>Few Words About Aria</h4>
                        <p class="white">We're passionate about delivering the best business growth services for companies just starting out as startups or industry players that have established their market position a long tima ago.</p>
                    </div> <!-- end of text-container -->
                </div> <!-- end of col -->
                <div class="col-md-2">
                    <div class="text-container">
                        <h4>Links</h4>
                        <ul class="list-unstyled li-space-lg white">
                            <li>
                                <a class="white" href="#your-link">startupguide.com</a>
                            </li>
                            <li>
                                <a class="white" href="terms-conditions.html">Terms & Conditions</a>
                            </li>
                            <li>
                                <a class="white" href="privacy-policy.html">Privacy Policy</a>
                            </li>
                        </ul>
                    </div> <!-- end of text-container -->
                </div> <!-- end of col -->
                <div class="col-md-2">
                    <div class="text-container">
                        <h4>Tools</h4>
                        <ul class="list-unstyled li-space-lg">
                            <li>
                                <a class="white" href="#your-link">businessgrowth.com</a>
                            </li>
                            <li>
                               <a class="white" href="#your-link">influencers.com</a>
                            </li>
                            <li class="media">
                                <a class="white" href="#your-link">optimizer.net</a>
                            </li>
                        </ul>
                    </div> <!-- end of text-container -->
                </div> <!-- end of col -->
                <div class="col-md-2">
                    <div class="text-container">
                        <h4>Partners</h4>
                        <ul class="list-unstyled li-space-lg">
                            <li>
                                <a class="white" href="#your-link">unicorns.com</a>
                            </li>
                            <li>
                                <a class="white" href="#your-link">staffmanager.com</a>
                            </li>
                            <li>
                                <a class="white" href="#your-link">association.gov</a>
                            </li>
                        </ul>
                    </div> <!-- end of text-container -->
                </div> <!-- end of col -->
            </div> <!-- end of row -->
        </div> <!-- end of container -->
    </div> <!-- end of footer -->  
    <!-- end of footer -->


    <!-- Copyright -->
    <div class="copyright">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <p class="p-small">Copyright © 2020 <a href="https://inovatik.com">Template by Inovatik</a></p>
                </div> <!-- end of col -->
            </div> <!-- enf of row -->
        </div> <!-- end of container -->
    </div> <!-- end of copyright --> 
    <!-- end of copyright -->
    
    	
    <!-- Scripts -->
    <script src="js/bootstrap.min.js"></script> <!-- Bootstrap framework -->
    <script src="js/swiper.min.js"></script> <!-- Swiper for image and text sliders -->
    <script src="js/jquery.magnific-popup.js"></script> <!-- Magnific Popup for lightboxes -->
    <script src="js/morphext.min.js"></script> <!-- Morphtext rotating text in the header -->
    <script src="js/isotope.pkgd.min.js"></script> <!-- Isotope for filter -->
    <script src="js/validator.min.js"></script> <!-- Validator.js - Bootstrap plugin that validates forms -->
    <script src="js/scripts.js"></script> <!-- Custom scripts -->
    <script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
     <script type="text/javascript">
         $(function () {
             $('.navbar ul li a.search').on('click', function (e) {
                 e.preventDefault();
             });
         })
      </script>
</body>
</html>