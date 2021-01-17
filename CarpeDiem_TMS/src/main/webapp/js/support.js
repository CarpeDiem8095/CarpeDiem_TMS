function del(val) {
	location.href="./delete.do?seq=" + val;
}

function reply(val) {
	location.href="./replyForm.do?seq=" + val;
}

function report(val) {
	location.href="./reportForm.do?seq=" + val;
}

function textPw(val) {
	alert(val);
//	pwCheckAjax(val);
//	$("#textPw").modal();
}

//var pwCheckAjax = function(val) {
//	$.ajax({
//		url: "./txtPwForm.do",
//		type: "post",
//		data: "seq="+val,
//		success: function(c) {
//			 html= "<input type='hidden' value='"+c.seq+"' name='seq'>";
//			html+= "<div class='form-group form-textPw'>";
//			html+= "	<br>";
//			html+= "	<br>";
//			html+= "	<label for='text_pw'>비밀번호</label>";
//			html+= "	<input class='form-control' type='password' id='text_pw' name='text_pw' maxlength='4' required>";
//			html+= "</div>";
//			html+= "<div class='modal-footer' style='text-align: center'>";
//			html+= "	<input class='btn-primary' type='button' value='확인' onclick='checkPw()'/>";
//			html+= "</div>";
//			
//			$("#frmPW").html(html);
//		},
//		error: function() {
//			alert("잘못된 요청입니다.");
//		}
//	});
//}

function modify(val) {
	modifyAjax(val);
	$('#modify').modal();
}

var modifyAjax = function(val) {
	$.ajax({
		url: "./modifyForm.do",
		method: "post",
		data: "seq="+val,
		dataType: "json",
		success: function(v) {
			console.log(v.seq, v.writer, v.title, v.content)
			
			 html = "  <input type='hidden' value='"+v.seq+"' name='seq'>";
			html += "  <div class='form-group'>";
			html += "    <label for='writer'>작성자</label>";
			html += "	 <input class='form-control' type='text' id='writer' name='writer' value='"+v.writer+"' required>";
			html += "  </div>";
			html += "  <div class='form-group'>";
			html += "    <label for='title'>제목</label>";
			html += "	 <input class='form-control' type='text' id='title' name='title' value='"+v.title+"' required>";
			html += "  </div>";
			html += "  <div class='form-group'>";
			html += "    <label for='content'>내용</label>";
			html += "	 <textarea class='form-control' rows='5' id='content' name='content' required>"+v.content+"</textarea>";
			html += "  </div>";
			
			html += "  <div class='modal-footer' style='text-align: center'>";
			html += "    <input class='btn-primary' type='button' value='확인' onclick='update()'/>";
			html += "	 <input class='btn-primary' type='reset' value='초기화'/>";
			html += "  </div>";
			
			$('#frmModify').html(html);
		},
		error: function() {
			alert("잘못된 요청입니다.");
		}
	});
}

function update() {
//	alert("작동");
	var frm = document.getElementById("frmModify");
	frm.action = "./modify.do";
	var title = $('#title').val();
//	alert(title);
	var content = $('#content').val();
//	alert(content);
	if (title == ' ' || content == ' ') {
		swal("수정 오류", "제목과 내용은 필수입니다.");
	} else {
		frm.submit();
	}
}
