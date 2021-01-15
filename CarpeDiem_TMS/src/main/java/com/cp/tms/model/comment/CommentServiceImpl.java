package com.cp.tms.model.comment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cp.tms.dto.CommentDto;

@Service
public class CommentServiceImpl implements ICommentService {

	@Autowired
	private ICommentDao dao;
	
	@Override
	public List<CommentDto> commnetList(String one_seq) {
		return dao.commnetList(one_seq);
	}

	@Override
	public boolean writeComment(CommentDto dto) {
		return dao.writeComment(dto);
	}

	@Override
	@Transactional
	public boolean reply(CommentDto dto) {
		boolean isc1 = dao.updateReply(dto);
		boolean isc2 = dao.writeReply(dto);
		return (isc1||isc2)?true:false;
	}


	@Override
	public boolean modifyComment(Map<String, Object> map) {
		return dao.modifyComment(map);
	}

	@Override
	public boolean delComment(CommentDto dto) {
		return dao.delComment(dto);
	}


}
