package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.Member;
import com.cp.tms.dto.Paging;
import com.cp.tms.dto.QuestionDto;
import com.cp.tms.dto.ReportDto;
import com.cp.tms.model.question.IQuestionService;
import com.cp.tms.model.report.IReportService;

@Controller
public class QuestionController {

	@Autowired
	private IQuestionService service;
	
	@Autowired
	private IReportService rService;
	
	// 문의 게시판으로 이동(전체 조회)
//	@RequestMapping(value = "/questionBoard.do", method = RequestMethod.GET)
//	public String questionBoard(Model model) {
//		List<QuestionDto> lists = service.userQuestionboardList();
//		model.addAttribute("questionLists", lists);
//		System.out.println(lists);
//		return "questionBoard/questionBoard";
//	}
	
	// 문의 게시판으로 이동(전체 조회-페이징)
	@RequestMapping(value = "/questionBoard.do", method = RequestMethod.GET)
	public String questionBoard(Model model, String page, HttpSession session, String seq) {
//		System.out.println("넘어온 page: "+page);
		
		// 로그인된 사용자 정보
		Member mDto = (Member)session.getAttribute("mDto");
//		System.out.println("session에 담긴 mDto: "+mDto);
		
		if (session.getAttribute("mDto") == null) {
			mDto = new Member();
			mDto.setAuth("U");
		}
		
		List<QuestionDto> qLists = null;
		
		if (page == null) {
			page = "1";
		}
		
		int selPage = Integer.parseInt(page);
//		System.out.println("선택된 페이지: "+selPage);
		
		Paging p = new Paging();
		
		// 총 게시글의 수
//		if (session.getAttribute("mDto") == null) { // 비회원
//			model.addAttribute("mDto.auth", "U");
//			p.setTotalCount(service.userTotalCount());
		if (mDto.getAuth().equalsIgnoreCase("A")) { // 관리자
			p.setTotalCount(service.adminTotalCount());
		} else { // 회원
			p.setTotalCount(service.userTotalCount());
		}
		
		// 보여줄 게시글의 수
		p.setCountList(5);
		
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

		System.out.println(p);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("first", (p.getPage()-1)*p.getCountList()+1);
		map.put("last", p.getPage()*p.getCountList());
//		System.out.println("시작 페이지: "+map.get("first"));
//		System.out.println("마지막 페이지: "+map.get("last"));
		
//		if (session.getAttribute("mDto") == null) {
//			qLists = service.userQuestionboardList(map);
		if (mDto.getAuth().equalsIgnoreCase("A")) { // 관리자
			qLists = service.adminQuestionboardList(map);
		} else { // 회원
			qLists = service.userQuestionboardList(map);		
		}
		model.addAttribute("questionLists", qLists);
		model.addAttribute("page", p);
		if(session.getAttribute("mDto")==null) {
			model.addAttribute("mDto.auth","U");
		}
		System.out.println("선택된 페이지의 글 목록: "+qLists);
//		System.out.println("선택된 페이지의 페이징dto: "+p);
		
		return "questionBoard/questionBoard";
	}
	
