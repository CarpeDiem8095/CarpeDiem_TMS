package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.dto.Member;
import com.cp.tms.dto.Paging;
import com.cp.tms.dto.ReportDto;
import com.cp.tms.model.report.IReportService;

@Controller
public class ReportController {

	@Autowired
	private IReportService service;
	
	// 신고처리 게시판으로 이동(전체글 조회-페이징)
	@RequestMapping(value = "/reportBoard.do", method = RequestMethod.GET)
	public String reportBoard(Model model, String page) {
		if (page == null) {
			page = "1";
		}
		
		int selPage = Integer.parseInt(page);
		
		Paging p = new Paging();
		
		// 총 게시글의 수
		p.setTotalCount(service.totalCount());
		
		// 보여줄 게시글의 수
		p.setCountList(3);
				
		// 보여줄 페이지의 수
		p.setCountPage(3);
		
		// 총 페이지의 수
		p.setTotalPage(p.getTotalCount());
		
		// 선택한 페이지
		p.setPage(selPage);
		
		// 시작 페이지
		p.setStartPage(selPage);
		
		// 마지막 페이지
		p.setEndPage(p.getCountPage());
		
//		System.out.println(p);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("first", (p.getPage()-1)*p.getCountList()+1);
		map.put("last", p.getPage()*p.getCountList());
		
		List<ReportDto> rDto = service.reportboardList(map);
		
		model.addAttribute("reDto", rDto);
		model.addAttribute("page", p);
		
		System.out.println("선택된 페이지의 글 목록: "+rDto);
		System.out.println("선택된 페이지의 페이징dto: "+p);
		
		return "reportBoard/reportBoard";
	}
	
	// 상세글 조회
	@RequestMapping(value = "/reportDetail.do", method = RequestMethod.GET)
	public String reportDetail(Model model, String seq) {
		System.out.println("상세글 seq: "+seq);
		ReportDto dto = service.reportDetailBoard(seq);
		System.out.println("상세글 결과값: "+dto);
		model.addAttribute("detail", dto);
		return "reportBoard/reportDetailBoard";
	}
	
	// 신고처리(메일 전송)
	
	
	// 신고처리(탈퇴여부 변경)
	
	
	// 신고처리 완료(처리여부 변경)
	
	
}
