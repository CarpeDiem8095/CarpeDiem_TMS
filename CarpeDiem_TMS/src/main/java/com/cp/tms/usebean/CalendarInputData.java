package com.cp.tms.usebean;

import java.util.List;

import com.cp.tms.dto.NoteDto;
import com.cp.tms.dto.OnedayDto;

public class CalendarInputData {

	// 한 자리의 숫자를 두 자리로 변경
	public static String twoDigits(String month) {
		return (month.length()<2?("0"+month):month);
	}
	
	// 요일별 색 지정
	// 일요일 빨강, 평일 검정, 토요일 파랑
	public static String fontColor(int date, int dayOfWeek) {
		int dayCal = (dayOfWeek-1+date)%7;
		if (dayCal == 1) {
			return "red";
		} else if (dayCal == 0) {
			return "blue";
		} else {
			return "white";
		}
	}
	
	public static String getCalView(int year, int month, int i, List<NoteDto> clist, String noteSeq) {
		String res = "";
		
		String getYear =Integer.toString(year);
		String getMonth =Integer.toString(month);
		String getI =Integer.toString(i);
		
		String conMonth = "";
		String conI = "";
		
		if(getMonth.length() == 1) {
			conMonth = "0"+getMonth;
		}else {
			conMonth = getMonth;
		}
		
		if(getI.length() == 1) {
			conI = "0"+getI;
		}else {
			conI = getI;
		}
		
		String compairDate = getYear+"-"+conMonth+"-"+conI;

		for(NoteDto dto : clist) {
			
			for(OnedayDto oneDto : dto.getOdto()) {
				if(oneDto.getOnedate().substring(0,10).trim().equals(compairDate)) {
					
					System.out.println("달력에 들어간 일정 : "+oneDto.getOnedate().substring(0,10).trim());
					
					StringBuffer sb = new StringBuffer();
					sb.append("<div class='checkOneday'>");
					sb.append("<a href='./insertPlacePage.do?seq="+oneDto.getOneday_seq()+"&noteSeq="+noteSeq+"&selDate="+compairDate+"'>"+oneDto.getOneday_title()+"</a>");
					sb.append("<input type = 'button' value='X' style='float: right;' class='btn-delete' onclick='delOneday("+oneDto.getOneday_seq()+")'>");
					sb.append("<input type = 'button' value='수정' onclick='modifyOneday("+oneDto.getOneday_seq()+")' class='btn-modify' style='text-align: center; float: right;'>");
					sb.append("</div>");
					res+=sb.toString();
				}
			}
		}
		return res;
	}
}
