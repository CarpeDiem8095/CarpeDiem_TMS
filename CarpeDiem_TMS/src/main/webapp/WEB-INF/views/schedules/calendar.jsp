<%@page import="com.cp.tms.dto.NoteDto"%>
<%@page import="com.cp.tms.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.cp.tms.usebean.CalendarInputData"%>
<%@page import="com.cp.tms.model.schedule.*"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 달력</title>
<style type="text/css">
	#calendar {
    border: 1px solid #ccc;
    border-collapse: collapse;
   	text-align: center;
   	margin: 0px auto;
  }
  
  #calendar th {
    width: 80px;
    border: 1px solid #ccc;
  }
  
  #calendar td {
    width: 150px;
    height: 100px;
    border: 1px solid #ccc;
    text-align: left;
    vertical-align: top;
    position: relative;    
  }
  
  a {
  	text-decoration: none;
  }
</style>
</head>
<body>
<%-- <c:set var="oneday_Seq" value="${seq}"/> --%>
	<%
		// 현재 날짜의 년도와 월
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		
		// 전송받은 값에 따라 현재 달력 또는 요청된 일자로 변경
		String paramYear = request.getParameter("year");
		String paramMonth = request.getParameter("month");
		
		// 요청에 의해 값의 변경이 필요하다면 year, month 재입력
		if (paramYear != null) {
			year = Integer.parseInt(paramYear);
		}
		if (paramMonth != null) {
			month = Integer.parseInt(paramMonth);
		}
		if (month > 12) { // 다음해의 1월로 바꿔줌
			month = 1;
			year++;
		}
		if (month < 1) { // 이전해의 12월로 바꿔줌
			month = 12;
			year--;
		}
		
		// 요청받은 년도와 월로 Calendar 객체 셋팅
		cal.set(year, month-1, 1);
			
		// 매월 1일의 요일
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		// 해당 월의 최대 일수
		int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 달력에 표출한 게시판 데이터를 가져오는 dao
// 		ICalendarDao dao = new CalendarDaoImpl();
		NoteDao dao = new NoteDaoImpl();
				
		String yyyymm = year + CalendarInputData.twoDigits(String.valueOf(month));
		

		
		List<NoteDto> clist = (List<NoteDto>)request.getAttribute("ndto");
		String noteSeq = (String)request.getAttribute("seq");

	%>
	<div id="container">
		<form>
			<table id="calendar">
				<caption>
					<a href="./calendar.do?year=<%=year-1%>&month=<%=month%>&seq=${seq}">&#8810;</a>
					<a href="./calendar.do?year=<%=year%>&month=<%=month-1%>&seq=${seq}">&lt;</a>&nbsp;
					<span class="y"><%=year%></span>년도&nbsp;
					<span class="m"><%=month%></span>월&nbsp;
					<a href="./calendar.do?year=<%=year%>&month=<%=month+1%>&seq=${seq}">&gt;</a>
					<a href="./calendar.do?year=<%=year+1%>&month=<%=month%>&seq=${seq}">&#8811;</a>
				</caption>
				<tr>
			      <th>일</th>
			      <th>월</th>
			      <th>화</th>
			      <th>수</th>
			      <th>목</th>
			      <th>금</th>
			      <th>토</th>
			    </tr>
			    <tr>
			    <%	
			    	// 공백
			    	for (int i=0; i<dayOfWeek-1; i++) {
			    		out.print("<td>&nbsp;</td>");
			    	}
			    
			    	// 달력 출력
			    	for (int i=1; i<=lastDay; i++) {
			    %>
			    	<td id="<%=i%>">
			    		<a href="#" class="countView" style="color:<%=CalendarInputData.fontColor(i, dayOfWeek)%>">&nbsp;<%=i%></a>
			    		<div style="display: none;">
			    			<input type="text" name="selYear" value="<%=year%>">
			    			<input type="text" name="selMonth" value="<%=month%>">
			    		</div>
			    		<div class="clist">
			    		
							<%= CalendarInputData.getCalView(year, month, i, clist, noteSeq) %>
							<% if (CalendarInputData.getCalView(year, month, i, clist, noteSeq).equals("")){
							%>
			    			<input type = "button" value="생성" onclick="writeOneday(${seq},<%=year%>,<%=month%>,<%=i%>)">
							<%
							}
							%>
			    		</div>
			    	</td>
			    	<%
			    		// 마지막 날이 토요일이면 공백 출력X
			    		if ((dayOfWeek-1+i)%7 == 0) {
			    			out.print("</tr><tr>");
			    		}
			    	}
			    	
			    	// 공백
			    	for (int i=0; i<((7-(dayOfWeek-1+lastDay)%7)%7); i++) {
			    		out.print("<td>&nbsp;</td>");
			    	}
			    	%>
			    </tr>
			</table>
		</form>
		<div style="text-align: center;">
			<input type="button" value="뒤로가기" onclick="location.href='./notePaging.do?page=${page}'" style="width: 1072px;">
			<input type = "hidden" value="${seq}" id="noteSeq">
		</div>
		<div style="text-align: center;">
		<c:if test="${fn:length(ndto[0].odto) > 1}">
		<div>
			<input type = "button" value="하루 일정 묶음 조회" onclick="location.href='./NoteCollectOneday.do?note_seq=${seq}&page=${page}'" style="width: 1072px;">
		</div>
		</c:if>
		</div>
	</div>
</body>

<script type="text/javascript">
	function writeOneday(seq, year, month, i){
		var url = "./writeOneDayForm.do?seq="+seq+"&y="+year+"&m="+month+"&d="+i;
		var title = "하루 일정 작성 폼 입니다.";
		var attr = "width=400px, height=200px";
		var wirteOneDay = window.open(url, title, attr);
	}

	function delOneday(seq){
		var noteSeq = document.getElementById("noteSeq").value;
		var selYear= document.getElementsByName("selYear")[0].value;
		var selMonth= document.getElementsByName("selMonth")[0].value;
		
		var delConfirm = confirm('당신의 하루 일정이 삭제됩니다.');
		   if (delConfirm) {
					var form = document.forms[0];
					form.action = "./delOneday.do?seq="+seq+"&noteSeq="+noteSeq+"&year="+selYear+"&month="+selMonth;
					form.method = "post";
					form.submit();
			   }
			   else {
			      alert('삭제가 취소되었습니다.');
			  }
	}
	
	function modifyOneday(onedaySeq){
		var url = "./ModifyOneDayForm.do?onedaySeq="+onedaySeq;
		var title = "하루일정 수정 폼 입니다.";
		var attr = "width=400px, height=200px";
		var wirteOneDay = window.open(url, title, attr);
	}
	
</script>
</html>