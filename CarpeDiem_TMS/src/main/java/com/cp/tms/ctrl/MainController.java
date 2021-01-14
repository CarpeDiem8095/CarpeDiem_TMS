package com.cp.tms.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {

	//메인페이지로 이동
	@RequestMapping(value = "/mainpage.do", method = RequestMethod.GET)
	public String gomain() {
		return "main/TripMainpage";
	}
	
}
