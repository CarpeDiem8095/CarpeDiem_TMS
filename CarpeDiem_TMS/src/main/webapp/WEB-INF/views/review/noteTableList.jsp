<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 모아 보기</title>
</head>

<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.2/js/dataTables.buttons.min.js"></script>
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
}
</style>
<body>

<div id="container">
<%-- ${onedayList} --%>
 	
 		<h3>일정 모아보기</h3>
		
<div class="w3-show-inline-block">
	<div class="w3-bar w3-light-grey">
		<a href="./NoteCollectOneday.do?note_seq=${note_seq}&page=${page}" class="w3-bar-item w3-button">일정 보기</a> 
		<a href="./NoteTableList.do?note_seq=${note_seq}&page=${page}" class="w3-bar-item w3-button w3-dark-grey">일정표 보기</a> 
	</div>
</div> 
<p></p>
<p></p>
<p></p>
<table id="myTable" class="table table-bordered">
	<c:forEach var="oneday" items="${noteCollection}" varStatus="onedayVs">
<thead style="background-color:#607d8b; color: white;">
<tr>
	<th>순서</th>
	<th>제목</th>
	<th>날짜</th>
	<th>장소</th>
	<th>메모</th>
</tr>
</thead>
<tbody>
		<c:forEach var="p" items="${oneday.placeDto}" varStatus="placeVs">
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:parseDate var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss.SSS" value="${oneday.onedate}" />
		<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd" var="onedate" />
		
<tr>
	<td>${placeVs.count}</td>
	<td><c:if test="${placeVs.index eq 0}">${oneday.oneday_title}</c:if></td>
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
	$('#myTable_length').hide()
    $('#myTable').DataTable( {
        dom: 'Blfrtip',
        buttons: [{
            extend: 'csvHtml5',
            text: 'Export CSV',
            footer: true,
            className: 'exportBtn btn btn-default'
        },
        {
        	extend: 'pdf',
            text: 'Save current page',
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