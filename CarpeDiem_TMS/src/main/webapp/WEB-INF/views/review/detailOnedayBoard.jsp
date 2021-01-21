<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="./js/review.js"></script>
</head>
<style type="text/css">
#container {
	width: 650px;
	height: 540px;
	margin: 40px auto;
}

a {
	text-decoration: none;
	vertical-align: -webkit-baseline-middle;
	margin-left: 10px;
}

#map{
	position: absolute;
    left: 1380px;
    top: 140px;
}

.placeTitleCss{
	margin: 0px;
	padding: 0px;
}

.w3-rigth-align{
	float: right;
}

</style>
<body>
<%-- ${oneDto} --%>

<div id="container">
		<h3>하루 일정</h3>
		<div class="w3-show-inline-block">
			<div class="w3-bar w3-light-grey">
				<a href="./selDetailOneday.do?seq=${oneday_seq}" class="w3-bar-item w3-button w3-dark-grey">일정 보기</a> 
				<a href="./onedayTableList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button">일정표 보기</a> 
				<a href="./commnetList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button">댓글 보기</a>
			</div>
		</div> 
			<div class="panel-group" id="accordion">
				<c:forEach var="oneday" items="${selDetailOneday}">
					<div style="font-style:italic; color: red;">${oneday.oneday_title}</div>
					<c:forEach var="p" items="${oneday.placeDto}" varStatus="vs">
					<c:choose>
						<c:when test="${p.step eq '1'}">
						<div>
							<div class="w3-panel w3-black placeTitleCss">
								<button class="w3-btn w3-black">${p.place_name}</button>
								<button class="w3-btn w3-pink w3-rigth-align showMeTheForm">장소후기</button>
								<button class="w3-btn w3-purple w3-rigth-align showMeTheMemo">메모작성</button>
								<input type="hidden" class="this_oneday_seq" value="${p.oneday_seq}">
								<input type="hidden" class="this_place_seq" value="${p.place_seq}">
							</div>
						<div>
							<form class ="fileForm" enctype="multipart/form-data" action="./fileUpload.do" method="post">
								<input type="hidden" name="oneday_seq" value="${oneday_seq}">
								<input type="hidden" name="place_seq" value="${p.place_seq}">
									<div class="revForm" class="w3-container w3-hide">
										<div><input type="file" name="filename" class="uploadFile" accept="image/*" multiple="multiple"></div>
										<div>
											<div class="preview form-control" style="width: 250px; height: 250px; float:left;"></div>
											<div><textarea style="width:400px; height: 250px;" name="content" class="content form-control"></textarea></div>
											
											<div><input type="submit" class="btnSave btn btn-default w3-light-grey w3-hover-blue-grey"  value="SAVE" style="float:right;"/></div>
											<div><input type="button" class="btnReset btn btn-default" value="RESET" onclick="reset();" style="float:right;"/></div>
											<div><input type="button" class="btnModify btn btn-default" value="수정" style="float:right;" onclick="modifyForm('${p.place_seq}')"/></div>
											
										</div>
									</div>
							</form>
						</div>
								<!-- 수정 Modal -->
								<div class="modal fade" id="modifyRev" role="dialog">
									<div class="modal-dialog">

										<!-- 수정 Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
												<h4 class="modal-title"> 후기 수정 </h4>
											</div>
											<div class="modal-body">
												<form action="#" enctype="multipart/form-data" class="form-margin" method="post" id="frmModify"></form>
											</div>
										</div>

									</div>
								</div>

								<!-- 메모추가 부분 -->
							<form>
								<div class="memoForm" class ="w3-container w3-hide" >
									<div>
										<textarea style="width: 650px; height: 200px;" class="memoArea"></textarea>
									</div>
									<div>
										<input type="button" value="메모저장" class="w3-btn w3-purple w3-rigth-align addMemo">
										<input type="hidden" value="${p.place_seq}" class="memo_place_seq">
										<input type="hidden" value="${p.oneday_seq}" class="memo_oneday_seq">
									</div>
								</div>
							</form>	
						</div>
						
						</c:when>
						<c:otherwise>
							<div>
								<div><input type="button" onclick="viewPath(${oneday_seq},${p.place_seq})" value="[길찾기]" class="w3-btn w3-block w3-blue w3-left-align"/></div>
								<div>
								<div class="w3-panel w3-black placeTitleCss">
										<button class="w3-btn w3-black">${p.place_name}</button>
										<button class="w3-btn w3-pink w3-rigth-align showMeTheForm">장소후기</button>
										<button class="w3-btn w3-purple w3-rigth-align showMeTheMemo">메모작성</button>
										<input type="hidden" class="this_oneday_seq" value="${p.oneday_seq}">
										<input type="hidden" class="this_place_seq" value="${p.place_seq}">
								</div>
								<div>
									<form class ="fileForm" enctype="multipart/form-data" action="./fileUpload.do" method="post">
									<input type="hidden" name="oneday_seq" value="${oneday_seq}">
									<input type="hidden" name="place_seq" value="${p.place_seq}">
										
										<div class="revForm" class="w3-container w3-hide">
											<div>
												<input type="file" name="filename" class="uploadFile" accept="image/*"> 
												</div>
											<div>
												<div class="preview form-control" style="width: 250px; height: 250px; float:left;"></div>
												<div><textarea style="width:400px; height: 250px;" name="content" class="content form-control"></textarea></div>
												
												<div><input type="submit" class="btnSave btn btn-default w3-light-grey w3-hover-blue-grey"  value="SAVE" style="float:right;"/></div>
												<div><input type="button" class="btnReset btn btn-default" value="RESET" onclick="reset();" style="float:right;"/></div>
												<div><input type="button" class="btnModify btn btn-default" value="수정" style="float:right;" onclick="modifyForm('${p.place_seq}')"/></div>
											</div>
										</div>
									</form>
								</div>
								
									<!-- 메모추가 부분 -->
									<form>
										<div class="memoForm" class ="w3-container w3-hide" >
											<div>
												<textarea style="width: 650px; height: 200px;" class="memoArea"></textarea>
											</div>
										<div>
											<input type="button" value="메모저장" class="w3-btn w3-purple w3-rigth-align addMemo">
											<input type="hidden" value="${p.place_seq}" class="memo_place_seq">
											<input type="hidden" value="${p.oneday_seq}" class="memo_oneday_seq">
										</div>
										</div>
									</form>							
								</div>
							</div>
						</c:otherwise>
						</c:choose>
								<input type="hidden" name="myTitle" value="${p.place_name}"/>
								<input type="hidden" name="myX" value="${p.xlat}"/>
								<input type="hidden" name="myY" value="${p.ylng}"/>
						</c:forEach>
					</c:forEach>
				</div>
				<div id="map" style="width: 500px; height: 400px; margin: 0px auto;"></div>
			
				</div>
				
