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
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<body>
	<%-- 	${reviewList.revDto} ${reviewList.place_name} --%>
	<div class="panel-group" id="accordion">
		<table class="table table-bordered">
			<c:forEach var="oneday" items="${selDetailOneday}">
				<tr>
					<th>${oneday.oneday_title}</th>
				</tr>

				<c:forEach var="p" items="${oneday.placeDto}" varStatus="vs">

					<tr>
						<td><a href="#">${p.place_name}</a>
						<input type="hidden" value="${p.place_name}" name="place_title"></td>
						<td><input type="button" class="showMeTheForm" value="후기"></td>
					</tr>
					<tr class="rev_Form">
						<td colspan="2" >
						<input type="file" id="uploadFile" name="filename"
							class="uploadFile" accept="image/*"></td>
					</tr>
					<tr>
						<td id="preview"
							style="border: 1px solid black; width: 200px; height: 200px;"></td>
						<td><textarea></textarea></td>
					</tr>
					<tr>
						<td><input type="submit" value="저장" /></td>
					</tr>
				</c:forEach>
			</c:forEach>
		</table>
	</div>
</body>
<script type="text/javascript">
// 후기 버튼 클릭 시 리뷰 작성 폼 보이기


	
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

</script>

</html>