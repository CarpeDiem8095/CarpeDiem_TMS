package com.cp.tms.model.schedule;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.NoteDto;

@Repository
public class NoteDaoImpl implements NoteDao{
//	private final Logger logger =  LoggerFactory.getLogger(this.getClass());
	
	private String NS = "note.mapper.";
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public boolean writeNote(NoteDto dto) {
		int cnt = session.insert(NS+"writeNote",dto);
		return cnt>0?true:false;
	}

	@Override
	public List<NoteDto> selAllNote(String email) {
		return session.selectList(NS+"selAllNote", email);
	}

	@Override
	public List<NoteDto> selDetailNote(String seq) {
		return session.selectList(NS+"selDetailNote", seq);
	}

	@Override
	public boolean modifyNote(NoteDto dto) {
		int cnt = session.update(NS+"modifyNote", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean delOneNote(Map<String, Object> map) {
		int cnt = session.update(NS+"delOneNote", map);
		return cnt>0?true:false;
	}

	@Override
	public boolean delMultiNote(Map<String, Object[]> map) {
		int cnt = session.update(NS+"delMultiNote", map);
		return cnt>0?true:false;
	}

	@Override
	public List<NoteDto> selPagingNote(Map<String, Object> map) {
		return session.selectList(NS+"selPagingNote", map);
	}

	@Override
	public int countNote(String email) {
		return session.selectOne(NS+"countNote",email);
	}
	
}
