package com.cp.tms.model.member;


import java.util.Map;

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
	
	//이메일 중복체크
	@Override
	public boolean idDuplicateCheck(String email) {
		logger.info("이메일 중복 검사 idDuplicateCheck:{}", email);
		return Dao.idDuplicateCheck(email);
	}
	
	//로그인
	@Override
	public Member loginMember(Map<String, Object> map) {
		logger.info("로그인 loginMember");
		return Dao.loginMember(map);
		
	}
	





	

	

	
}
