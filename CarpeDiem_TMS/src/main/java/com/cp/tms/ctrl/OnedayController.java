package com.cp.tms.ctrl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.NoteDto;
import com.cp.tms.dto.OnedayDto;
import com.cp.tms.model.schedule.INoteService;
import com.cp.tms.model.schedule.IOneDayService;


@Controller
public class OnedayController {
	
	@Autowired
	IOneDayService service;
	
	@Autowired
	INoteService nService;
	
	@RequestMapping(value="/writeOneDayForm.do", method = RequestMethod.GET)
	public String writeOneDayForm(Model model, String seq) {
		model.addAttribute("seq",seq);
		System.out.println("노트의 seq "+seq+" 값입니다.");
		return "writeOneDayForm";
	}
	
	@RequestMapping(value = "/writeOneDay.do", method = RequestMethod.POST)
	@ResponseBody
	public String writeOneDay(String seq, String title, String oneDate) {
		System.out.println(seq+"Note에서 전송하는 seq값 입니다.");
		OnedayDto dto = new OnedayDto();
		dto.setNote_seq(seq);
		dto.setOneday_title(title);
		dto.setOnedate(oneDate);
		service.writeOneday(dto);
		
		return title;
		
	}
	@RequestMapping(value="/delOneday.do", method = RequestMethod.POST)
	public String delOneday(String seq, String noteSeq, Model model) {
		boolean isc = service.delOneday(seq);
		System.out.println(isc);
		
		List<NoteDto> ndto = nService.selDetailNote(noteSeq);
		model.addAttribute("ndto", ndto);
		model.addAttribute("seq",noteSeq);
		return "detailNote";
	}
	
	@RequestMapping(value="/insertPlacePage.do", method = RequestMethod.GET)
	public String insertPlace(Model model, String seq, String noteSeq) {
		model.addAttribute("seq",seq);
		
		List<OnedayDto> oneDto = service.selDetailOneday(seq);
		System.out.println("하루일정의 seq값 = "+seq);
		System.out.println(oneDto);
		
		model.addAttribute("note_seq", noteSeq);
		model.addAttribute("onedaySeq", seq);
		model.addAttribute("oneDto", oneDto);
		
		return "insertPlace";
	}
	
	
}
