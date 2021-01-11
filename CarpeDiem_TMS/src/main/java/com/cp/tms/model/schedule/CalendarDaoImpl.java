package com.cp.tms.model.schedule;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.CalendarDto;

@Repository
public class CalendarDaoImpl implements ICalendarDao {

	private final String NS = "com.cp.tms.model.support.ICalendarDao."; 
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// test용 쿼리
	@Override
	public List<CalendarDto> getCalViewList(Map<String, Object> map) {
//		System.out.println("CalendarDaoImpl: "+map);
		return sqlSession.selectList(NS+"getCalViewList", map);
	}

}
