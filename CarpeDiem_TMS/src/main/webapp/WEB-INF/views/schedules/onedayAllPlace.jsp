<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하루 일정 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="./js/review.js"></script>
</head>
<style type="text/css">
#container {
	width: 800px;
	height: 540px;
	margin: 40px auto;
}

a {
	text-decoration: none;
	vertical-align: -webkit-baseline-middle;
	margin-left: 10px;
}
</style>
<body>
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
							<div class="showMeTheForm" >
								<button class="w3-btn w3-block w3-black w3-left-align">
								${p.place_name}
								</button>
								<%-- <input type="hidden" name="nameP" value="${p.place_name}"> --%>
							</div>
							<form enctype="multipart/form-data" action="./fileUpload.do" method="post">
								<input type="hidden" name="oneday_seq" value="${oneday_seq}">
									<div class="revForm" class="w3-container w3-hide">
										<div><input type="file" id="uploadFile_${p.place_seq}" name="filename" class="uploadFile" accept="image/*"></div>
										<div>
											<div id="preview_${p.place_seq}" style="border: 1px solid black; width: 250px; height: 250px; float:left;"></div>
											<div><input type="text" style="width:540px; height: 250px;" name="content" id="content_${p.place_seq}"></div>
											<div><input type="submit" id="btnSave_${p.place_seq}"  value="save" style="float:right;"/></div>
										</div>
									</div>
								</form>
						</div>
						</c:when>
						<c:otherwise>
							<div>
								<div><input type="button" onclick="viewPath(${p.place_name})" value="경로보기"/></div>
								<div>
									<div class="showMeTheForm" >
									<button class="w3-btn w3-block w3-black w3-left-align">
									${p.place_name}
									</button>
									<%-- <input type="hidden" name="nameP" value="${p.place_name}"> --%>
									</div>
									<form enctype="multipart/form-data" action="./fileUpload.do" method="post">
									<input type="hidden" name="oneday_seq" value="${oneday_seq}">
										<div class="revForm" class="w3-container w3-hide">
											<div><input type="file" id="uploadFile_${p.place_seq}" name="filename" class="uploadFile" accept="image/*"></div>
											<div>
												<div id="preview_${p.place_seq}" style="border: 1px solid black; width: 250px; height: 250px; float:left;"></div>
												<div><input type="text" style="width:540px; height: 250px;" name="content" id="content_${p.place_seq}"></div>
												<div><input type="submit" id="btnSave_${p.place_seq}"  value="save" style="float:right;"/></div>
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
			    content: (i+1)+'<br><br><div>'+title[i].value.substring(0,3)+'</div>'
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
	</script>
	<script type="text/javascript">
	 function viewPath(pname){
		 alert(pname);
// 			var url = "https://map.kakao.com/?map_type=TYPE_MAP&target=car&rt=%2C%2C523953%2C1084098&rt1=넥슨코리아본사&rr2="+name+"&rtIds=%2C&rtTypes=%2C"
// 			var title = "길찾기";
// 			var attr = "width=400px, height=200px";
// 		 window.open(url, title, attr);
	 }
	</script>

</html>