package com.cp.tms.model.schedule;

import java.util.List;

import com.cp.tms.dto.OnedayDto;

public interface IOneDayService {
	public boolean writeOneday(OnedayDto dto);
	public boolean modifyOneday(OnedayDto dto);
	public boolean delOneday(String seq);
	public List<OnedayDto> selDetailOneday(String seq);
	public List<OnedayDto> noteCollectOnedayAP(String note_seq);
}
