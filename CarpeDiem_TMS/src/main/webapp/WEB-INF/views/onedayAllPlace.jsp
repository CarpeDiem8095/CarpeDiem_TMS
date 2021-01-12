<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<c:forEach var="oneday" items="${selDetailOneday}">
			<div>${oneday.oneday_title}</div>
			<c:forEach var="place" items="${oneday.placeDto}">
				<div>${place.place_name}</div>
				<div>${place.xlat}</div>
				<div>${place.ylng}</div>

				<input type="hidden" name="myTitle" value="${place.place_name}"/>
				<input type="hidden" name="myX" value="${place.xlat}"/>
				<input type="hidden" name="myY" value="${place.ylng}"/>

			</c:forEach>
		</c:forEach>
	</div>
	
	<div id="map" style="width: 500px; height: 400px;"></div>
	
</body>
<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=570bd9d7a1a3fc9dcd12463a4f207e41"></script>
	<script>
		var container = document.getElementById('map');
		var x = document.getElementsByName("myX");
		var y = document.getElementsByName("myY");
		
		alert(x[0].value);

		var options = {
			center : new kakao.maps.LatLng(33.3766655, 126.542220),
			level : 1
		};

		var map = new kakao.maps.Map(container, options);
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = {
			center : new daum.maps.LatLng(33.3766655, 126.542220), // 지도의 중심좌표
			level : 10
		// 지도의 확대 레벨
		};
		
		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다 
		var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
		
		var title = document.getElementsByName("myTitle");
		alert(title.length);

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
</html>