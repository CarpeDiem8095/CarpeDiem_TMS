package com.cp.tms.model.schedule;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.OnedayDto;

@Service
public class OneDayServiceImpl implements IOneDayService {

	@Autowired
	IOneDayDao dao;
	
	@Override
	public boolean writeOneday(OnedayDto dto) {
		return dao.writeOneday(dto);
	}

	@Override
	public boolean modifyOneday(OnedayDto dto) {
		return dao.modifyOneday(dto);
	}
	@Override
	public boolean delOneday(String seq) {
		return dao.delOneday(seq);
	}

	@Override
	public List<OnedayDto> selDetailOneday(String seq) {
		return dao.selDetailOneday(seq);
	}

	@Override
	public List<OnedayDto> noteCollectOnedayAP(String note_seq) {
		return dao.noteCollectOnedayAP(note_seq);
	}

}
