package com.cp.tms.model.support;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.QuestionDto;

@Repository
public class QuestionDaoImpl implements IQuestionDao {

	private final String NS = "com.cp.tms.model.support.IQuestionDao.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<QuestionDto> userQuestionboardList() {
		return sqlSession.selectList(NS+"userQuestionboardList");
	}

	@Override
	public List<QuestionDto> adminQuestionboardList() {
		return sqlSession.selectList(NS+"adminQuestionboardList");
	}

	@Override
	public QuestionDto questionDetailBoard(String seq) {
		return sqlSession.selectOne(NS+"questionDetailBoard", seq);
	}

	@Override
	public boolean userWriteQuestionboard(QuestionDto dto) {
		int cnt = sqlSession.insert(NS+"userWriteQuestionboard", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean adminWriteQuestionboard(QuestionDto dto) {
		int cnt = sqlSession.insert(NS+"adminWriteQuestionboard", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean replyQuestionboard(QuestionDto dto) {
		int cnt = sqlSession.update(NS+"replyQuestionboard", dto);
		return cnt>0?true:false;
	}

	@Override
	public boolean modifyQuestionboard(Map<String, Object> map) {
		int cnt = sqlSession.update(NS+"modifyQuestionboard", map);
		return cnt>0?true:false;
	}

	@Override
	public boolean modifyQuestionboardAdmin(Map<String, Object> map) {
		int cnt = sqlSession.update(NS+"modifyQuestionboard", map);
		return cnt>0?true:false;
	}

	@Override
	public boolean deleteQuestionboard(String seq) {
		int cnt = sqlSession.update(NS+"deleteQuestionboard", seq);
		return cnt>0?true:false;
	}

	@Override
	public boolean multiDelQuestionboard(Map<String, String[]> map) {
		int cnt = sqlSession.update(NS+"multiDelQuestionboard", map);
		return cnt>0?true:false;
	}

}
