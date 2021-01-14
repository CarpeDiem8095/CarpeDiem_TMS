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
	
	// test용 전체글 조회
//	@Override
//	public List<QuestionDto> userQuestionboardList() {
//		return sqlSession.selectList(NS+"userQuestionboardList");
//	}

//	@Override
//	public List<QuestionDto> adminQuestionboardList() {
//		return sqlSession.selectList(NS+"adminQuestionboardList");
//	}
	
	// 전체글 조회(페이징-비회원/회원)
	@Override
	public List<QuestionDto> userQuestionboardList(Map<String, Object> map) {
		return sqlSession.selectList(NS+"userQuestionboardList", map);
	}

	// 전체글 조회(페이징-관리자)
	@Override
	public List<QuestionDto> adminQuestionboardList(Map<String, Object> map) {
		return sqlSession.selectList(NS+"adminQuestionboardList", map);
	}
	
	// 글 개수(비회원, 회원)
	@Override
	public int userTotalCount() {
		return sqlSession.selectOne(NS+"userTotalCount");
	}

	// 글 개수(관리자)
	@Override
	public int adminTotalCount() {
		return sqlSession.selectOne(NS+"adminTotalCount");
	}

	// 상세조회
	@Override
	public QuestionDto questionDetailBoard(String seq) {
		return sqlSession.selectOne(NS+"questionDetailBoard", seq);
	}

	// 글 입력(비회원/회원)
	@Override
	public boolean userWriteQuestionboard(QuestionDto dto) {
		int cnt = sqlSession.insert(NS+"userWriteQuestionboard", dto);
		return cnt>0?true:false;
	}

	// 글 입력(관리자)
	@Override
	public boolean adminWriteQuestionboard(QuestionDto dto) {
		int cnt = sqlSession.insert(NS+"adminWriteQuestionboard", dto);
		return cnt>0?true:false;
	}

	// 답글 입력(관리자)
	@Override
	public boolean replyQuestionboard(QuestionDto dto) {
		int cnt = sqlSession.update(NS+"replyQuestionboard", dto);
		return cnt>0?true:false;
	}

	// 글 수정
	@Override
	public boolean modifyQuestionboard(Map<String, Object> map) {
		int cnt = sqlSession.update(NS+"modifyQuestionboard", map);
		return cnt>0?true:false;
	}

	// 글 수정(관리자)
	@Override
	public boolean modifyQuestionboardAdmin(Map<String, Object> map) {
		int cnt = sqlSession.update(NS+"modifyQuestionboard", map);
		return cnt>0?true:false;
	}

	// 글 삭제(root글 삭제 시 댓글도 삭제)
	@Override
	public boolean deleteQuestionboard(String seq) {
		int cnt = sqlSession.update(NS+"deleteQuestionboard", seq);
		return cnt>0?true:false;
	}

	// 다중삭제(관리자)
	@Override
	public boolean multiDelQuestionboard(Map<String, String[]> map) {
		int cnt = sqlSession.update(NS+"multiDelQuestionboard", map);
		return cnt>0?true:false;
	}

}
