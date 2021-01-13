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
					<div class="showMeTheForm" >
						<button class="w3-btn w3-block w3-black w3-left-align">
						${p.place_name}
						</button>
					</div>
				<form enctype="multipart/form-data" method="post">
					<div class="revForm" class="w3-container w3-hide">
						<div><input type="file" id="uploadFile" name="filename" class="uploadFile" accept="image/*"></div>
						<div>
							<div id="preview" style="border: 1px solid black; width: 250px; height: 250px; float:left;"></div>
							<div><textarea style="width:540px; height: 250px;" name="content" id="content"></textarea></div>
							<div><input type="button" id="btnSave" value="save" style="float:right;" onclick=""/></div>
						</div>
					</div>
					</form>
				</div>
				</c:forEach>
			</c:forEach>


		</div>

	</div>
	
	<script type="text/javascript">
	
	// 아작스 
	$(document).ready(function(){
                //ID가 btnSave를 클릭할때
                $("#btnSave").click(function(){
                    //JSON 객체에 값을 담아줌
                    var json = {
                        content : $("#content").val()
                    };
                    
                    //비동기 요청
                     $.ajax({
                        type : "post", 
                        url : "fileUpload.do", 
                        data : json, 
                        dataType : "json",
                        contentType : false, // true=application/x-www-form-urlencoded, false=multipart/form-data
                        processData : false,
                        success : function(data) { //성공시
                        	if(data == "success"){
                				alert("등록이 완료되었습니다.")
                				document.location.href="./boardList.do";
                			}
                		},
 
                        error : function(error) {
                            alert("오류 발생"+ error);
                        }
                    });
                });
            });

	
	// 아코디언 메뉴 롤업
	$(document).ready(function() {	
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
	            $('#preview').html("<img src="+ e.target.result +" style='width: 250px; height: 250px;'>");
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