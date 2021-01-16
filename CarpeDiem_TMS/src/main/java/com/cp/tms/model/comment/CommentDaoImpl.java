package com.cp.tms.model.comment;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.CommentDto;

@Repository
public class CommentDaoImpl implements ICommentDao {

	private final String NS = "com.cp.tms.dto.CommentDto.";
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<CommentDto> commnetList(String one_seq) {
		return session.selectList(NS+"commnetList", one_seq);
	}

	@Override
	public boolean writeComment(CommentDto dto) {
		int cnt = session.insert(NS+"writeComment", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean updateReply(CommentDto dto) {
		int cnt = session.update(NS+"updateReply", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean writeReply(CommentDto dto) {
		int cnt = session.insert(NS+"writeReply", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean modifyComment(CommentDto dto) {
		int cnt = session.update(NS+"modifyComment", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean delComment(CommentDto dto) {
		int cnt = session.delete(NS+"delComment", dto);
		return cnt>0?true:false;
	}

	@Override
	public CommentDto getOneComment(CommentDto dto) {
		return session.selectOne(NS+"getOneComment", dto);
	}
	
}
