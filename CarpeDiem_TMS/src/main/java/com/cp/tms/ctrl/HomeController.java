package com.cp.tms.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping(value="hello")
	public String homeController() {
		
		return "hello";
	}
	
}
