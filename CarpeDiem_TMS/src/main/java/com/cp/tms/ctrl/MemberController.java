package com.cp.tms.ctrl;

import java.io.IOException;
import java.io.PrintWriter;
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
import com.cp.tms.model.member.IMemberService;



@Controller
public class MemberController {
	
	
	 @Inject    //서비스를 호출하기 위해서 의존성을 주입
	  JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.
	   
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());


	@Autowired
	private IMemberService Service;

	//회원가입 페이지
	@RequestMapping(value="/register.do" , method = RequestMethod.GET)
	public String homeController() throws Exception {
		return "home";
	}
	
	// 이메일 중복 검사(AJAX)
	@RequestMapping(value = "/auth.do" , method = RequestMethod.POST) 
	@ResponseBody  
		public ModelAndView SendMail(HttpServletRequest request, String e_mail, HttpServletResponse response_email) throws IOException {
		
		Random r= new Random();
		int dice = r.nextInt(4589362)+49311; //이메일 받는 인증코드 난수처리
		
		String setfrom = "joseokgyu12@gmail.com";
		String tomail = request.getParameter("e_mail");
		String title = "회원가입시 인증 이메일 입니다.";
		String content =  
				System.getProperty("line.separatro")+
				System.getProperty("line.separatro")+
				"안녕하세요 카르페디엠 에 찾아주셔서 감사합니다."+
				System.getProperty("line.separatro")+
				System.getProperty("line.separatro")+
				 " 인증번호는 " +dice+ " 입니다. "+
				 System.getProperty("line.separatro")+
				 System.getProperty("line.separatro")+
				 "받으신 인증메일이 완료되면 회원가입을 진행합니다";
		
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			
			//보내는 사람 
			messageHelper.setFrom(setfrom);
			// 받는 사람
			messageHelper.setTo(tomail);
			//메일제목
			messageHelper.setSubject(title);
			//메일 내용
			messageHelper.setText(content);
			
			mailSender.send(message);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("main/TripMainpage");
		mv.addObject("dice", dice);
//		System.out.println("결과값 :"+dice);
		System.out.println("mv:"+mv);
		
		response_email.setContentType("text/html; charset=UTF-8");
		PrintWriter out_email = response_email.getWriter();
        out_email.println("<script>alert('이메일이 발송되었습니다. 인증번호를 입력해주세요.');</script>");
        out_email.flush();
        
        
        	return mv;
		}
	
//	//이메일 인증 페이지 맵핑 메소드
//    @RequestMapping("/email.do")
//    public String email() {
//        return "member/email";
//    }
//    
//    
//    @RequestMapping(value = "/join_injeung.do{dice}", method = RequestMethod.POST)
//    public ModelAndView join_injeung(String email_injeung, @PathVariable String dice, HttpServletResponse response_equals) throws IOException {
// 
//        
//        
//        
//        System.out.println("마지막 : email_injeung : "+email_injeung);
//        
//        System.out.println("마지막 : dice : "+dice);
//        
//        
//        //페이지이동과 자료를 동시에 하기위해 ModelAndView를 사용해서 이동할 페이지와 자료를 담음
//         
//        ModelAndView mv = new ModelAndView();
//        
//        mv.setViewName("/main/join.do");
//        
//        mv.addObject("e_mail",email_injeung);
//        
//        if (email_injeung.equals(dice)) {
//            
//            //인증번호가 일치할 경우 인증번호가 맞다는 창을 출력하고 회원가입창으로 이동함
//            
//            
//            
//            mv.setViewName("member/join");
//            
//            mv.addObject("e_mail",email_injeung);
//            
//            //만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨서 이메일을
//            //한번더 입력할 필요가 없게 한다.
//            
//            response_equals.setContentType("text/html; charset=UTF-8");
//            PrintWriter out_equals = response_equals.getWriter();
//            out_equals.println("<script>alert('인증번호가 일치하였습니다. 회원가입창으로 이동합니다.');</script>");
//            out_equals.flush();
//    
//            return mv;
//            
//            
//        }else if (email_injeung != dice) {
//            
//            
//            ModelAndView mv2 = new ModelAndView(); 
//            
//            mv2.setViewName("member/email_injeung");
//            
//            response_equals.setContentType("text/html; charset=UTF-8");
//            PrintWriter out_equals = response_equals.getWriter();
//            out_equals.println("<script>alert('인증번호가 일치하지않습니다. 인증번호를 다시 입력해주세요.'); history.go(-1);</script>");
//            out_equals.flush();
//            
//    
//            return mv2;
//            
//        }    
    
        

