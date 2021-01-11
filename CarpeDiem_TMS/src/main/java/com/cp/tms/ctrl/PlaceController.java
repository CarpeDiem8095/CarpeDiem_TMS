package com.cp.tms.ctrl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.dto.PlaceDto;
import com.cp.tms.model.schedule.IPlaceService;

//@Controller
public class PlaceController {

	@Autowired
	IPlaceService service;
	
	@RequestMapping(value = "/insertPlace.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String insertPlace(Model model, String placeName, String day, String myX, String myY) {
		PlaceDto dto = new PlaceDto();
		dto.setOneday_seq(day);
		dto.setXlat(myX);
		dto.setYlng(myY);
		dto.setStep("4");
		dto.setPlace_name(placeName);
		
		System.out.println(dto);
		return null;
	}
	
}
