package com.cp.tms.model.schedule;

import java.util.List;

import com.cp.tms.dto.OnedayDto;

public interface IOneDayDao {
	//	DTO	Integer
	//	DTO	Integer
	//	String	Integer
	//	-	DTO
	public boolean writeOneday(OnedayDto dto);
	public boolean modifyOneday(OnedayDto dto);
	public boolean delOneday(String seq);
	public List<OnedayDto> selDetailOneday(String seq);
	
}
