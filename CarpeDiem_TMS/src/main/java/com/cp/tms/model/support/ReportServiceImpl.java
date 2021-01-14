package com.cp.tms.model.support;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.ReportDto;

@Service
public class ReportServiceImpl implements IReportService {

	@Autowired
	private IReportDao dao;
	
	@Override
	public List<ReportDto> reportboardList(Map<String, Object> map) {
		return dao.reportboardList(map);
	}

	@Override
	public int totalCount() {
		return dao.totalCount();
	}

	@Override
	public ReportDto reportDetailBoard(String seq) {
		return dao.reportDetailBoard(seq);
	}

	@Override
	public boolean changeWithdrawal(String email) {
		return dao.changeWithdrawal(email);
	}

	@Override
	public boolean changeProcessingStatus(String seq) {
		return dao.changeProcessingStatus(seq);
	}

}
