package com.cp.tms.model.schedule;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.CalendarDto;

public interface ICalendarDao {

	// test용 쿼리
	public List<CalendarDto> getCalViewList(Map<String, Object> map);
	
}
