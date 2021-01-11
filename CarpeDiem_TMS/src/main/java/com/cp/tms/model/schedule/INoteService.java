package com.cp.tms.model.schedule;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.NoteDto;

public interface INoteService {
	public boolean writeNote(NoteDto dto);
	public List<NoteDto> selAllNote(String email);
	public List<NoteDto> selDetailNote(String seq);
	public boolean modifyNote(NoteDto dto);
	public boolean delOneNote(Map<String, Object> map);
	public boolean delMultiNote(Map<String, Object[]> map);
	public List<NoteDto> selPagingNote(Map<String, Object> map);
	public int countNote();
}
