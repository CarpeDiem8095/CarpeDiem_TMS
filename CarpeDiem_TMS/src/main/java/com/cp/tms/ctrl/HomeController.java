package com.cp.tms.ctrl;


import java.io.IOException;
import java.io.UnsupportedEncodingException;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cp.tms.dto.LoginDTO;
import com.cp.tms.dto.Member;
import com.cp.tms.model.member.IMemberDao;
import com.cp.tms.model.member.IMemberService;
import com.cp.tms.model.member.MemberDaoImpl;

@Controller
public class HomeController {
	
	
	@Autowired
	private IMemberService Service;
	
	

	

	//회원가입 페이지
	@RequestMapping(value="/register.do" , method = RequestMethod.GET)
	public String homeController() throws Exception {
		return "home";
	}
	
//	 회원가입 처리
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
	
}
