package com.cp.tms.ctrl;


import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.Member;
import com.cp.tms.dto.Paging;
import com.cp.tms.dto.QuestionDto;
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
	
	//네이버
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginGET() {
		
		return "user/login";
	}
	
	@RequestMapping(value="loginPostNaver", method=RequestMethod.GET)
	public String loginPOSTNaver(HttpSession session) {
		
		return "user/loginPostNaver";
	}
	
	

	
	
	/* 비밀번호 찾기 */
	@RequestMapping(value = "/findpw.do", method = RequestMethod.GET)
	public void findPwGET() throws Exception{
	}

	

	
	//이메일 인증
		@RequestMapping(value = "/mailCCk.do", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, String> mailCheck(String email) {
			MimeMessage message = mailSender.createMimeMessage();
			//view로부터 넘어온 데이터 확인
			
			Map<String, String> map = new HashMap<String, String>();
			Member mdto = new Member();
			mdto.setEmail(email);
			int cnt = Service.userEmailCheck(mdto);
			System.out.println(cnt);
			
			if (cnt>0) {

				map.put("checkNumtwo", "false");
			}else {

				 /* 인증번호(난수) 생성 */
		        Random random = new Random();
		        int checkNumtwo = random.nextInt(888888) + 111111;
		        logger.info("인증번호 " + checkNumtwo);
		        
		        
		        /* 이메일 보내기 */
		        String setFrom = "joseokgyu12@gmail.com";
		        String toMail = email;
		        String title = "카르페 디엠 회원가입 인증 이메일 입니다.";
		        String content = 
		                "카르페디엠을  방문해주셔서 감사합니다." +
		                "<br><br>" + 
		                "인증 번호는 " + checkNumtwo + "입니다." + 
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
		       String checkNum2= checkNumtwo+"";
		       	map.put("checkNumtwo", checkNum2);
			}
		

			return map;
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
//			sendEmail(vo, "findpw");

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
			model.addAttribute(session);
		return "main/TripMainpage";
		
	}
	
	//  게시판으로 이동(전체 조회-페이징)
		@RequestMapping(value = "/questionBoardAdmin.do", method = RequestMethod.GET)
		public String questionBoardAdmin(Model model, String page, HttpSession session, String seq, String email, String nickname, String joindate, String withdrawal) {

			
			// 로그인된 사용자 정보
			Member mDto = (Member)session.getAttribute("mDto");

			
			if (session.getAttribute("mDto") == null) {
				mDto = new Member();
				mDto.setEmail(email);
				mDto.setNickname(nickname);
				mDto.setJoindate(joindate);
				mDto.setAuth("U");
				mDto.setWithdrawal(withdrawal);
			}
			
			List<QuestionDto> qLists = null;
			
			if (page == null) {
				page = "1";
			}
			
			int selPage = Integer.parseInt(page);

			
			Paging p = new Paging();
			

			if (mDto.getAuth().equalsIgnoreCase("A")) { // 관리자
				p.setTotalCount(Service.adminTotalCount());
			} else { // 
				p.setTotalCount(Service.adminTotalCount());
			}
			
			// 보여줄 게시글의 수
			p.setCountList(5);
			
			// 보여줄 페이지의 수
			p.setCountPage(3);
			
			// 총 페이지의 수
			p.setTotalPage(p.getTotalCount());
			
			// 선택한 페이지
			p.setPage(selPage);
			
			// 시작 페이지
			p.setStartPage(selPage);
			
			// 마지막 페이지
			p.setEndPage(p.getCountPage());

			System.out.println(p);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("first", (p.getPage()-1)*p.getCountList()+1);
			map.put("last", p.getPage()*p.getCountList());

			if (mDto.getAuth().equalsIgnoreCase("A")) { // 관리자
				qLists = Service.adminQuestionboardList(map);
			} else { // 회원
				qLists = Service.adminQuestionboardList(map);		
			}
			model.addAttribute("questionLists", qLists);
			model.addAttribute("page", p);
			if(session.getAttribute("mDto")==null) {
				model.addAttribute("mDto.auth","U");
			}

			
			return "member/adminMap";
		}
		
		
		//로그인을 session객체를 sessionAttribute에 담아주기
		@RequestMapping(value = "/loginapi.do" , method = RequestMethod.GET)
		public String login() {
			return "ApiLogin";
		}
		
		//API 처리 구글
		@RequestMapping(value = "/loginafter.do", method = RequestMethod.POST)
		public String loginafter(Member mDto, Model model) {

			model.addAttribute("email", mDto.getEmail());
			model.addAttribute("nickname", mDto.getNickname());
			System.out.println(mDto);
			return "main/TripMainpage";
			
		}
	
	
}
