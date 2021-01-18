<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>노트의 모든 하루일정 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<style type="text/css">
#container {
	width: 650px;
	height: 540px;
	margin: 40px auto;
}
th {
	text-align: center;
}

a {
	text-decoration: none;
	vertical-align: -webkit-baseline-middle;
	margin-left: 10px;
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
	<div id="container">
		<div class="panel-group" id="accordion">
			<c:forEach var="oneday" items="${oneDto}" varStatus="onedayVs">
				<div class="onedeyTitle">
					<button class="btn-warning w3-block w3-left-align">${oneday.oneday_title}</button>
				</div>
				<c:forEach var="p" items="${oneday.placeDto}" varStatus="placeVs">
				<c:choose>
					<c:when test="${p.step eq '1'}">
					<div>
						<div class="w3-panel w3-black placeTitleCss">
							<button class="w3-btn w3-black">${p.place_name}</button>
							<button class="w3-btn w3-pink w3-rigth-align showMeTheForm">장소후기</button>
							<button class="w3-btn w3-purple w3-rigth-align" onclick="showMeTheMemo(${p.oneday_seq},${p.place_seq})">메모작성</button>
							<%-- <input type="hidden" name="nameP" value="${p.place_name}"> --%>
						</div>
						<form action="./fileUpload.do" method="post">
							<input type="hidden" name="oneday_seq" value="${oneday_seq}">
							<div class="revForm" class="w3-container w3-hide">
								<div><input type="file" id="uploadFile_${p.place_seq}" name="filename" class="uploadFile" accept="image/*"></div>
								<div>
									<div id="preview_${p.place_seq}" style="border: 1px solid black; width: 250px; height: 250px; float:left;"></div>
									<div><input type="text" style="width:400px; height: 250px;" name="content" id="content_${p.place_seq}"></div>
									<div><input type="submit" id="btnSave_${p.place_seq}"  value="save" style="float:right;"/></div>
								</div>
							</div>
						</form>
						<!-- 메모추가 부분 -->
						<form>
							<div class="memoForm">
								<textarea rows="" cols="" style="width: 650px; height: 200px;"></textarea>
								<input type="button" value="메모저장" onclick="addMemo()">
							</div>
						</form>
					</div>
					</c:when>
					<c:otherwise>
						<div>
							<div><input type="button" onclick="viewPath(${p.oneday_seq},${p.place_seq})" value="[길찾기]" class="w3-btn w3-block w3-blue w3-left-align"/></div>
						<div>
						<div class="w3-panel w3-black placeTitleCss"> 
							<button class="w3-btn w3-black">${p.place_name}</button>
							<button class="w3-btn w3-pink w3-rigth-align showMeTheForm">장소후기</button>
							<button class="w3-btn w3-purple w3-rigth-align" onclick="showMeTheMemo(${p.oneday_seq},${p.place_seq})">메모작성</button>
						</div>
								<form action="./fileUpload.do" method="post">
								<input type="hidden" name="oneday_seq" value="${oneday_seq}">
									<div class="revForm" class="w3-container w3-hide">
										<div><input type="file" id="uploadFile_${p.place_seq}" name="filename" class="uploadFile" accept="image/*"></div>
										<div>
											<div id="preview_${p.place_seq}" style="border: 1px solid black; width: 250px; height: 250px; float:left;"></div>
											<div><input type="text" style="width:400px; height: 250px;" name="content" id="content_${p.place_seq}"></div>
											<div><input type="submit" id="btnSave_${p.place_seq}"  value="save" style="float:right;"/></div>
										</div>
									</div>
								</form>
							<!-- 메모추가 부분 -->
							<form>
								<div class="memoForm">
									<textarea rows="" cols="" style="width: 650px; height: 200px;"></textarea>
									<input type="button" value="메모저장" onclick="addMemo()">
								</div>
							</form>
							</div>
						</div>
					</c:otherwise>
					</c:choose>
					</c:forEach>
				</c:forEach>
			</div>
			
			<div class="viewPathOneday">
			
<%-- 				<c:forEach var="p" items="${oneDto[0].placeDto}" varStatus="placeVs"> --%>
<%-- 					<input type="hidden" name="myTitle" value="${p.place_name}"/> --%>
<%-- 					<input type="hidden" name="myX" value="${p.xlat}"/> --%>
<%-- 					<input type="hidden" name="myY" value="${p.ylng}"/> --%>
<%-- 				</c:forEach> --%>
			
			</div>
			<div style="position: absolute; left: 1380px;  top: 40px;">	
				<div id="map" style="width: 500px; height: 400px;"></div>
				<div>
					<c:forEach var="oneday" items="${oneDto}" varStatus="onedayVs"> <!-- 버튼을 클릭하면 얘의 seq로 select태워서 아작스처리 -->
						<button onclick="selectOneDay(${oneday.oneday_seq})">Day${onedayVs.count}</button>
					</c:forEach>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=570bd9d7a1a3fc9dcd12463a4f207e41"></script>
	<script>
		var options = {
			center : new kakao.maps.LatLng(33.3766655, 126.542220),
			level : 10
		};
		var container = document.getElementById('map');
	</script>
	<script type="text/javascript">
	// forData에 담을 요소 
    //ID가 btnSave를 클릭할때 onclick="save(${p.place_seq})
// 	function save(id) {
		
//     	var formData = {};
    	
//     	formData.content = document.getElementById('content_'+id).value;
//     	//formData.filename = document.getElementById('uploadFile_' + id).value;
//     	formData.filename = document.getElementById('uploadFile_' + id).files[0];
//     	console.table(formData);
//         //비동기 요청
//          $.ajax({
//             type : "post", 
//             url : "fileUpload.do", 
//             data : formData, 
//             contentType : 'multipart/form-data', // true=application/x-www-form-urlencoded, false=multipart/form-data
//             processData : false,
//             success : function(data) { //성공시
//             	if(data == "success"){
//     				alert("등록이 완료되었습니다.")
//     				document.location.href="./reviewsList.do";
//     			}
//     		},
//             error : function(error) {
//                 alert("오류 발생"+ error);
//             }
//         });
//     }
	
	// 메모 클릭시 제어
	
	function showMeTheMemo(onedaySeq, placeSeq){
// 		alert(onedaySeq);
// 		alert(placeSeq);
			$.ajax({
			 type : "post", 
	        url : "showMemo.do",
	        data : {"onedaySeq":onedaySeq, "placeSeq":placeSeq},
	        dataType : "json",
	        success : function(json) {
				alert(json.memo);
				alert(json.onedaySeq);
				alert(json.placeSeq);
				
	        }
		});
	}
	
// 	$(".showMeTheMemo").click(function(){
// 		alert('클릭함 ㅎ');
// 		$.ajax({
// 			 type : "post", 
// 	         url : "addMemo.do",
// 	         data : {"onedaySeq":onedaySeq, "placeSeq":placeSeq},
// 	         dataType : "json",
// 	         success : function(json) {
// 	  			var url = "http://map.daum.net/?sName="+json.firstPName+"&eName="+json.secondPName+"";
// 	  			var title = "길찾기";
// 	  			var attr = "width=1200px, height=600px";
// 	  			var pathControl = window.open(url, title, attr);
// 	         }
// 		});
// 	});
	
	// 아코디언 메뉴 롤업
	$(document).ready(function() {	
		$(".revForm").hide();
		$(".showMeTheForm").click(function(){
			$(".revForm").hide();
// 			alert($(this).parent().parent().find(".revForm").val());
			$(this).parent().parent().find(".revForm").slideToggle('slow');
		});
	 });
	
	
	// 등록 된 이미지 미리보기
	function readInputFile(input) {
	    if(input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#preview_${p.place_seq}').html("<img src="+ e.target.result +" style='width: 250px; height: 250px;'>");
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	 
	// 등록된 이미지 바꾸기 
	$(".uploadFile").on('change', function(){
	    readInputFile(this);
	});	
	</script>
	
	<!-- 지도 좌표 아작스 처리 -->
	<script type="text/javascript">
		function selectOneDay(seq){
	         $.ajax({
	         type : "post", 
	         url : "selectOneDay.do", 
	         data : "seq="+seq,
	         dataType : "json",
	         success : function(json) { //성공시
	         
	         	var title = json.A_place_name.split('/');
	         	var x = json.A_xlat.split('/');
	         	var y = json.A_ylng.split('/');
				
	    		var map = new kakao.maps.Map(container, options);
	    		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    		mapOption = {
	    			center : new daum.maps.LatLng(x[0], y[0]), // 지도의 중심좌표
	    			level : 10
	    		// 지도의 확대 레벨
	    		};

	    		
	    		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	    		var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
	    		var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
	    		
//	     		alert(json.size);

	    		//배열 생성
	    		var latlng = []
	    		for (var i = 0; i < json.size; i++) {
	    			latlng.push(new daum.maps.LatLng(x[i], y[i]));
	    		}

	    		var iwContent = '<div style="padding:5px;">Hello World!</div>'

	    		for (var i = 0; i < json.size; i++) {

	    			// 마커 이미지를 생성합니다    
	    			var markerImage = new daum.maps.MarkerImage(
	    			        'https://i1.daumcdn.net/dmaps/apis/n_local_blit_04.png',
	    			        new kakao.maps.Size(31, 35));
	    			
	    			// 마커를 생성합니다
	    			var marker = new daum.maps.Marker({
	    				map : map, // 마커를 표시할 지도
	    				position : new daum.maps.LatLng(x[i], y[i]), // 마커를 표시할 위치
	    				title : title[i],
	    				image : markerImage
	    			// 마커 이미지 
	    			});
	    			
	    			var customOverlay = new kakao.maps.CustomOverlay({
	    			    position: new daum.maps.LatLng(x[i], y[i]),
	    			    content: '<div style="border: 1px solid black; background-color: white;">'+(i+1+". ")+title[i].substring(0,8)+'</div>'
	    			});
	    			
	    		    var infowindow = new kakao.maps.InfoWindow({
	    		        content: title[i] // 인포윈도우에 표시할 내용
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
	    		
	    		for (var i = 0; i < json.size; i++) {
	    			if (i != 0) {
	    				linePath = [ latlng[i-1], latlng[i] ] //라인을 그리려면 두 점이 있어야하니깐 두 점을 지정했습니다
//	     				alert(linePath);
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
	    			console.log(myOrder);
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
	    		
	    		function displayInfowindow(marker){
	    			alert("aa");
	    		}
	         
	 		},
	         error : function(error) {
	             alert("오류 발생"+ error);
	         }
	     });
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
	 
	
</html>