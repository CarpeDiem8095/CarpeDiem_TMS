<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하루 일정 조회</title>
</head>
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="./js/pdfmaker/pdfmake.min.js"></script> 
<script src="./js/pdfmaker/vfs_fonts.js"></script>


<style type="text/css">
#container {
	width: 800px;
	height: 540px;
	margin: 40px auto;
}

a {
	text-decoration: none;
	vertical-align: -webkit-baseline-middle;
	margin-left: 10px;
}

.dt-buttons{
	padding: 10px;
}

.dataTables_length{
	float: right;
	margin-left: 20px;
}
</style>
<body>

<div id="container">
<%-- ${onedayList} --%>
 	
 		<h3>하루 일정</h3>
		
<div class="w3-show-inline-block">
	<div class="w3-bar w3-light-grey">
		<a href="./selDetailOneday.do?seq=${oneday_seq}" class="w3-bar-item w3-button">일정 보기</a> 
		<a href="./onedayTableList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button w3-dark-grey">일정표 보기</a> 
		<a href="./commnetList.do?oneday_seq=${oneday_seq}" class="w3-bar-item w3-button">댓글 보기</a>
	</div>
</div> 
<p></p>
<p></p>
<p></p>
<table id="myTable" class="table table-bordered">
	<c:forEach var="oneday" items="${onedayList}">
<thead style="background-color:#607d8b; color: white; text-align: center;">
<tr>
	<th style="text-align: center;">번호</th>
	<th style="text-align: center;">날짜</th>
	<th style="text-align: center;">장소</th>
	<th style="text-align: center;">메모</th>
</tr>
</thead>
<tbody>
		<c:forEach var="p" items="${oneday.placeDto}" varStatus="vs">
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${oneday.onedate}" />
		<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd" var="onedate" />
		
<tr>
	<td>${vs.count}</td>
	<td><c:out value="${onedate}"/></td>
	<td>${p.place_name}</td>
	<td>${p.memo}</td>
</tr>
	</c:forEach>
	</c:forEach>
</tbody>
</table>
</div>
<script type="text/javascript">

$(document).ready(function() {
<%-- 	var oneday_seq = <%=request.getParameter("oneday_seq")%>; --%>
// 	var columns = ["ONEDATE", "PLACE_NAME", "MEMO"];
	$('#myTable_length').hide()
    $('#myTable').DataTable( {
//     	sAjaxSource : "/getDataList.do?oneday_seq="+oneday_seq+"&columns="+columns,
//         sServerMethod: "POST",
//         columns : [
//             {data: "onedate"},
//             {data: "place_name"},
//             {data: "memo"}
//         ],
        dom: 'Blfrtip',
        buttons: [{
        	extend: 'excel',
			text: 'EXCEL 저장',
			filename: '엑셀파일명',
			title: '엑셀파일 안에 쓰일 제목',
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
</script>
</body>
</html>