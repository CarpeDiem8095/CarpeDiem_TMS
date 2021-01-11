<%@page import="com.cp.tms.dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.cp.tms.usebean.CalendarInputData"%>
<%@page import="com.cp.tms.model.schedule.*"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 달력</title>
<style type="text/css">
	#calendar {
    border: 1px solid #ccc;
    border-collapse: collapse;
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
	<h3>일정 달력</h3>
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
		ICalendarDao dao = new CalendarDaoImpl();
				
		// yyyymm
		System.out.printf("year, month : %s, %s", year, month);
		String yyyymm = year + CalendarInputData.twoDigits(String.valueOf(month));
	%>
	
	<div id="container">
		<table id="calendar">
			<caption>
				<a href="./calendar.do?year=<%=year-1%>&month=<%=month%>">&#8810;</a>
				<a href="./calendar.do?year=<%=year%>&month=<%=month-1%>">&lt;</a>&nbsp;
				<span class="y"><%=year%></span>년도&nbsp;
				<span class="m"><%=month%></span>월&nbsp;
				<a href="./calendar.do?year=<%=year%>&month=<%=month+1%>">&gt;</a>
				<a href="./calendar.do?year=<%=year+1%>&month=<%=month%>">&#8811;</a>
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
		    		<!-- 해당 년도 월 일에 해당하는 글을 출력, 글자수 제한(...표시) -->
		    		<div class="clist"></div>
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
	</div>
</body>
</html>