<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 입력 양식</title>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
<form action="./fileUpload.do" enctype="multipart/form-data" method="post">

<div><input type="button" id="showMeTheForm" value="후기"> </div>
<div id="rev_Form">
	<div><input type="file" id="uploadFile" name="filename" class="uploadFile" accept="image/*"></div>
	<div><div id="preview" style="border: 1px solid black; width: 200px; height: 200px;"></div><div><textarea></textarea></div></div>
	<div><input type="submit" value="submit" /></div>
</div>
</form>
<script type="text/javascript">
// 후기 버튼 클릭 시 리뷰 작성 폼 보이기
	$(document).ready(function() {
		$("#rev_Form").hide();
		$("#showMeTheForm").click(function() {
			if ($("#rev_Form").is(':visible')) {
				$("#rev_Form").slideUp(300);
			} else {
				$("#rev_Form").slideDown(300);
			}
		});  
	});
	
	// 등록 된 이미지 미리보기
	function readInputFile(input) {
	    if(input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#preview').html("<img src="+ e.target.result +" style='width: 200px; height: 200px;'>");
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