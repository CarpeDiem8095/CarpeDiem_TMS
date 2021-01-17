package com.cp.tms.model.member;


import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.cp.tms.dto.Member;

@Repository
public class MemberServiceImpl implements IMemberService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	

	@Autowired
	private IMemberDao Dao;
	
	//회원가입
	@Override
	public boolean singupMember(Member dto) {
		logger.info("회원가입 singupMember : {}", dto );
		return Dao.singupMember(dto);
	}
	
	 //회원 인증관련 메소드
	@Override
	public void authentication(Member dto) {
		Dao.authentication(dto);
		
	}


	//이메일 중복 체크
	@Override
	public boolean email_check(String e_mail) {
		boolean result = Dao.email_check(e_mail);
		return result;
	}





	@Override
	public void sendEmail(Member vo, String dto) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	//로그인
	@Override
	public Member loginMember(Map<String, Object> map) {
		logger.info("로그인 loginMember");
		return Dao.loginMember(map);
		
	}
	//로그아웃
	@Override
	public void logout(HttpSession session) {
		Dao.logout(session);
		
	}



	@Override
	public void findPw(HttpServletResponse resp, Member vo) {
		// TODO Auto-generated method stub
		
	}





	

	



	
	





	

	

	
}
