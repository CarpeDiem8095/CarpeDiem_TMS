package com.cp.tms.ctrl;


import java.net.URLEncoder;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.cp.tms.dto.LoginDTO;
import com.cp.tms.dto.Member;
import com.cp.tms.model.member.IMemberDao;
import com.cp.tms.model.member.IMemberService;
import com.cp.tms.model.member.MemberDaoImpl;

@Controller
public class MemberCnotroller {
	
	@Autowired
	private IMemberService Service;
	
	//회원가입 페이지
		@RequestMapping(value="/register.do" , method = RequestMethod.GET)
		public String homeController() throws Exception {
			return "home";
		}
		
		// 회원가입 처리
	    @RequestMapping(value = "/register.do", method = RequestMethod.POST)
	    public String registerPOST(Member member, RedirectAttributes redirectAttributes) throws Exception {
	        String hashedPw = BCrypt.hashpw(member.getPassword(), BCrypt.gensalt());
	        member.setPassword(hashedPw);
	        Service.register(member);
	        redirectAttributes.addFlashAttribute("msg", "REGISTERED");
	        return "redirect:/login";
	    }
	    
	    //로그인 페이지
	    @RequestMapping(value = "/login.do", method = RequestMethod.GET)
	    public String login(@ModelAttribute("loginDTO") LoginDTO loginDTO) {
	    	return "login";
	    }
	    
	    //로그인 처리
	    public void loginCk(LoginDTO loginDTO, HttpSession httpSession, Model model) throws Exception {
	    	Member member = Service.login(loginDTO);
	    	if (member==null || ! BCrypt.checkpw(loginDTO.getPassword(), member.getPassword())) {
	    		return;
			}
	    	model.addAttribute("email", member);
	    }
	    
	    
	    
	    //이메일 중복확인
	    @RequestMapping(value = "/authenticate.do" , method = RequestMethod.GET)
	    public String emailCheck() {
	    	return "ajax";

	      

	    }
	    
	    
	    //이메일 인증번호 보내기
//	    @RequestMapping("emailCheckNumSend.do")
//	    public String emailCheckNumSend(HttpServletRequest req, HttpServletResponse res) {
//			String email = req.getParameter("email");
//			String host = "smtp.gmail.com";
//			String to = email;
//			String from = "joseokgyu12@gmail.com";
//			String password = "tjrrbsla1@";
//			String from_name = "카르페디엠운영자";
//			
//			Properties props = new Properties();
//			props.put("mail.smtps.auth", "true");
//			Session session = Session.getInstance(props);
//	    	
//			try {
//				MimeMessage msg = new MimeMessage(session);
//				msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(from_name, "UTF-8", "B")));
//				msg.setSubject("이메일 인증번호");
//				int CheckNum = 1;
//				while (true) {
//					CheckNum = ((int)(Math.random()*100000));
//					if (CheckNum>99999) {
//						break;
//					}
					
//				}
}
