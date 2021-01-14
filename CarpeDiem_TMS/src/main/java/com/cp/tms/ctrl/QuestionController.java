package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.Paging;
import com.cp.tms.dto.QuestionDto;
import com.cp.tms.model.support.IQuestionService;

@Controller
public class QuestionController {

	@Autowired
	private IQuestionService service;
	
	// 문의 게시판으로 이동(전체 조회)
//	@RequestMapping(value = "/questionBoard.do", method = RequestMethod.GET)
//	public String questionBoard(Model model) {
//		List<QuestionDto> lists = service.userQuestionboardList();
//		model.addAttribute("questionLists", lists);
//		System.out.println(lists);
//		return "questionBoard";
//	}
	
	// 문의 게시판으로 이동(전체 조회-페이징)
	@RequestMapping(value = "/questionBoard.do", method = RequestMethod.GET)
	public String questionBoard(Model model, String page) {
//		System.out.println("넘어온 page: "+page);
		
		if (page == null) {
			page = "1";
		}
		
		int selPage = Integer.parseInt(page);
//		System.out.println("선택된 페이지: "+selPage);
		
		Paging p = new Paging();
		
		// 총 게시글의 수
		// 비회원, 회원
		p.setTotalCount(service.userTotalCount());
		// 관리자
//		p.setTotalcount(service.adminTotalCount());
		
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
		
		// 비회원, 회원
		List<QuestionDto> qUserDto = service.userQuestionboardList(map);
		// 관리자
//		List<QuestionDto> qAdminDto = service.adminQuestionboardList(map);
		
		// 비회원, 회원
		model.addAttribute("questionLists", qUserDto);
		// 관리자
//		model.addAttribute("questionLists", qAdminDto);
		
		model.addAttribute("page", p);
		
//		System.out.println("선택된 페이지의 글 목록: "+qUserDto);
//		System.out.println("선택된 페이지의 페이징dto: "+p);
		
		return "questionBoard";
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
		return "questionWriteForm";
	}
	
	// 글 입력
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public String write(QuestionDto dto) {
		boolean isc = service.userWriteQuestionboard(dto);
		System.out.println("문의글 입력 성공여부: " + isc);
		return "redirect:/questionBoard.do";
	}
	
	// 답글 입력 폼으로 이동
	@RequestMapping(value = "/replyForm.do", method = RequestMethod.GET)
	public String replyForm(Model model, String seq) {
//		System.out.println(seq);
		model.addAttribute("seq", seq);
		return "questionReplyForm";
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
		QuestionDto dto = service.questionDetailBoard(seq);
		JSONObject json = new JSONObject();
		json.put("seq", dto.getSeq());
		json.put("writer", dto.getWriter());
		json.put("title", dto.getTitle());
		json.put("content", dto.getContent());
//		System.out.println("선택된 글의 값: "+json.toString());
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
	
}
