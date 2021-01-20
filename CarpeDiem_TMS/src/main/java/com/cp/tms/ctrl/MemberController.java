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


	//회원가입 페이지 이동
	@RequestMapping(value="/register.do" , method = RequestMethod.GET)
	public String homeController() throws Exception {
		
		return "redircet:/mainpage.do";
	}
	
	//회언가입
	@RequestMapping(value = "/joinform.do", method = RequestMethod.POST)
	public String joinfrom(Model model, Member dto) {
		System.out.println(dto);
		boolean isc = Service.singupMember(dto);
		if (isc) {
			model.addAttribute("<script>alert('회원가입에 성공하셨습니다')</script>");
		}else {
			model.addAttribute("<script>alert('회원가입에 실패하셨습니다')</script>");
		}
		
		return "redirect:index.jsp";
		
	}
	
	//회원탈퇴
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public String Withdrawal() {
//		System.out.println("탈퇴페이지로옴");
		return "member/Withdrawal";
	}
	
	@RequestMapping(value = "/delUser.do", method = RequestMethod.POST)
	public String delUser(String email, HttpSession session) {
		Service.deleteUser(email);
		Service.logout(session);
		return "main/TripMainpage";
	}
	
	
	//이메일 인증
	@RequestMapping(value = "/mailCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> mailCheckGET(String email) {
		MimeMessage message = mailSender.createMimeMessage();
		//view로부터 넘어온 데이터 확인
		
		Map<String, String> map = new HashMap<String, String>();
		Member mdto = new Member();
		mdto.setEmail(email);
		int cnt = Service.userEmailCheck(mdto);
		System.out.println(cnt);
		
		if (cnt>0) {

			map.put("checkNum", "false");
		}else {

			 /* 인증번호(난수) 생성 */
	        Random random = new Random();
	        int checkNum = random.nextInt(888888) + 111111;
	        logger.info("인증번호 " + checkNum);
	        
	        
	        /* 이메일 보내기 */
	        String setFrom = "joseokgyu12@gmail.com";
	        String toMail = email;
	        String title = "카르페 디엠 회원가입 인증 이메일 입니다.";
	        String content = 
	                "카르페디엠을  방문해주셔서 감사합니다." +
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
	       String checkNum1= checkNum+"";
	       	map.put("checkNum", checkNum1);
		}
	

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
	
	
	/* 비밀번호 찾기 */
	@RequestMapping(value = "/findpw.do", method = RequestMethod.GET)
	public void findPwGET() throws Exception{
	}

	@RequestMapping(value = "/findpw.do", method = RequestMethod.POST)
	public void findPwPOST(@ModelAttribute Member member, HttpServletResponse response) throws Exception{
		Service.findPw(response, member);
//		return "";
	}
	

	
	//비밀번호 찾기 이메일발송
	public void sendEmail(Member vo, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = "joseokgyu12@gmail.com";
		String hostSMTPpwd = "tjrrbsla1@";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "joseokgyu12@gmail.com";
		String fromName = "카르페디엠";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "카르페디엠 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += vo.getNickname()+ "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += vo.getPassword() + "</p></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = vo.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	//비밀번호찾기
	public void findPw(HttpServletResponse response, Member vo) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		Member ck = Service.readMember(vo.getEmail());
		PrintWriter out = response.getWriter();
		
		if(Service.idCheck(vo.getNickname()) == null) {
			out.print("등록되지 않은 닉네임입니다.");
			out.close();
		}
		// 가입된 이메일이 아니면
		else if(!vo.getEmail().equals(ck.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			((Member) vo).setPassword(pw);
			// 비밀번호 변경;
			
			Service.update(pw);
			// 비밀번호 변경 메일 발송
			sendEmail(vo, "findpw");

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	}
	//마이페이지 이동
	@RequestMapping(value = "/mypage.do")
	public String mypage() {
		return "/member/mypage";
	}
	
	//마이페이지 처리
	@RequestMapping(value = "/update_mypage.do", method = RequestMethod.POST)
	public String update_mypage (Model model, Member mdto, HttpSession session) {
		System.out.println(mdto);
		int cnt = Service.update_mypage(mdto);
		if (cnt>0) {
			model.addAttribute("<script>alert('회원정보 수정 완료');</script>");
		}else {
			model.addAttribute("<script>alert('회원정보 수정 실패');</script>");
		}
			model.addAttribute(session);
		return "main/TripMainpage";
		
	}
	
	
}
