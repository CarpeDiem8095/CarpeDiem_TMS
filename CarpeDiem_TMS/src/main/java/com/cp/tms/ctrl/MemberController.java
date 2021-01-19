package com.cp.tms.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import com.cp.tms.ctrl.MailHandler;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.Member;
import com.cp.tms.model.chat.ITripchatService;
import com.cp.tms.model.member.IMemberDao;
import com.cp.tms.model.member.IMemberService;



@Controller
public class MemberController {
	
	
	 @Inject    //서비스를 호출하기 위해서 의존성을 주입
	  JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
	   
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());


	@Autowired
	private IMemberService Service;
	@Autowired
	private IMemberDao Dao;

	//회원가입 페이지
	@RequestMapping(value="/register.do" , method = RequestMethod.GET)
	public String homeController() throws Exception {
		
		return "redircet:/mainpage.do";
	}
	
	// 아이디 중복 검사
		@RequestMapping(value = "/memberIdChk.do", method = RequestMethod.POST)
		@ResponseBody
		public String memberIdChkPOST(String memberId) throws Exception{
		logger.info("memberIdChk() 진입");
			return "";
		}
	
	
	
	//이메일 인증
	@RequestMapping(value = "/mailCheck.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> mailCheckGET(String email) {
		MimeMessage message = mailSender.createMimeMessage();
		//view로부터 넘어온 데이터 확인
		logger.info("이메일 데이터 전송 확인");
		logger.info("인증번호 : "+ email);
		

        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        logger.info("인증번호 " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "joseokgyu12@gmail.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
        helper.setFrom(setFrom);
        helper.setTo(toMail);
        helper.setSubject(title);
        helper.setText(content,true);
        }catch(Exception e) {
            e.printStackTrace();
        }
        mailSender.send(message);
        Map<String, String> map = new HashMap<String, String>();
		String checkNum1 = checkNum+"";
        map.put("checkNum", checkNum1); // {checkNum = "2121231"}
        return map;
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
	
	//로그아웃 처리
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		Service.logout(session);
		return "redirect:index.jsp";
//		return "main";
	}
	
	

	
	//비밀번호 찾기
	//Email과 name의 일치여부를 check하는 컨트롤러
//	 @RequestMapping("/findPw.do")
//	    public @ResponseBody Map<String, Boolean> pw_find(String userEmail, String userName){
//	        Map<String,Boolean> json = new HashMap<>();
//	        boolean pwFindCheck = Service.userEmailCheck(userEmail,userName);
//
//	        System.out.println(pwFindCheck);
//	        json.put("check", pwFindCheck);
//	        return json;

//
//	 }
}
