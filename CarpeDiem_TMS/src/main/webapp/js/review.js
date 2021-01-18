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
//	$(document).ready(function() {	
//		$(".revForm").hide();
//		$(".showMeTheForm").click(function(){
//			$(this).parent().find(".revForm").slideToggle('slow');
//		});
//	 });
	
	
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
	 	