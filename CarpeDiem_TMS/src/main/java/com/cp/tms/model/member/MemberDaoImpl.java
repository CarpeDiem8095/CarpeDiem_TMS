package com.cp.tms.model.member;


import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.cp.tms.dto.Member;

@Repository
public class MemberDaoImpl implements IMemberDao {
	
	private final String CP = "com.cp.tms.model.member.MemberDao.";
	
	@Autowired
	private SqlSessionTemplate SqlSession;

	@Override
	public boolean singupMember(Member dto) {
		int cnt = SqlSession.insert(CP+"signupMember",dto);
		return (cnt>0)?true:false;
	}
	
	@Override
	public boolean idDuplicateCheck(String email) {
		int cnt = SqlSession.insert(CP+"idDuplicateCheck", email);
		return (cnt>0)?true:false;
	}

	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = SqlSession.selectOne(CP+"loginMember", map);
		return dto;
	}










	
	

	
	
}
