<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하루 일정 조회</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style type="text/css">
#container {
	width: 800px;
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
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="container">
		<h3>하루 일정</h3>
		<div class="panel-group" id="accordion">
			<c:forEach var="oneday" items="${selDetailOneday}">
				<div>${oneday.oneday_title}</div>

				<c:forEach var="p" items="${oneday.placeDto}">
					<div>
						<div class="showMeTheForm">
							<button class="w3-btn w3-block w3-black w3-left-align">
								${p.place_name}</button>
						</div>
						<div></div>
					</div>	
				</c:forEach>
			</c:forEach>


		</div>

	</div>

	<script type="text/javascript">
	// 조회 ajax 
	function selReview(val){
		var place_seq = val;
		alert(place_seq);
		
		$.ajax({
			type:'get',
			url : 'reviewList.do',
			data : {"place_seq":place_seq},
			dataType: 'json',
			contentType:'application/json; charset=utf-8',
			success:function(data){
				alert (data.origin_name);
				html = "<form>"
	 			html += "<div>";
	 			html += "	<input type='hidden' name='place_seq' value='"+data.place_seq+"'>";
				html += "	<div>"+data.origin_name+"</div>";
				html += "	<div>"+data.content+"</div>";
				html += "	<div><img src='Users/EUNSOL/CarpeDiem_TMS_WorkSpace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/"+data.origin_name+"'></div>";
				html += "	<div>";
				html += "		<input type='button' value='수정' onclick='modifyComment()'>";
	        	html += "		<input type='button' value='삭제'>";
	            html += "	</div>";
	        	html += "</div>";
				html += "</form>";
	        	
	 			$('#placeInfo').html(html);
			},
		      error : function(err){
		         alert("잘못된 요청입니다."+err);
		      }
			
		})
	}

	// 아코디언 메뉴 롤업
	$(document).ready(function() {	
		$(".revForm").hide();
		$(".showMeTheForm").click(function(){
			$(".revForm").hide();
			$(this).parent().find(".revForm").slideToggle('slow');
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
</body>
</html>