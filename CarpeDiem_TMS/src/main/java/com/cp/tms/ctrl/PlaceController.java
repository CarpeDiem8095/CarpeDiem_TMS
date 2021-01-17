package com.cp.tms.ctrl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.PlaceDto;
import com.cp.tms.model.schedule.IOneDayService;
import com.cp.tms.model.schedule.IPlaceService;

@Controller
public class PlaceController {

	@Autowired
	IPlaceService service;
	
	@Autowired
	IOneDayService oService;
	
	@RequestMapping(value = "/insertPlace.do", method = RequestMethod.POST)
	public String insertPlace(String placeName, String day, String myX, String myY, String note_seq) {
		
		String Xlat = myX.substring(0,11);
		String Ylng = myY.substring(0,11);
		
		PlaceDto dto = new PlaceDto();
		dto.setOneday_seq(day);
		dto.setXlat(Xlat);
		dto.setYlng(Ylng);
		dto.setPlace_name(placeName);
		
		System.out.println(dto);
		boolean isc = service.writePlace(dto);
		
		
		return isc?"redirect:/insertPlacePage.do?seq="+day+"&noteSeq="+note_seq+"":"error";
	}
	
	@RequestMapping(value="/delPlace.do", method = RequestMethod.GET)
	public String delPlace(Model model, String seq, String onedaySeq, String note_seq) {
		System.out.println(onedaySeq+"삭제 하루일정의 ");
		PlaceDto dto = new PlaceDto();
		dto.setPlace_seq(seq);
		dto.setOneday_seq(onedaySeq);
		
		boolean isc = service.stepMinusNdelPlace(seq, dto);
		
		return "redirect:/insertPlacePage.do?seq="+onedaySeq+"&noteSeq="+note_seq+"";
//		return isc?"redirect:/insertPlacePage.do?seq="+onedaySeq+"&noteSeq="+note_seq+"":"error";
	}
	
	@RequestMapping(value="/selDetailOneday.do", method = RequestMethod.GET)
	public String selDetailOneday(Model model, String seq) {
		
		List<OnedayDto> selDetailOneday = oService.selDetailOneday(seq);
		model.addAttribute("selDetailOneday", selDetailOneday);
		model.addAttribute("oneday_seq", seq);
		return selDetailOneday.size()>0?"schedules/onedayAllPlace":"error";
	}
}
