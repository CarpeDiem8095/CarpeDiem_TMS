package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.NoteDto;
import com.cp.tms.dto.Paging;
import com.cp.tms.model.schedule.INoteService;

@Controller
public class NoteController {
	@Autowired
	INoteService service;
	
	@RequestMapping(value = "/notePaging.do", method = RequestMethod.GET)
	public String notePaging(Model model, String page) {
		System.out.println("넘어온 page의 값은"+page);
		if(page == null) {
			page = "1";
		}
		
		
		int selPage = Integer.parseInt(page);
		Paging p = new Paging();
		
		//페이지의 총 개수 넣어주기
		p.setTotalCount(service.countNote());
		
		//페이지의 글개수를 적어준다.
		p.setCountList(5);
		
		//페이지 수를 적어준다
		p.setCountPage(5);

		//전체 게시글의 숫자 넣어주기
		p.setTotalPage(p.getTotalCount());

		//선택한 페이지 넣어주기
		p.setPage(selPage);

		
		//선택한 페이지에대한 스타트페이지를 알려줌
		p.setStartPage(selPage);
		
		//마지막 페이지를 알려줌
		p.setEndPage(p.getCountPage());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", "A001");
		map.put("first", (p.getPage()-1)*p.getCountList()+1);
		map.put("last", p.getPage()*p.getCountList());
		
		List<NoteDto> pageList = service.selPagingNote(map);
		
		System.out.println(p);
		
		model.addAttribute("pageList",pageList);
		model.addAttribute("page", p);
		return "notePaging";
	}
	
	
	@RequestMapping(value ="/writeNoteForm.do", method = RequestMethod.GET)
	public String writeNoteForm(Model model) {
		String email = "A001";
		model.addAttribute("email", email);
		return "writeNoteForm";
	}
	
	@RequestMapping(value = "/writeNote.do", method = RequestMethod.POST)
	@ResponseBody
	public String writeNote(String email, String title) {
		
		NoteDto dto = new NoteDto();
		dto.setEmail(email);
		dto.setNote_title(title);
		service.writeNote(dto);
		
		return title;
	}
	
	
	
	@RequestMapping(value ="/delOneNote.do", method = RequestMethod.POST)
	public String delOneNote(String seq) {
		System.out.println(seq);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("note_seq", seq);
		map.put("email", "A001");
		boolean isc = service.delOneNote(map);
		System.out.println(isc);
		return "redirect:/notePaging.do";
	}
	
	@RequestMapping(value = "/delMultiNote.do", method = RequestMethod.POST)
	public String delMultiNote(@RequestParam("box") String[] seq , String page) {
		Map<String, Object[]> map = new HashMap<String, Object[]>();
		map.put("seqs", seq);
		
		boolean isc = service.delMultiNote(map);
		
		System.out.println(isc);
		return "redirect:/notePaging.do";
	}
	
	@RequestMapping(value = "/modifyNoteForm.do", method = RequestMethod.GET)
	public String modifyNoteForm(Model model, String seq) {
		String email = "A001";
		
		model.addAttribute("seq", seq);
		model.addAttribute("email", email);
		
		return "modifyNoteForm";
	}
	
	@RequestMapping(value = "/modifyNote", method = RequestMethod.POST)
	@ResponseBody
	public String modifyNote(String seq, String email, String title) {
		
		NoteDto dto = new NoteDto();
		dto.setEmail(email);
		dto.setNote_seq(seq);
		dto.setNote_title(title);
		
		service.modifyNote(dto);
		return title;
	}
	
	@RequestMapping(value = "/detailNote.do", method = RequestMethod.GET)
	public String detailNote(String seq, Model model) {
		
		
		List<NoteDto> ndto = service.selDetailNote(seq);
		System.out.println(ndto);
		
		model.addAttribute("ndto", ndto);
		model.addAttribute("seq",seq);
		return "detailNote";
	}
}
