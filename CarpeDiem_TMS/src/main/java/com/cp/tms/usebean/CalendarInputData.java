package com.cp.tms.usebean;

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
			return "black";
		}
	}
	
}
