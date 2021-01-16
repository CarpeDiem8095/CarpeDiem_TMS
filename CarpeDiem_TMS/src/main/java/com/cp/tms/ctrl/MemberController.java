package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.Member;
import com.cp.tms.model.member.IMemberService;
import com.sun.mail.util.logging.MailHandler;


@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());


	@Autowired
	private IMemberService Service;
	

	//회원가입 페이지
	@RequestMapping(value="/register.do" , method = RequestMethod.GET)
	public String homeController() throws Exception {
		return "home";
	}

	// 회원가입 처리
	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
	public String signUp(Member dto) {
		boolean isc=Service.singupMember(dto);
		
		System.out.println(isc);
		return null;
	}
	
	
	
	
		
	
	

	//로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(@RequestParam Map<String, Object> map, HttpSession session) {
		Member mdto = Service.loginMember(map);
		session.setAttribute("mem", mdto);
		return "redirect:/index";
	}
	//로그인 처리
	@RequestMapping(value = "/loginCheckMap.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> loginCheckMap(HttpSession session, String email, String password){
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> iMap = new HashMap<String, Object>();
		iMap.put("email", email);
		iMap.put("password", password);
		Member mDto = Service.loginMember(iMap);
		if (mDto != null) {
			session.setAttribute("mDto", mDto);
			map.put("isc","성공");
		}else {
			map.put("isc","실패");
		}
		System.out.println(map);
		return map;
		
	}
	






}
