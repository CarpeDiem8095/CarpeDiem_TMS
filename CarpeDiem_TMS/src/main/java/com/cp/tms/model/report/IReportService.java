package com.cp.tms.model.report;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.ReportDto;

public interface IReportService {

	/**
	 * 전체글 조회(페이징)
	 * @param map(페이징의 first, last)
	 * @return 페이징된 글 목록
	 */
	public List<ReportDto> reportboardList(Map<String, Object> map);
	
	/**
	 * 글 개수
	 * @return 글 개수
	 */
	public int totalCount();
	
	/**
	 * 상세글 조회
	 * @param seq
	 * @return 상세글
	 */
	public ReportDto reportDetailBoard(String seq);
	
	/**
	 * 신고처리(탈퇴여부 변경)
	 * @param email
	 * @return t/f
	 */
	public boolean changeWithdrawal(String email);
	
	/**
	 * 신고처리 완료(처리여부 변경)
	 * @param seq
	 * @return t/f
	 */
	public boolean changeProcessingStatus(String seq);
	
}
