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
<%@include file="../header/TMS_header.jsp" %>
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
      
      
      function signOut(){
    	  var auth2 = gapi.auth2.getAuthInstance();
    	  auth2.SignOut().then(function(){
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
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img class="d-block w-100" src="images/slide1.jpg"
							alt="slider_img">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/about.jpg" alt="slider_img">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/slide1.jpg"
							alt="slider_img">
						<div class="ovarlay_slide_cont"></div>
					</div>
					<a class="carousel-control-prev" href="#main_slider" role="button"
						data-slide="prev"> <img src="images/left.png" />
					</a> <a class="carousel-control-next" href="#main_slider" role="button"
						data-slide="next"> <img src="images/right.png" />
					</a>
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
				<td class="mychatname">${fn:substring(myChatLists.chatyourid,0,fn:indexOf(myChatLists.chatyourid,'@')+1)}${fn:toUpperCase(fn:substring(myChatLists.chatyourid,fn:indexOf(myChatLists.chatyourid,'@')+1,fn:indexOf(myChatLists.chatyourid,'@')+2))}</td>
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
	<div id="details" class="accordion">
		<div class="area-1"></div>
		<!-- end of area-1 on same line and no space between comments to eliminate margin white space -->
		<div class="area-2">

			<!-- Accordion -->
			<div class="accordion-container" id="accordionOne">
				<h2>Accelerate Business Growth To Improve Revenue Numbers</h2>
				<div class="item">
					<div id="headingOne">
						<span data-toggle="collapse" data-target="#collapseOne"
							aria-expanded="true" aria-controls="collapseOne" role="button">
							<span class="circle-numbering">1</span><span
							class="accordion-title">How Can Aria Help Your Business</span>
						</span>
					</div>
					<div id="collapseOne" class="collapse show"
						aria-labelledby="headingOne" data-parent="#accordionOne">
						<div class="accordion-body">At Aria solutions, we’ve taken
							the consultancy concept one step further by offering a full
							service management organization with expertise.</div>
					</div>
				</div>
				<!-- end of item -->

				<div class="item">
					<div id="headingTwo">
						<span class="collapsed" data-toggle="collapse"
							data-target="#collapseTwo" aria-expanded="false"
							aria-controls="collapseTwo" role="button"> <span
							class="circle-numbering">2</span><span class="accordion-title">Great
								Strategic Business Planning</span>
						</span>
					</div>
					<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
						data-parent="#accordionOne">
						<div class="accordion-body">Aria partners with businesses to
							business growth and development ideas including environment
							analysis, plan execution and evaluation.</div>
					</div>
				</div>
				<!-- end of item -->

				<div class="item">
					<div id="headingThree">
						<span class="collapsed" data-toggle="collapse"
							data-target="#collapseThree" aria-expanded="false"
							aria-controls="collapseThree" role="button"> <span
							class="circle-numbering">3</span><span class="accordion-title">Online
								Marketing Campaigns</span>
						</span>
					</div>
					<div id="collapseThree" class="collapse"
						aria-labelledby="headingThree" data-parent="#accordionOne">
						<div class="accordion-body">An awesome online marketing plan
							won't save your bad product but paired with a good product, the
							sky is the limit for what can be achieved.</div>
					</div>
				</div>
				<!-- end of item -->
			</div>
			<!-- end of accordion-container -->
			<!-- end of accordion -->

		</div>
		<!-- end of area-2 -->
	</div>
	<!-- end of accordion -->
	<!-- end of details 1 -->


	<!-- Details 2 -->
	<div class="tabs">
		<div class="area-1">
			<div class="tabs-container">

				<!-- Tabs Links -->
				<ul class="nav nav-tabs" id="ariaTabs" role="tablist">
					<li class="nav-item"><a class="nav-link active" id="nav-tab-1"
						data-toggle="tab" href="#tab-1" role="tab" aria-controls="tab-1"
						aria-selected="true"><i class="fas fa-th"></i> Business</a></li>
					<li class="nav-item"><a class="nav-link" id="nav-tab-2"
						data-toggle="tab" href="#tab-2" role="tab" aria-controls="tab-2"
						aria-selected="false"><i class="fas fa-th"></i> Expertise</a></li>
					<li class="nav-item"><a class="nav-link" id="nav-tab-3"
						data-toggle="tab" href="#tab-3" role="tab" aria-controls="tab-3"
						aria-selected="false"><i class="fas fa-th"></i> Quality</a></li>
				</ul>
				<!-- end of tabs links -->

				<!-- Tabs Content -->
				<div class="tab-content" id="ariaTabsContent">

					<!-- Tab -->
					<div class="tab-pane fade show active" id="tab-1" role="tabpanel"
						aria-labelledby="tab-1">
						<h4>Business Services For Companies</h4>
						<p>
							Aria provides the most innovative and customized business
							services in the industry. Our <a class="green page-scroll"
								href="#services">Services</a> section shows how flexible we are
							for all types of budgets.
						</p>

						<!-- Progress Bars -->
						<div class="progress-container">
							<div class="title">Business Development 100%</div>
							<div class="progress">
								<div class="progress-bar first" role="progressbar"
									aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<div class="title">Opportunity Spotting 76%</div>
							<div class="progress">
								<div class="progress-bar second" role="progressbar"
									aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<div class="title">Online Marketing 90%</div>
							<div class="progress">
								<div class="progress-bar third" role="progressbar"
									aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>
						<!-- end of progress-container -->
						<!-- end of progress bars -->

					</div>
					<!-- end of tab-pane -->
					<!-- end of tab -->

					<!-- Tab -->
					<div class="tab-pane fade" id="tab-2" role="tabpanel"
						aria-labelledby="tab-2">
						<ul class="list-unstyled li-space-lg first">
							<li class="media">
								<div class="media-bullet">1</div>
								<div class="media-body">
									<strong>High quality</strong> is on top of our list when it
									comes to the way we deliver the services
								</div>
							</li>
							<li class="media">
								<div class="media-bullet">2</div>
								<div class="media-body">
									<strong>Maximum impact</strong> is what we look for in our
									actions
								</div>
							</li>
							<li class="media">
								<div class="media-bullet">3</div>
								<div class="media-body">
									<strong>Quality standards</strong> are important but meant to
									be exceeded
								</div>
							</li>
						</ul>
						<ul class="list-unstyled li-space-lg last">
							<li class="media">
								<div class="media-bullet">4</div>
								<div class="media-body">
									<strong>We're always looking</strong> for industry leaders to
									help them win their market position
								</div>
							</li>
							<li class="media">
								<div class="media-bullet">5</div>
								<div class="media-body">
									<strong>Evaluation</strong> is a key aspect of this business
									and important
								</div>
							</li>
							<li class="media">
								<div class="media-bullet">6</div>
								<div class="media-body">
									<strong>Ethic</strong> procedures ar alwasy at the base of
									everything we do
								</div>
							</li>
						</ul>
					</div>
					<!-- end of tab-pane -->
					<!-- end of tab -->

					<!-- Tab -->
					<div class="tab-pane fade" id="tab-3" role="tabpanel"
						aria-labelledby="tab-3">
						<p>
							<strong>We strive to achieve</strong> 100% customer satisfaction
							for both types of customers: hiring companies and job seekers.
							Types of customers: <a class="green" href="#your-link">with
								huge potential</a>
						</p>
						<p>
							<strong>Our goal is to help</strong> your company achieve its
							full potential and establish long term stability for <a
								class="green" href="#your-link">the stakeholders</a>
						</p>
						<ul class="list-unstyled li-space-lg">
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">It's easy to get a quotation, just
									call our office anytime</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">We'll get back to you with an
									initial estimate soon</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">Get ready to see results even
									after only 30 days</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">Ask for a quote and start
									improving your business</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">Just fill out the form and we'll
									call you right away</div></li>
						</ul>
					</div>
					<!-- end of tab-pane -->
					<!-- end of tab -->

				</div>
				<!-- end of tab-content -->
				<!-- end of tabs content -->

			</div>
			<!-- end of tabs-container -->
		</div>
		<!-- end of area-1 on same line and no space between comments to eliminate margin white space -->
		<div class="area-2"></div>
		<!-- end of area-2 -->
	</div>
	<!-- end of tabs -->
	<!-- end of details 2 -->

	<!-- Call Me -->
	<div id="callMe" class="form-1">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="text-container">
						<div class="section-title">CALL ME</div>
						<h2 class="white">Have Us Contact You By Filling And
							Submitting The Form</h2>
						<p class="white">You are just a few steps away from a
							personalized offer. Just fill in the form and send it to us and
							we'll get right back with a call to help you decide what service
							package works.</p>
						<ul class="list-unstyled li-space-lg white">
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">It's very easy just fill in the
									form so we can call</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">During the call we'll require some
									info about the company</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">Don't hesitate to email us for any
									questions or inquiries</div></li>
						</ul>
					</div>
				</div>
				<!-- end of col -->
				<div class="col-lg-6">

					<!-- Call Me Form -->
					<form id="callMeForm" data-toggle="validator" data-focus="false">
						<div class="form-group">
							<input type="text" class="form-control-input" id="lname"
								name="lname" required> <label class="label-control"
								for="lname">Name</label>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<input type="text" class="form-control-input" id="lphone"
								name="lphone" required> <label class="label-control"
								for="lphone">Phone</label>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<input type="email" class="form-control-input" id="lemail"
								name="lemail" required> <label class="label-control"
								for="lemail">Email</label>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<select class="form-control-select" id="lselect" required>
								<option class="select-option" value="" disabled selected>Interested
									in...</option>
								<option class="select-option" value="Off The Ground">Off
									The Ground</option>
								<option class="select-option" value="Accelerated Growth">Accelerated
									Growth</option>
								<option class="select-option" value="Market Domination">Market
									Domination</option>
							</select>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group checkbox white">
							<input type="checkbox" id="lterms" value="Agreed-to-Terms"
								name="lterms" required>I agree with Aria's stated <a
								class="white" href="privacy-policy.html">Privacy Policy</a> and
							<a class="white" href="terms-conditions.html">Terms &
								Conditions</a>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<button type="submit" class="form-control-submit-button">CALL
								ME</button>
						</div>
						<div class="form-message">
							<div id="lmsgSubmit" class="h3 text-center hidden"></div>
						</div>
					</form>
					<!-- end of call me form -->

				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
		</div>
		<!-- end of container -->
	</div>
	<!-- end of form-1 -->
	<!-- end of call me -->


	<!-- Projects -->
	<div id="projects" class="filter">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">PROJECTS</div>
					<h2>Projects That We're Proud Of</h2>
				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
			<div class="row">
				<div class="col-lg-12">
					<!-- Filter -->
					<div class="button-group filters-button-group">
						<a class="button is-checked" data-filter="*"><span>SHOW
								ALL</span></a> <a class="button" data-filter=".design"><span>DESIGN</span></a>
						<a class="button" data-filter=".development"><span>DEVELOPMENT</span></a>
						<a class="button" data-filter=".marketing"><span>MARKETING</span></a>
						<a class="button" data-filter=".seo"><span>SEO</span></a>
					</div>
					<!-- end of button group -->
					<div class="grid">
						<div class="element-item development">
							<a class="popup-with-move-anim" href="#project-1"><div
									class="element-item-overlay">
									<span>Online Banking</span>
								</div>
								<img src="images/project-1.jpg" alt="alternative"></a>
						</div>
						<div class="element-item development">
							<a class="popup-with-move-anim" href="#project-2"><div
									class="element-item-overlay">
									<span>Classic Industry</span>
								</div>
								<img src="images/project-2.jpg" alt="alternative"></a>
						</div>
						<div class="element-item design development marketing">
							<a class="popup-with-move-anim" href="#project-3"><div
									class="element-item-overlay">
									<span>BoomBap Audio</span>
								</div>
								<img src="images/project-3.jpg" alt="alternative"></a>
						</div>
						<div class="element-item design development marketing">
							<a class="popup-with-move-anim" href="#project-4"><div
									class="element-item-overlay">
									<span>Van Moose</span>
								</div>
								<img src="images/project-4.jpg" alt="alternative"></a>
						</div>
						<div class="element-item design development marketing seo">
							<a class="popup-with-move-anim" href="#project-5"><div
									class="element-item-overlay">
									<span>Joy Moments</span>
								</div>
								<img src="images/project-5.jpg" alt="alternative"></a>
						</div>
						<div class="element-item design marketing seo">
							<a class="popup-with-move-anim" href="#project-6"><div
									class="element-item-overlay">
									<span>Spark Events</span>
								</div>
								<img src="images/project-6.jpg" alt="alternative"></a>
						</div>
						<div class="element-item design marketing">
							<a class="popup-with-move-anim" href="#project-7"><div
									class="element-item-overlay">
									<span>Casual Wear</span>
								</div>
								<img src="images/project-7.jpg" alt="alternative"></a>
						</div>
						<div class="element-item design marketing">
							<a class="popup-with-move-anim" href="#project-8"><div
									class="element-item-overlay">
									<span>Zazoo Apps</span>
								</div>
								<img src="images/project-8.jpg" alt="alternative"></a>
						</div>
					</div>
					<!-- end of grid -->
					<!-- end of filter -->

				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
		</div>
		<!-- end of container -->
	</div>
	<!-- end of filter -->
	<!-- end of projects -->


	<!-- Project Lightboxes -->
	<!-- Lightbox -->
	<div id="project-1" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-1.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Online Banking</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-2" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-2.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Classic Industry</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-3" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-3.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>BoomBap Audio</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-4" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-4.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Van Moose</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-5" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-5.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Joy Moments</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-6" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-6.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Spark Events</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-7" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-7.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Casual Wear</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->

	<!-- Lightbox -->
	<div id="project-8" class="lightbox-basic zoom-anim-dialog mfp-hide">
		<div class="row">
			<button title="Close (Esc)" type="button" class="mfp-close x-button">×</button>
			<div class="col-lg-8">
				<img class="img-fluid" src="images/project-8.jpg" alt="alternative">
			</div>
			<!-- end of col -->
			<div class="col-lg-4">
				<h3>Zazoo Apps</h3>
				<hr class="line-heading">
				<h6>Strategy Development</h6>
				<p>Need a solid foundation for your business growth plans? Aria
					will help you manage sales and meet your current needs</p>
				<p>By offering the best professional services and quality
					products in the market. Don't hesitate and get in touch with us.</p>
				<div class="testimonial-container">
					<p class="testimonial-text">Need a solid foundation for your
						business growth plans? Aria will help you manage sales and meet
						your current requirements.</p>
					<p class="testimonial-author">General Manager</p>
				</div>
				<a class="btn-solid-reg" href="#your-link">DETAILS</a> <a
					class="btn-outline-reg mfp-close as-button" href="#projects">BACK</a>
			</div>
			<!-- end of col -->
		</div>
		<!-- end of row -->
	</div>
	<!-- end of lightbox-basic -->
	<!-- end of lightbox -->
	<!-- end of project lightboxes -->


	<!-- Team -->
	<div class="basic-2">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2>Our Team Of Consultants</h2>
					<p class="p-heading">We're only as strong and as knowledgeable
						as our team. So here are the men and women which help customers
						meet goals and grow companies</p>
				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
			<div class="row">
				<div class="col-lg-12">

					<!-- Team Member -->
					<div class="team-member">
						<div class="image-wrapper">
							<img class="img-fluid" src="images/team-1.png" alt="alternative">
						</div>
						<!-- end of image-wrapper -->
						<p class="p-large">John Whitelong</p>
						<p class="job-title">General Manager</p>
						<span class="social-icons"> <span class="fa-stack">
								<a href="#your-link"> <span class="hexagon"></span> <i
									class="fab fa-facebook-f fa-stack-1x"></i>
							</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
									class="hexagon"></span> <i class="fab fa-twitter fa-stack-1x"></i>
							</a>
						</span>
						</span>
					</div>
					<!-- end of team-member -->
					<!-- end of team member -->

					<!-- Team Member -->
					<div class="team-member">
						<div class="image-wrapper">
							<img class="img-fluid" src="images/team-2.png" alt="alternative">
						</div>
						<!-- end of image wrapper -->
						<p class="p-large">Veronique Smith</p>
						<p class="job-title">Business Developer</p>
						<span class="social-icons"> <span class="fa-stack">
								<a href="#your-link"> <span class="hexagon"></span> <i
									class="fab fa-facebook-f fa-stack-1x"></i>
							</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
									class="hexagon"></span> <i class="fab fa-twitter fa-stack-1x"></i>
							</a>
						</span>
						</span>
					</div>
					<!-- end of team-member -->
					<!-- end of team member -->

					<!-- Team Member -->
					<div class="team-member">
						<div class="image-wrapper">
							<img class="img-fluid" src="images/team-3.png" alt="alternative">
						</div>
						<!-- end of image wrapper -->
						<p class="p-large">Chris Zimerman</p>
						<p class="job-title">Online Marketer</p>
						<span class="social-icons"> <span class="fa-stack">
								<a href="#your-link"> <span class="hexagon"></span> <i
									class="fab fa-facebook-f fa-stack-1x"></i>
							</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
									class="hexagon"></span> <i class="fab fa-twitter fa-stack-1x"></i>
							</a>
						</span>
						</span>
					</div>
					<!-- end of team-member -->
					<!-- end of team member -->

					<!-- Team Member -->
					<div class="team-member">
						<div class="image-wrapper">
							<img class="img-fluid" src="images/team-4.png" alt="alternative">
						</div>
						<!-- end of image wrapper -->
						<p class="p-large">Mary Villalonga</p>
						<p class="job-title">Community Manager</p>
						<span class="social-icons"> <span class="fa-stack">
								<a href="#your-link"> <span class="hexagon"></span> <i
									class="fab fa-facebook-f fa-stack-1x"></i>
							</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
									class="hexagon"></span> <i class="fab fa-twitter fa-stack-1x"></i>
							</a>
						</span>
						</span>
					</div>
					<!-- end of team-member -->
					<!-- end of team member -->

				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
		</div>
		<!-- end of container -->
	</div>
	<!-- end of basic-2 -->
	<!-- end of team -->


	<!-- About -->
	<div id="about" class="counter">
		<div class="container">
			<div class="row">
				<div class="col-lg-5 col-xl-6">
					<div class="image-container">
						<img class="img-fluid" src="images/about.jpg" alt="alternative">
					</div>
					<!-- end of image-container -->
				</div>
				<!-- end of col -->
				<div class="col-lg-7 col-xl-6">
					<div class="text-container">
						<div class="section-title">ABOUT</div>
						<h2>We're Passionate About Delivering Growth Services</h2>
						<p>Our goal is to provide the right business growth services
							at the appropriate time so companies can benefit from the created
							momentum and thrive for a long period of time</p>
						<ul class="list-unstyled li-space-lg">
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">Everything we recommend has direct
									positive impact</div></li>
							<li class="media"><i class="fas fa-square"></i>
								<div class="media-body">You will become an important
									partner of our company</div></li>
						</ul>

						<!-- Counter -->
						<div id="counter">
							<div class="cell">
								<div class="counter-value number-count" data-count="231">1</div>
								<div class="counter-info">
									Happy<br>Users
								</div>
							</div>
							<div class="cell">
								<div class="counter-value number-count" data-count="121">1</div>
								<div class="counter-info">
									Issues<br>Solved
								</div>
							</div>
							<div class="cell">
								<div class="counter-value number-count" data-count="159">1</div>
								<div class="counter-info">
									Good<br>Reviews
								</div>
							</div>
						</div>
						<!-- end of counter -->

					</div>
					<!-- end of text-container -->
				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
		</div>
		<!-- end of container -->
	</div>
	<!-- end of counter -->
	<!-- end of about -->


	<!-- Contact -->
	<div id="contact" class="form-2">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="text-container">
						<div class="section-title">CONTACT</div>
						<h2>Get In Touch Using The Form</h2>
						<p>You can stop by our office for a cup of coffee and just use
							the contact form below for any questions and inquiries</p>
						<ul class="list-unstyled li-space-lg">
							<li class="address"><i class="fas fa-map-marker-alt"></i>22nd
								Innovative Street, San Francisco, CA 94043, US</li>
							<li><i class="fas fa-phone"></i><a href="tel:003024630820">+81
									720 22 126</a></li>
							<li><i class="fas fa-phone"></i><a href="tel:003024630820">+81
									720 22 128</a></li>
							<li><i class="fas fa-envelope"></i><a
								href="mailto:office@aria.com">office@aria.com</a></li>
						</ul>
						<h3>Follow Aria On Social Media</h3>

						<span class="fa-stack"> <a href="#your-link"> <span
								class="hexagon"></span> <i class="fab fa-facebook-f fa-stack-1x"></i>
						</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
								class="hexagon"></span> <i class="fab fa-twitter fa-stack-1x"></i>
						</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
								class="hexagon"></span> <i class="fab fa-pinterest fa-stack-1x"></i>
						</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
								class="hexagon"></span> <i class="fab fa-instagram fa-stack-1x"></i>
						</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
								class="hexagon"></span> <i
								class="fab fa-linkedin-in fa-stack-1x"></i>
						</a>
						</span> <span class="fa-stack"> <a href="#your-link"> <span
								class="hexagon"></span> <i class="fab fa-behance fa-stack-1x"></i>
						</a>
						</span>
					</div>
					<!-- end of text-container -->
				</div>
				<!-- end of col -->
				<div class="col-lg-6">

					<!-- Contact Form -->
					<form id="contactForm" data-toggle="validator" data-focus="false">
						<div class="form-group">
							<input type="text" class="form-control-input" id="cname" required>
							<label class="label-control" for="cname">Name</label>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<input type="email" class="form-control-input" id="cemail"
								required> <label class="label-control" for="cemail">Email</label>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<textarea class="form-control-textarea" id="cmessage" required></textarea>
							<label class="label-control" for="cmessage">Your message</label>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group checkbox">
							<input type="checkbox" id="cterms" value="Agreed-to-Terms"
								required>I agree with Aria's stated <a
								href="privacy-policy.html">Privacy Policy</a> and <a
								href="terms-conditions.html">Terms Conditions</a>
							<div class="help-block with-errors"></div>
						</div>
						<div class="form-group">
							<button type="submit" class="form-control-submit-button">SUBMIT
								MESSAGE</button>
						</div>
						<div class="form-message">
							<div id="cmsgSubmit" class="h3 text-center hidden"></div>
						</div>
					</form>
					<!-- end of contact form -->

				</div>
				<!-- end of col -->
			</div>
			<!-- end of row -->
		</div>
		<!-- end of container -->
	</div>
	<!-- end of form-2 -->
	<!-- end of contact -->
<%@include file="../footer/TMS_footer.jsp" %>	
</body>
</html>