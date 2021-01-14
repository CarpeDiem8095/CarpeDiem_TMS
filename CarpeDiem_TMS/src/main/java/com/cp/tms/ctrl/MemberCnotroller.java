package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.cp.tms.dto.Member;
import com.cp.tms.model.member.IMemberService;


@Controller
public class MemberCnotroller {
	
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
	
	//중복 체크
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public Map<String, String> emailCheck(String email){
		Map<String, String> map = new HashMap<String, String>();
		logger.info("idCheck.do :\t", email);
		boolean isc = Service.idDuplicateCheck(email);
		logger.info("welecom idCheck.do 결과: \t", isc);
		map.put("isc", String.valueOf(isc));
		return map;
	}
	
		
	
	

	//로그인
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(Map<String, Object> map, HttpSession session) {
		Member mdto = Service.loginMember(map);
		session.setAttribute("mem", mdto);
		return "redirect:/register.do";
	}
	//로그인 처리
	@RequestMapping(value = "/loginCheckMap.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> loginCheckMap(String email, String password){
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> iMap = new HashMap<String, Object>();
		iMap.put("email", email);
		iMap.put("password", password);
		Member mDto=Service.loginMember(iMap);
		System.out.println("로그인 결과값 : \t" +mDto);
		if (mDto== null) {
			map.put("isc", "실패");
		}else {
			map.put("isc", "성공");
		}
		return map;
		
	}
	






}
