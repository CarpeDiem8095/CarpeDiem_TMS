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
	// 아코디언 메뉴 롤업
	$(document).ready(function() {	
		$(".revForm").hide();
		$(".showMeTheForm").click(function(){
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
