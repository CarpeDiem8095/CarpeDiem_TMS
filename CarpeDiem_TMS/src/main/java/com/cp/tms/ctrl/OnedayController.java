package com.cp.tms.ctrl;

import java.util.List;

import org.json.simple.JSONObject;
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
		return "schedules/writeOneDayForm";
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
		return "schedules/detailNote";
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
		return "schedules/insertPlace";
	}
	
	@RequestMapping(value = "/NoteCollectOneday.do", method = RequestMethod.GET)
	public String NoteCollectOneday(String note_seq, Model model, String page) {
		List<OnedayDto> oneDto = 
		service.noteCollectOnedayAP(note_seq);
		model.addAttribute("oneDto", oneDto);
		model.addAttribute("seq",note_seq);
		model.addAttribute("page",page);
		return "schedules/NoteCollectOneday";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/selectOneDay.do", method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String selectOneDay(String seq) {
		List<OnedayDto> oneDto = service.selDetailOneday(seq);
		
//		System.out.println(oneDto.get(0).getPlaceDto().size());
		int size = oneDto.get(0).getPlaceDto().size();
		
		
		String A_place_name = "";
		String A_xlat = "";
		String A_ylng = "";
		
		for (int i = 0; i < size; i++) {
			A_place_name += oneDto.get(0).getPlaceDto().get(i).getPlace_name()+"/";
			A_xlat += oneDto.get(0).getPlaceDto().get(i).getXlat()+"/";
			A_ylng += oneDto.get(0).getPlaceDto().get(i).getYlng()+"/";
		}
		
		System.out.println(A_place_name);
		System.out.println(A_xlat);
		System.out.println(A_ylng);
		
		JSONObject json = new JSONObject();
		json.put("A_place_name", A_place_name);
		json.put("A_xlat", A_xlat);
		json.put("A_ylng", A_ylng);
		json.put("size", size);
		return json.toString();
	}
	
//	// 글 수정 폼(modal)으로 이동
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value = "/modifyForm.do", method = RequestMethod.POST, 
//			produces = "application/text; charset=UTF-8;")
//	@ResponseBody
//	public String modifyForm(String seq) {
//		QuestionDto dto = service.questionDetailBoard(seq);
//		JSONObject json = new JSONObject();
//		json.put("seq", dto.getSeq());
//		json.put("writer", dto.getWriter());
//		json.put("title", dto.getTitle());
//		json.put("content", dto.getContent());
////		System.out.println("선택된 글의 값: "+json.toString());
//		return json.toString();
//	}
	
}