	// 다중삭제
	@RequestMapping(value = "/multiDel.do", method = RequestMethod.POST)
	public String multiDel(String[] chkVal) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seqs", chkVal);
		boolean isc = service.multiDelQuestionboard(map);
		System.out.println("다중삭제 성공여부: " + isc);
		return "redirect:/questionBoard.do";
	}
	
	// 상세글 삭제(root글 삭제 시 댓글도 같이 삭제 됨) -> 댓글 삭제 시 root글이 같이 삭제되는 부분 수정해야 함(session에 담을 그릇이 필요해서 memberDto 필요함)
	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public String delete(String seq) {
		boolean isc = service.deleteQuestionboard(seq);
		System.out.println("글 삭제 성공여부: " + isc);
		return "redirect:/questionBoard.do";
	}
	
	// 글 입력 폼으로 이동
	@RequestMapping(value = "/writeForm.do", method = RequestMethod.GET)
	public String writeForm() {
		return "questionBoard/questionWriteForm";
	}
	
	// 글 입력
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public String write(QuestionDto dto, HttpSession session, Model model) {
		Member mDto = (Member)session.getAttribute("mDto");
		
		if (session.getAttribute("mDto") == null) { // 비회원
			model.addAttribute("mDto.auth", "U");
			boolean isc = service.userWriteQuestionboard(dto);
			System.out.println("문의글 입력 성공여부: " + isc);
		} else if (mDto.getAuth().equalsIgnoreCase("A")) {
			boolean isc = service.adminWriteQuestionboard(dto);
			System.out.println("공지글 입력 성공여부: " + isc);
		} else {
			boolean isc = service.userWriteQuestionboard(dto);
			System.out.println("문의글 입력 성공여부: " + isc);
		}
		model.addAttribute("questionLists", dto);
//		model.addAttribute("email", mDto.getEmail());
		System.out.println("questionLists: " + dto);
//		System.out.println("session에 담긴 email: " + mDto.getEmail());
		return "redirect:/questionBoard.do";
	}
	
	// 답글 입력 폼으로 이동
	@RequestMapping(value = "/replyForm.do", method = RequestMethod.GET)
	public String replyForm(Model model, String seq, HttpSession session) {
//		System.out.println(seq);
		// 로그인된 사용자 정보
		Member mDto = (Member)session.getAttribute("mDto");
		// 원본글 정보
		QuestionDto qDto = service.questionDetailBoard(seq);
		
		model.addAttribute("seq", seq);
		model.addAttribute("mDto", mDto);
		model.addAttribute("qDto", qDto);
		System.out.println("원본글 정보: " + qDto);
		return "questionBoard/questionReplyForm";
	}
	
	// 답글 입력
	@RequestMapping(value = "/reply.do", method = RequestMethod.POST)
	public String reply(QuestionDto dto) {
		boolean isc = service.replyQuestionboard(dto);
		System.out.println("dto: " + dto);
		System.out.println("답글 입력 성공여부: " + isc);
		return "redirect:/questionBoard.do";
	}
	
	// 글 수정 폼(modal)으로 이동
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/modifyForm.do", method = RequestMethod.POST, 
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String modifyForm(String seq) {
		// 원본글 정보
		QuestionDto dto = service.questionDetailBoard(seq);
		
		JSONObject json = new JSONObject();
		json.put("seq", dto.getSeq());
		json.put("writer", dto.getWriter());
		json.put("title", dto.getTitle());
		json.put("content", dto.getContent());
//		json.put("qDto", dto);
		System.out.println("선택된 글의 값: "+json.toString());
		
		return json.toString();
	}
	
	// 글 수정
	@RequestMapping(value = "/modify.do", method = RequestMethod.POST)
	public String modify(Model model, String seq, String title, String content) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("seq", seq);
		map.put("title", title);
		map.put("content", content);
		model.addAttribute("seq", seq);
//		System.out.println("model에 담아준 seq: "+seq);
		boolean isc = service.modifyQuestionboard(map);
		System.out.println("글 수정 성공여부: "+service.modifyQuestionboard(map));
		return "redirect:/questionBoard.do";
	}
	
	// 글 비밀번호 확인
	@RequestMapping(value = "/txtPwChk.do", method = RequestMethod.POST)
	@ResponseBody
	public String txtPwChk(Model model, String seq, String text_pw) {
		// 원본글의 정보
		QuestionDto qDto = service.questionDetailBoard(seq);
		
		model.addAttribute("qDto", qDto);
		model.addAttribute("text_pw", qDto.getText_pw());
		System.out.println("원본글 정보 qDto: " + qDto);
		System.out.println("원본글 정보 text_pw: " + qDto.getText_pw());
		
		return model.toString();
	}
	
	
	// 신고하기 test
	// 신고하기 폼으로 이동
	@RequestMapping(value = "/reportForm.do", method = RequestMethod.GET)
	public String reportForm(Model model, HttpSession session, String seq, String reporter_email, String subject_email) {
		System.out.println("seq: " + seq);
		System.out.println("reporter_email: " + reporter_email);
		System.out.println("subject_email: " + subject_email);
		
		// 신고자 정보
		Member mDto = (Member)session.getAttribute("mDto");
		System.out.println("session에 담긴 mDto: " + mDto);
		
		// 신고대상의 정보(email 필요)
		QuestionDto qDto = service.questionDetailBoard(seq);
		
		model.addAttribute("seq", seq); // 글번호
//		model.addAttribute("reporter_email", email); // 신고자의 이메일
		model.addAttribute("reporter_email", mDto.getEmail()); // 신고자의 이메일
		model.addAttribute("subject_email", qDto.getWriter()); // 신고대상의 이메일
		model.addAttribute("mDto", mDto);
		model.addAttribute("qDto", qDto);
		System.out.println("qDto: " + qDto);
		return "questionBoard/reportForm";
	}
	
	// 신고하기
	@RequestMapping(value = "/report.do", method = RequestMethod.POST)
	public String report(ReportDto dto) {
		boolean isc = rService.report(dto);
		System.out.println("dto: " + dto);
		System.out.println("신고 성공여부: " + isc);
		return "redirect:/questionBoard.do";
	}
	
}