//	// 회원가입 처리
//	@RequestMapping(value = "/register.do", method = RequestMethod.POST)
//	public void send_mail(Member member) throws Exception {
//			// Mail Server 설정
//			String charSet = "utf-8";
//			String hostSMTP = "smtp.naver.com";
//			String hostSMTPid = "아이디";
//			String hostSMTPpwd = "비밀번호";
//
//			// 보내는 사람 EMail, 제목, 내용
//			String fromEmail = "아이디";
//			String fromName = "Spring Homepage";
//			String subject = "";
//			String msg = "";
//
//			// 회원가입 메일 내용
//			subject = "Spring Homepage 회원가입 인증 메일입니다.";
//			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
//			msg += "<h3 style='color: blue;'>";
//			msg += member.getNickname() + "님 회원가입을 환영합니다.</h3>";
//			msg += "<div style='font-size: 130%'>";
//			msg += "하단의 인증 버튼 클릭 시 정상적으로 회원가입이 완료됩니다.</div><br/>";
//			msg += "<form method='post' action='http://localhost:8081/homepage/member/approval_member.do'>";
//			msg += "<input type='hidden' name='email' value='" + member.getEmail() + "'>";
////			msg += "<input type='hidden' name='approval_key' value='" + member.get + "'>";
//			msg += "<input type='submit' value='인증'></form><br/></div>";
//
//			// 받는 사람 E-Mail 주소
//			String mail = member.getEmail();
//			try {
//				HtmlEmail email = new HtmlEmail();
//				email.setDebug(true);
//				email.setCharset(charSet);
//				email.setSSL(true);
//				email.setHostName(hostSMTP);
//				email.setSmtpPort(587);
//
//				email.setAuthentication(hostSMTPid, hostSMTPpwd);
//				email.setTLS(true);
//				email.addTo(mail, charSet);
//				email.setFrom(fromEmail, fromName, charSet);
//				email.setSubject(subject);
//				email.setHtmlMsg(msg);
//				email.send();
//			} catch (Exception e) {
//				System.out.println("메일발송 실패 : " + e);
//			}
//		}
//	
//	
//	//인증키 생성
//	public String create_key() {
//		String key ="";
//		Random rd = new Random();
//		
//		for (int i = 0; i < 8; i++) {
//			key += rd.nextInt(10);
//		}
//		return key;
//	}
	
		
	
	

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
	@RequestMapping(value = "/logout.do")
	public ModelAndView logout(HttpSession session) {
		Service.logout(session);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main/TripMainpage");
		mav.addObject("msg", "logout");
		
		return mav;
	}

	
	//비밀번호 찾기
	@RequestMapping(value = "/findpw", method = RequestMethod.GET)
	public void findPwGET() throws Exception {
	}
	
	@RequestMapping(value = "/findpw", method = RequestMethod.POST)
	public void findPwPOST(@ModelAttribute Member member, HttpServletResponse response) {
		Service.findPw(response, member);
	}


	
	//비밀번호 찾기 이메일발송
	public void sendEmail(Member vo, String div) {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = "joseokgyu12@gmail.com";
		String hostSMTPpwd = "tjrrbsla1@";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "joseokgyu12@gmail.com";
		String fromName = "CarepeDiem";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "카르페디엠 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += vo.getNickname() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
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

////	비밀번호찾기
//	public void findPw(HttpServletResponse response, Member vo) throws Exception {
//		response.setContentType("text/html;charset=utf-8");
//		Member ck = vo.readMember(vo.getEmail());
//		PrintWriter out = response.getWriter();
//		// 가입된 아이디가 없으면
//		if(mdao.idCheck(vo.getId()) == null) {
//			out.print("등록되지 않은 아이디입니다.");
//			out.close();
//		}
//		// 가입된 이메일이 아니면
//		else if(!vo.getEmail().equals(ck.getEmail())) {
//			out.print("등록되지 않은 이메일입니다.");
//			out.close();
//		}else {
//			// 임시 비밀번호 생성
//			String pw = "";
//			for (int i = 0; i < 12; i++) {
//				pw += (char) ((Math.random() * 26) + 97);
//			}
//			vo.setPw(pw);
//			// 비밀번호 변경
//			mdao.updatePw(vo);
//			// 비밀번호 변경 메일 발송
//			sendEmail(vo, "findpw");
//
//			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
//			out.close();
//		}
//	}


}
