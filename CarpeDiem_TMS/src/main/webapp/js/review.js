// 출력 
$(document).ready(function() {
	
	$('#myTable_length').hide()
    $('#myTable').DataTable( {
        dom: 'Blfrtip',
        buttons: [{
			extend: 'excel',
			text: 'EXCEL 저장',
			filename: '엑셀파일명',
			title: 'title',
			className: 'exportBtn btn btn-default'
		},
        {
        	extend: 'pdf',
            text: 'PDF 저장',
            exportOptions: {
                modifier: {
                    page: 'current'
                }
            },
            footer: true,
            className: 'exportBtn btn btn-default'
        }]
    });
});

// 후기 수정 
function modifyForm(val){
	function getParameterByName(name) {
	    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
 	//alert(val);
 	var seq = getParameterByName('seq'); 
 	//alert(Result);
 	
	ajaxModify(val,seq);
}

var ajaxModify = function(val,seq){
	$.ajax({
		url:'./modifyRevForm.do',
		method : 'post',
		data : {"place_seq":val, "oneday_seq":seq},
		dataType:'json',
		success : function(data){
			html = "<div class='form-group'>";
			html += "<input type='hidden' value='"+data.place_seq+"' name='place_seq'/>";
			html += "<input type='hidden' value='"+data.oneday_seq+"' name='oneday_seq'/>";
	        html += "<label>이미지 첨부</label>";
			html +="<p class='form-control' style='height: 41.5px;'><input type='file' class='uploadFile' id='uploadFile' name='filename' accept='image/*'></p>";
			html += "</div>";
			 
			html += "<div class='form-group'>";
			html += "<label>미리보기</label>";
			html +="<div class='form-control preview' style='width: 300px; height: 300px;'></div>";
			html += "</div>";
			
			html += "<div class='form-group'>";
	        html += "<label for='content'>내용</label>";
			html +="<textarea class='form-control' style='width:564px; height: 250px;' name='content'>"+data.content+"</textarea>";
			html +="</div>";
			
		    html += "<div class='modal-footer'>";
		    html += "<input class='btn btn-default w3-blue-grey' type='button' value='수정' onclick='update()'/>";
		    html += "<input class='btn btn-default' type='button' value='삭제' onclick='delReview("+data.place_seq+","+data.oneday_seq+")' style='float:left;'/>";
		    html += "<button type='button' class='btn btn-default' data-dismiss='modal'>취소</button>";
		    html += "</div>";
		    
			 $('#frmModify').html(html);
			 
			// 등록된 이미지 미리보기 
			 $(".uploadFile").on('change', function(){
			     readInputFile(this);
			 });


			 function readInputFile(input) {
			     if(input.files && input.files[0]) {
			         var reader = new FileReader();
			         reader.onload = function (e) {
			         	//alert(input);
			             $('.preview').html("<img src="+ e.target.result +" style='width: 248px; height: 248px;'>");
			       }
			         reader.readAsDataURL(input.files[0]);
			     }
			 }
		},
	      error: function(){
	          alert("잘못된 요청입니다.");
	      }
	
	})
}

function update(){
//  alert("작동");
  var frm = document.getElementById('frmModify');
  frm.action = './modifyRev.do';
  var preVal = $('#uploadFile').val();
//  alert(preVal);
  if(preVal == null||preVal==''){
	  alert("사진을 첨부해 주세요.");
  }else{
	  frm.submit();
  }
}

function delReview(place_seq,oneday_seq){
	//var frm = document.getElementById('frmModify');
//	alert(place_seq);
//	alert(oneday_seq);
	
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		location.href = "./delReview.do?place_seq="+place_seq+"&oneday_seq="+oneday_seq;
	}else{   //취소
	    return;
	}
}

