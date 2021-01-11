package com.cp.tms.model.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.CalendarDto;

@Service
public class CalendarServiceImpl implements ICalendarService {

	@Autowired
	private ICalendarDao dao;
	
	// test용 쿼리
	@Override
	public List<CalendarDto> getCalViewList(Map<String, Object> map) {
		return dao.getCalViewList(map);
	}

}
