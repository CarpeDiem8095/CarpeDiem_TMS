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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 달력</title>
<%@ include file="/WEB-INF/views/header/TMS_header.jsp" %>
<style type="text/css">
body {
     width: 100%;
}
body {
  background: linear-gradient(to right, rgb(189, 195, 199), rgb(44, 62, 80));
  overflow: hidden;
}

	#calendar {
    border: 1px solid #ccc;
    border-collapse: collapse;
   	text-align: center;
   	margin: 0px auto;
   	margin-top: 150px;
  }
  
  #calendar th {
    width: 80px;
    border: 1px solid #ccc;
  }
  
  #calendar td {
    width: 90px;
    height: 70px;
    border: 1px solid #ccc;
    text-align: left;
    vertical-align: top;
    position: relative;    
  }
  
  a {
  	text-decoration: none;
  }
  
  .checkOneday{
  	text-align: center;
  	color: white;
  	text-shadow: white;
  	text-decoration: underline;
  }
  
  .dayCss{
  	color: white;
  }
  .tableForms{
  }

   .btnBack{
   background-color: #4C3F99;
   	color: white;
   }
   .btnAllOneday{
   background-color:#992064;
   	color: white;
   }
   
	.btn-create{
	background-color: #1E9E68;
	color: white;
	}
	
	.btn-modify{
		background-color: #EB7415;
		color: white;
	}
	
	.btn-delete{
		background-color: #9E265E;
		color: white;
	}
  
  .tiCalendar{
		text-shadow: 0 -1px 4px #6E79CE, 0 -2px 10px #6E79CE, 0 -10px 20px #6E79CE, 0 -18px 40px #6E79CE, 2px 2px 2px rgba(110,121,206,0), 2px 2px 2px rgba(110,121,206,0);
		color: #FFFFFF;
		caption-side : top;
		text-align: center;
		padding: 0px;
  }
  
  a {
	color: #2e00ff;
	text-decoration: underline;
	}
	
</style>
</head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
	<script type="text/javascript">
	//&units=metric을 추가하면 자동으로 섭씨온도로 바꿀 수 있음(원래는 화씨)
	var units = "metric";
	
	// Open weather API request
	// id는 지역 아이디, appid는 apiKey
	$.getJSON('http://api.openweathermap.org/data/2.5/forecast?id=1846265&units='+units+'&APPID=e95d958a11128b11ad3eb0fa101dae38',
		function(json){
		// 현재 일시
		var date = new Date();
		date = moment(date).format('YYYY-MM-DD HH:mm:ss');
		var hours = date.substring(11,13); // 현재 시간(HH)
		
		var year = $('.y').html();
		var month = $('.m').html();
		
		date = date.substring(0,11); // String type -> YYYY-MM-DD 
		hours *= 1; // *=1 -> number로 형변환
		hours = hours-hours%3;
		hours *= ""; // String으로 형변환
		if (hours == "0") {
			hours = "00";
		}
		
		var present = date+hours;
		var jsonPresent = "";
		
		var time = 0;
		for (var i = 0; i < 40; i++) {
			jsonPresent = json.list[i].dt_txt.substring(0,13);
			if (present == jsonPresent) {
				time = i;
				break;
			}
		}
		
		// json 날짜
		var dt_txt = json.list[time].dt_txt; // 일시
		var dt_year = dt_txt.substring(0,4);
		var dt_month = dt_txt.substring(5,7);	
		var dt_day = dt_txt.substring(8,10); //"8"
		dt_day*=1;
		  	
		// 날씨api에서 하루에 3시간씩 8개, 총 5일 제공
		for (var i = 0; i < 5; i++) { // 0 1 2 3 4 => 5번 반복
			if (year == dt_year && "0"+month == dt_month) { // 현재 년월일이 json의 년월일과 같다면 날씨정보를 뿌려준다
				$(".temp").eq(dt_day+i-1).html(Math.round(json.list[time+i*8].main.temp_min)+'&deg;/'+Math.round(json.list[time+i*8].main.temp_max)+'&deg;'); // 최저/최고기온
				if(dt_day+1 <= <%=lastDay%>){
				$(".icon").eq(dt_day+i-1).html("<img src='http://openweathermap.org/img/w/" + json.list[time+i*8].weather[0].icon + ".png'</img>"); // 날씨 아이콘
				}
			}
		}
	});
</script>
	<div id="container" class="flex-contatiner">
		<form>
			<table id="calendar">
				<caption class="tiCalendar">
					<a href="./calendar.do?year=<%=year-1%>&month=<%=month%>&seq=${seq}">◀◀</a>
					<a href="./calendar.do?year=<%=year%>&month=<%=month-1%>&seq=${seq}">◁</a>&nbsp;
					<span class="y"><%=year%></span>년도&nbsp;
					<span class="m"><%=month%></span>월&nbsp;
					<a href="./calendar.do?year=<%=year%>&month=<%=month+1%>&seq=${seq}">▷</a>
					<a href="./calendar.do?year=<%=year+1%>&month=<%=month%>&seq=${seq}">▶▶</a>
				</caption>
				<tr>
			      <th class="dayCss">SUN</th>
			      <th class="dayCss">MON</th>
			      <th class="dayCss">TUE</th>
			      <th class="dayCss">WED</th>
			      <th class="dayCss">THU</th>
			      <th class="dayCss">FRI</th>
			      <th class="dayCss">SAT</th>
			    </tr>
			    <tr class="clist">
			    <%	
			    	// 공백
			    	for (int i=0; i<dayOfWeek-1; i++) {
			    		out.print("<td class='dayCss'>&nbsp;</td>");
			    	}
			    
			    	// 달력 출력
			    	for (int i=1; i<=lastDay; i++) {
			    %>
			    	<td class="tableForms">
			    		<a href="#" class="countView" style="color:<%=CalendarInputData.fontColor(i, dayOfWeek)%>; padding-left: 5px;"><%=i%></a>
			    		<div style="display: none;">
			    			<input type="text" name="selYear" value="<%=year%>">
			    			<input type="text" name="selMonth" value="<%=month%>">
			    		</div>
						<!-- 날씨 -->
			        	<div style="float: right">
				        	<span class="temp" style="color: white;"></span><br>
							<span class="icon"></span>
			        	</div>
			    		<div class="">
							<%= CalendarInputData.getCalView(year, month, i, clist, noteSeq) %>
							<% if (CalendarInputData.getCalView(year, month, i, clist, noteSeq).equals("")){
							%>
			    			<input type = "button" value="생성" onclick="writeOneday(${seq},<%=year%>,<%=month%>,<%=i%>)" class="btn-create">
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
			<input type="button" value="뒤로가기" onclick="location.href='./notePaging.do?page=${page}'" style="width: 633.6px;" class="btnBack">
			<input type = "hidden" value="${seq}" id="noteSeq">
		</div>
		<div style="text-align: center; margin-bottom: 50px;">
		<c:if test="${fn:length(ndto[0].odto) > 1}">
		<div>
			<input type = "button" value="하루 일정 묶음 조회" onclick="location.href='./NoteCollectOneday.do?note_seq=${seq}&page=${page}'" style="width: 633.6px;" class="btnAllOneday">
		</div>
		</c:if>
		</div>
	</div>
<%@ include file="/WEB-INF/views/footer/TMS_footer.jsp" %>	
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