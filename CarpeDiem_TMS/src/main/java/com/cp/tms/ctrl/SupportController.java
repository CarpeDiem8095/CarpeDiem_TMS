package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.dto.QuestionDto;
import com.cp.tms.model.support.IQuestionService;

@Controller
public class SupportController {

	@Autowired
	private IQuestionService service;
	
	// 문의 게시판으로 이동(전체 조회)
	@RequestMapping(value = "/questionboard.do", method = RequestMethod.GET)
	public String questionboard(Model model) {
		List<QuestionDto> lists = service.userQuestionboardList();
		model.addAttribute("lists", lists);
//		System.out.println(lists);
		return "questionboard";
	}
	
	// 다중삭제
	@RequestMapping(value = "/multiDel.do", method = RequestMethod.POST)
	public String multiDel(String[] chkVal) {
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seqs", chkVal);
		boolean isc = service.multiDelQuestionboard(map);
		System.out.println("다중삭제 성공여부: " + isc);
		return "redirect:/questionboard.do";
	}
	
	// 상세글 삭제(root글 삭제 시 댓글도 같이 삭제 됨) -> 댓글 삭제 시 root글이 같이 삭제되는 부분 수정해야 함(session에 담을 그릇이 필요해서 memberDto 필요함)
	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public String delete(String seq) {
		boolean isc = service.deleteQuestionboard(seq);
		System.out.println("글 삭제 성공여부: " + isc);
		return "redirect:/questionboard.do";
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
		return "redirect:/questionboard.do";
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
		return "redirect:/questionboard.do";
	}
	
	// 글 수정 폼(modal)으로 이동
	
	
	// 글 수정
}
