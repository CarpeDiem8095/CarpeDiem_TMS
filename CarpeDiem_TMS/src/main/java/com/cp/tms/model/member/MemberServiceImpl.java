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


	@Override
	public void sendEmail(Member vo, String dto) {
		Dao.sendEmail(vo, dto);
	}
	
	@Override
	public void findPw(HttpServletResponse resp, Member vo) {
		Dao.findPw(resp, vo);
		
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
	public int userEmailCheck(String userEmail) {
		
		return Dao.userEmailCheck(userEmail);
	}

	@Override
	public Member readMember(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean idCheck(boolean b) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Object idCheck(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(String pw) {
		// TODO Auto-generated method stub
		
	}





	

	



	
	





	

	

	
}
