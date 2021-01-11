package com.cp.tms.model.support;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.QuestionDto;

public interface IQuestionDao {

	public List<QuestionDto> userQuestionboardList();

	public List<QuestionDto> adminQuestionboardList();

	public QuestionDto questionDetailBoard(String seq);

	public boolean userWriteQuestionboard(QuestionDto dto);

	public boolean adminWriteQuestionboard(QuestionDto dto);

	public boolean replyQuestionboard(QuestionDto dto);

	public boolean modifyQuestionboard(Map<String, Object> map);

	public boolean modifyQuestionboardAdmin(Map<String, Object> map);

	public boolean deleteQuestionboard(String seq);

	public boolean multiDelQuestionboard(Map<String, String[]> map);
	
}
