package com.cp.tms.model.member;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.LoginDTO;
import com.cp.tms.dto.Member;

@Repository
public class MemberDaoImpl implements IMemberDao {
	
	private final String CP = "com.cp.tms.model.member.MemberDao.";
	
	@Autowired
	private SqlSessionTemplate SqlSession;

	@Override
	public void register(Member member) throws Exception {
		SqlSession.insert(CP+".register", member);
		
	}

	//로그인 처리
	@Override
	public Member login(LoginDTO loginDTO) throws Exception {
		return SqlSession.selectOne(CP+".login", loginDTO);
	}

	
	
}
