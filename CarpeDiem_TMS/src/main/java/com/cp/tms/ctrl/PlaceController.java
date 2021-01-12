package com.cp.tms.ctrl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String insertPlace(String placeName, String day, String myX, String myY) {
		
		String Xlat = myX.substring(0,11);
		String Ylng = myY.substring(0,11);
		
		PlaceDto dto = new PlaceDto();
		dto.setOneday_seq(day);
		dto.setXlat(Xlat);
		dto.setYlng(Ylng);
		dto.setStep("5");
		dto.setPlace_name(placeName);
//		
		System.out.println(dto);
		service.writePlace(dto);
		
		List<OnedayDto> oneDto = oService.selDetailOneday(day);
		System.out.println("하루일정의 seq값 = "+day);
		System.out.println(oneDto);
		
		return "redirect:/insertPlacePage.do?seq="+day;
	}
	
	@RequestMapping(value="/delPlace.do", method = RequestMethod.GET)
	public String delPlace(Model model, String seq, String onedaySeq) {
		service.stepMinusNdelPlace(onedaySeq);
		return "";
	}
	
}
