package com.cp.tms.model.support;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.ReportDto;

@Repository
public class ReportDaoImpl implements IReportDao {

	private final String NS = "com.cp.tms.model.support.IReportDao.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 전체글 조회(페이징)
	@Override
	public List<ReportDto> reportboardList(Map<String, Object> map) {
		return sqlSession.selectList(NS+"reportboardList", map);
	}

	// 글 개수
	@Override
	public int totalCount() {
		return sqlSession.selectOne(NS+"totalCount");
	}

	// 상세글 조회
	@Override
	public ReportDto reportDetailBoard(String seq) {
		return sqlSession.selectOne(NS+"reportDetailBoard", seq);
	}

	// 신고처리(탈퇴여부 변경)
	@Override
	public boolean changeWithdrawal(String email) {
		int cnt = sqlSession.update(NS+"changeWithdrawal", email);
		return cnt>0?true:false;
	}

	// 신고처리(처리여부 변경)
	@Override
	public boolean changeProcessingStatus(String seq) {
		int cnt = sqlSession.update(NS+"changeProcessingStatus", seq);
		return cnt>0?true:false;
	}

}
