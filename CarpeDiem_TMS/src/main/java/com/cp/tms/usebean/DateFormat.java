package com.cp.tms.usebean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormat {

	@SuppressWarnings("unused")
	private String dateFormat(Date date) {
		SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
		return today.format(date);
	}
	
}
