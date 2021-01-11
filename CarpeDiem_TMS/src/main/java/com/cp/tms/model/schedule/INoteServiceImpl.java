package com.cp.tms.model.schedule;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.NoteDto;

@Service
public class INoteServiceImpl implements INoteService{

	@Autowired
	private NoteDao dao;
	
	@Override
	public boolean writeNote(NoteDto dto) {
//		logger.info("writeNote 실행");
		return dao.writeNote(dto);
	}

	@Override
	public List<NoteDto> selAllNote(String email) {
//		logger.info("selAllNote 실행");
		return dao.selAllNote(email);
	}

	@Override
	public List<NoteDto> selDetailNote(String seq) {
//		logger.info("selDetailNote 실행");
		return dao.selDetailNote(seq);
	}

	@Override
	public boolean modifyNote(NoteDto dto) {
//		logger.info("modifyNote 실행");
		return dao.modifyNote(dto);
	}

	@Override
	public boolean delOneNote(Map<String, Object> map) {
//		logger.info("delOneNote 실행");
		return dao.delOneNote(map);
	}

	@Override
	public boolean delMultiNote(Map<String, Object[]> map) {
//		logger.info("delMultiNote 실행");
		return dao.delMultiNote(map);
	}

	@Override
	public List<NoteDto> selPagingNote(Map<String, Object> map) {
		return dao.selPagingNote(map);
	}

	@Override
	public int countNote() {
		return dao.countNote();
	}
	
}
