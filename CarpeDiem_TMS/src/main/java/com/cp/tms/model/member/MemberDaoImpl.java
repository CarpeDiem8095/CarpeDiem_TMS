package com.cp.tms.model.member;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.cp.tms.dto.Member;

@Repository
public class MemberDaoImpl implements IMemberDao {
	
	private final String CP = "com.cp.tms.model.member.IMemberDao.";
	
	@Autowired
	private SqlSessionTemplate SqlSession;

	@Override
	public boolean singupMember(Member dto) {
		int cnt = SqlSession.insert(CP+"signupMember",dto);
		return (cnt>0)?true:false;
	}
	
	

	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = SqlSession.selectOne(CP+"loginMember", map);
		return dto;
		
	}

	@Override
	public void logout(HttpSession session) {
		System.out.println("=>로그아웃 처리 기능");
		session.invalidate();
	}



	@Override
	public int updatePw(Member vo) throws Exception {
		return SqlSession.update(CP+"resetPassword", vo);
	}



	@Override
	public void authentication(Member dto) {
		SqlSession.insert(CP+"apiLoginMember", dto);
		
	}







//	회원가입 (이메일 중복확인)

	public static int confirmEmail(String email){
		return 0;
	}

	@Override
	public int userEmailCheck(String userEmail) {
		return SqlSession.selectOne(CP+"EMDuplicateCheck", userEmail);
	}

	
	
	// 회원탈퇴 기능
	@Override
	public boolean deleteUser(String email) {
		int cnt = SqlSession.update(CP+"deleteUser", email);
		return cnt>0?true:false;
	}

	// 전체 회원 조회(탈퇴test용)
	@Override
	public List<Member> allMember() {
		return SqlSession.selectList(CP+"allBoard");
	}

	// 글 개수
	@Override
	public int allBoardTotal() {
		return SqlSession.selectOne(CP+"allBoardTotal");
	}

}
