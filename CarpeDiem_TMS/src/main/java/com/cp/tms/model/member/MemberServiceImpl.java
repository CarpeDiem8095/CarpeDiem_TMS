package com.cp.tms.model.member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.LoginDTO;
import com.cp.tms.dto.Member;

@Repository
public class MemberServiceImpl implements IMemberService {
	
	

	@Autowired
	private IMemberDao Dao;

	@Override
	public void register(Member member) throws Exception {
		Dao.register(member);
		
	}

	@Override
	public Member login(LoginDTO loginDTO) throws Exception {
		return Dao.login(loginDTO);
	}

	
}
