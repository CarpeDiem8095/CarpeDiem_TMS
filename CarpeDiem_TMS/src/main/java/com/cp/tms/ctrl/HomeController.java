package com.cp.tms.ctrl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.dto.CalendarDto;
import com.cp.tms.model.schedule.INoteService;
import com.cp.tms.model.schedule.ICalendarService;
import com.cp.tms.usebean.CalendarInputData;

@Controller
public class HomeController {
	
	@Autowired
	INoteService service;
	
	@Autowired
	private ICalendarService calService;

	@RequestMapping(value="hello")
	public String homeController() {
		
		return "hello";
	}
	
	/*
	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String calBoard(Model model) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		String yyyymm = year + CalendarInputData.twoDigits(String.valueOf(month));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("note_seq", "1");
		map.put("yyyymm", yyyymm);
		System.out.println("controller map: "+map);
		
		List<CalendarDto> clists = calService.getCalViewList(map);
		System.out.println("controller clists: "+clists);
		return "calendar";
	}*/
}