</body>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=570bd9d7a1a3fc9dcd12463a4f207e41"></script>
<script>
		var container = document.getElementById('map');
		var x = document.getElementsByName("myX");
		var y = document.getElementsByName("myY");
		
// 		alert(x[0].value);

		var options = {
			center : new kakao.maps.LatLng(33.3766655, 126.542220),
			level : 10
		};

		var map = new kakao.maps.Map(container, options);
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = {
			center : new daum.maps.LatLng(x[0].value, y[0].value), // 지도의 중심좌표
			level : 8
		// 지도의 확대 레벨
		};
		
		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
		var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
		
		var title = document.getElementsByName("myTitle");
// 		alert(title.length);

		//배열 생성
		var latlng = []
		for (var i = 0; i < title.length; i++) {
			latlng.push(new daum.maps.LatLng(x[i].value, y[i].value));
		}

		var iwContent = '<div style="padding:5px;">Hello World!</div>'

		for (var i = 0; i < title.length; i++) {

			// 마커 이미지를 생성합니다    
			var markerImage = new daum.maps.MarkerImage(
			        'https://i1.daumcdn.net/dmaps/apis/n_local_blit_04.png',
			        new kakao.maps.Size(31, 35));
			
			// 마커를 생성합니다
			var marker = new daum.maps.Marker({
				map : map, // 마커를 표시할 지도
				position : new daum.maps.LatLng(x[i].value, y[i].value), // 마커를 표시할 위치
				title : title[i].value,
				image : markerImage
			// 마커 이미지 
			});
			
			var customOverlay = new kakao.maps.CustomOverlay({
			    position: new daum.maps.LatLng(x[i].value, y[i].value),
			    content: '<div style="border: 1px solid black; background-color: white;">'+(i+1+". ")+title[i].value.substring(0,8)+'</div>'
			});
			
		    var infowindow = new kakao.maps.InfoWindow({
		        content: title[i].value // 인포윈도우에 표시할 내용
		    });
		    
			 kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			 kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

			 customOverlay.setMap(map);
		}
		
		var linePath;
		var lineLine = new daum.maps.Polyline();
		var distance;
		var myOrder;
		var cnt = 1;
		
		for (var i = 0; i < title.length; i++) {
			if (i != 0) {
				linePath = [ latlng[i-1], latlng[i] ] //라인을 그리려면 두 점이 있어야하니깐 두 점을 지정했습니다
// 				alert(linePath);
			};
			
			lineLine.setPath(linePath); // 선을 그릴 라인을 세팅합니다
			var drawLine = new daum.maps.Polyline({
				map : map, // 선을 표시할 지도입니다 
				path : linePath,
				strokeWeight : 5, // 선의 두께입니다 
				strokeColor : '#db4040', // 선의 색깔입니다
				strokeOpacity : 2, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
				strokeStyle : 'solid', // 선의 스타일입니다
				endArrow : true
			});

			displayCircleDot(latlng[i]);
		}
		
		function displayCircleDot(position) {
			//console.log(myOrder);
			if (distance > 0) {
				// 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
				var distanceOverlay = new daum.maps.CustomOverlay(
						{
							position : position,
							yAnchor : 1,
							zIndex : 2
						});
				distanceOverlay.setMap(map);
			}
		}
		
		
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
</script>
<script type="text/javascript">
	 function viewPath(onedaySeq, placeSeq){
		 $.ajax({
			 type : "post", 
	         url : "viewPath.do", 
	         data : {"onedaySeq":onedaySeq, "placeSeq":placeSeq},
	         dataType : "json",
	         success : function(json) {
	  			var url = "http://map.daum.net/?sName="+json.firstPName+"&eName="+json.secondPName+"";
	  			var title = "길찾기";
	  			var attr = "width=1200px, height=600px";
	  			var pathControl = window.open(url, title, attr);
	         }
		 })
	 }
	</script>
	 
