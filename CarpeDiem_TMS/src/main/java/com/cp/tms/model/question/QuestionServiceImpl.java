package com.cp.tms.model.question;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.QuestionDto;

@Service
public class QuestionServiceImpl implements IQuestionService {

	@Autowired
	private IQuestionDao dao;
	
	// test용 전체글 조회
//	@Override
//	public List<QuestionDto> userQuestionboardList() {
//		return dao.userQuestionboardList();
//	}

//	@Override
//	public List<QuestionDto> adminQuestionboardList() {
//		return dao.adminQuestionboardList();
//	}
	
	// 페이징
	@Override
	public List<QuestionDto> userQuestionboardList(Map<String, Object> map) {
		return dao.userQuestionboardList(map);
	}

	@Override
	public List<QuestionDto> adminQuestionboardList(Map<String, Object> map) {
		return dao.adminQuestionboardList(map);
	}

	@Override
	public int userTotalCount() {
		return dao.userTotalCount();
	}

	@Override
	public int adminTotalCount() {
		return dao.adminTotalCount();
	}
	
	@Override
	public QuestionDto questionDetailBoard(String seq) {
		return dao.questionDetailBoard(seq);
	}

	@Override
	public boolean userWriteQuestionboard(QuestionDto dto) {
		return dao.userWriteQuestionboard(dto);
	}

	@Override
	public boolean adminWriteQuestionboard(QuestionDto dto) {
		return dao.adminWriteQuestionboard(dto);
	}

	@Override
	public boolean replyQuestionboard(QuestionDto dto) {
		return dao.replyQuestionboard(dto);
	}

	@Override
	public boolean modifyQuestionboard(Map<String, Object> map) {
		return dao.modifyQuestionboard(map);
	}

	@Override
	public boolean modifyQuestionboardAdmin(Map<String, Object> map) {
		return dao.modifyQuestionboardAdmin(map);
	}

	@Override
	public boolean deleteQuestionboard(String seq) {
		return dao.deleteQuestionboard(seq);
	}

	@Override
	public boolean multiDelQuestionboard(Map<String, String[]> map) {
		return dao.multiDelQuestionboard(map);
	}

}
