function del(val) {
	location.href="./delete.do?seq=" + val;
}

function reply(val) {
	location.href="./replyForm.do?seq=" + val;
}

//function modufy(val) {
//	modifyAjax(val);
//	$('#modify').modal();
//}
//
//var modifyAjax = function() {
//	$.ajax({
//		url: ,
//		method: ,
//		data: ,
//		dataType: ,
//		success: ,
//		error: function() {
//			alert("잘못된 요청입니다.");
//		}
//	});
//}