<script type="text/javascript">
		// 메모 보여주기
		$(".showMeTheMemo").click(function(){
			console.log($(this).parent().parent().find(".memoForm").html());
			
//	 		var memo = $(this).parent().parent().find(".memoArea").val("왜 아작스 처리 후에는 this가 안먹는거지????");
			var memo = $(this).parent().parent().find(".memoArea").val();
			console.log(memo);
			var onedaySeq = $(this).parent().find(".this_oneday_seq").val();
			var placeSeq = $(this).parent().find(".this_place_seq").val();
			$(".revForm").hide();
			
			$(".memoForm").hide();
			$(this).parent().parent().find(".memoForm").slideToggle('slow');
			
			$.ajax({
				type : "post", 
		        url : "showMemo.do",
		        data : {"onedaySeq":onedaySeq, "placeSeq":placeSeq},
		        dataType : "json",
		        success : function(json) {
		        	console.log($(this).parent().parent().find(".memoForm").html());
//	 	        	$(this).parent().parent().find(".memoArea").val(json.memo);
//	 	        	$(this).parent().parent().find(".memoArea").val(json.memo);
		        	
//	 				memo = json.memo;
//	 				console.log(json.memo);
//	 				console.log(memo);
//	 				memo = json.memo;
					$(".memoArea").val(json.memo);
		        }
			});
			return memo;
		});
		
		// 메모 인설트
		$(".addMemo").click(function(){
			var memo = $(this).parent().parent().find(".memoArea").val();
			var placeSeq = $(this).parent().find(".memo_place_seq").val();
			var onedaySeq = $(this).parent().find(".memo_oneday_seq").val();
			console.log(placeSeq);
			console.log(onedaySeq);
			
			$.ajax({
				type : "post", 
		        url : "addMemo.do",
		        data : {"memo":memo, "placeSeq":placeSeq, "onedaySeq":onedaySeq},
		        dataType : "json",
		        success : function(json) {
//	 	        	console.log($(this).parent().parent().find(".memoForm").html());
					$(".memoArea").val(json.memo);
					alert("메모가 추가 되었습니다.");
		        }
			});
		});

		// 리뷰 폼 보이기
		$(document).ready(function() {	
			$(".revForm").hide();
			$(".memoForm").hide();
			
		 });
		
		
		$(".showMeTheForm").click(function(){
			var placeSeq = $(this).parent().find(".this_place_seq");
			//alert(placeSeq);
				if ($(".revForm").is(':visible')) {
					$(".revForm").slideUp('300');
				} else {
					$.ajax({
						type:'get',
						url : 'reviewList.do',
						data : {"place_seq":placeSeq.val()},
						dataType: 'json',
						contentType:'application/json; charset=utf-8',
						success:function(data){
				 			if(data.content != null || data.origin_name !=null){
					        	placeSeq.parent().parent().find(".preview").html("<img src=./uploadFiles/"+data.uuid_name+" style='width: 225px; height: 225px;'>");
					        	placeSeq.parent().parent().find(".content").html(data.content);
					        	placeSeq.parent().parent().find(".btnSave").css("display","none");
					        	placeSeq.parent().parent().find(".btnReset").css("display","none");
					        	placeSeq.parent().parent().find(".uploadFile").css("display","none");
				 			}else{
				 				console.log("====null====");
				 				placeSeq.parent().parent().find(".btnModify").css("display","none");
				 			}
						},
					      error : function(err){
					         alert("잘못된 요청입니다."+err);
					      }
						
					})
				//console.log($(this).parent().parent().find(".revForm").html());
				$(this).parent().parent().find(".revForm").slideToggle('slow');
				}
			});
		
		
		// 등록된 이미지 미리보기 
		$(".uploadFile").on('change', function(){
		    readInputFile(this);
		});


		function readInputFile(input) {
		    if(input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		        	//alert(input);
		            $('.preview').html("<img src="+ e.target.result +" style='width: 225px; height: 225px;'>");
		      }
		        reader.readAsDataURL(input.files[0]);
		    }
		}
</script>

</html>