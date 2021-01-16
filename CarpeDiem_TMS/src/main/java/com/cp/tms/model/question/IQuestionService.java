package com.cp.tms.model.question;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.QuestionDto;

public interface IQuestionService {

	// test용 전체글 조회
//	public List<QuestionDto> userQuestionboardList();
//	public List<QuestionDto> adminQuestionboardList();
	
	/**
	 * 전체글 조회(비회원/회원-페이징)
	 * @param map(페이징의 first, last)
	 * @return 페이징된 글 목록
	 */
	public List<QuestionDto> userQuestionboardList(Map<String, Object> map);
	
	/**
	 * 전체조회(관리자-페이징)
	 * @param map(페이징의 first, last)
	 * @return 페이징된 글 목록
	 */
	public List<QuestionDto> adminQuestionboardList(Map<String, Object> map);
	
	/**
	 * 글 개수(비회원/회원)
	 * @return 글 개수
	 */
	public int userTotalCount();
	
	/**
	 * 글 개수(관리자)
	 * @return 글 개수
	 */
	public int adminTotalCount();

	/**
	 * 상세글 조회
	 * @param seq
	 * @return 상세글
	 */
	public QuestionDto questionDetailBoard(String seq);

	/**
	 * 글 입력(비회원/회원)
	 * @param dto(writer, title, content, text_pw)
	 * @return t/f
	 */
	public boolean userWriteQuestionboard(QuestionDto dto);

	/**
	 * 글 입력(관리자)
	 * @param dto(writer, title, content)
	 * @return t/f
	 */
	public boolean adminWriteQuestionboard(QuestionDto dto);

	/**
	 * 답글 입력(관리자)
	 * @param dto(seq, writer, title, content)
	 * @return t/f
	 */
	public boolean replyQuestionboard(QuestionDto dto);

	/**
	 * 글 수정
	 * @param map(seq, title, content)
	 * @return t/f
	 */
	public boolean modifyQuestionboard(Map<String, Object> map);

	/**
	 * 글 수정(관리자)
	 * @param map(seq, title, content)
	 * @return t/f
	 */
	public boolean modifyQuestionboardAdmin(Map<String, Object> map);

	/**
	 * 글 삭제(root글 삭제 시 댓글도 삭제)
	 * @param seq
	 * @return t/f
	 */
	public boolean deleteQuestionboard(String seq);

	/**
	 * 다중삭제(관리자)
	 * @param map(seqs)
	 * @return t/f
	 */
	public boolean multiDelQuestionboard(Map<String, String[]> map);
	
}
