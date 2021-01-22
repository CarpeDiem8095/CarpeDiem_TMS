package com.cp.tms.model.member;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;


import com.cp.tms.dto.Member;
import com.cp.tms.dto.QuestionDto;

@Repository
public class MemberDaoImpl implements IMemberDao {
	
	private final String CP = "com.cp.tms.model.member.IMemberDao.";
	
	@Autowired
	private SqlSessionTemplate SqlSession;
	
	@Autowired
	private PasswordEncoder passwordencoder;

	@Override
	public boolean singupMember(Member dto) {
		dto.setPassword(passwordencoder.encode(dto.getPassword()));
		int cnt = SqlSession.insert(CP+"memberList",dto);
		return (cnt>0)?true:false;
	}
	
	

	@Override
	public Member loginMember(Map<String, Object> map) {
		Member dto = SqlSession.selectOne(CP+"loginMember", map);
		String dbPW=SqlSession.selectOne(CP+"security",map.get("email"));
		if(passwordencoder.matches((String)map.get("password"), dbPW)) {
			return SqlSession.selectOne(CP+"securitylogin",map);
		}
		return dto;
	}

	@Override
	public void logout(HttpSession session) {
		System.out.println("=>로그아웃 처리 기능");
		session.invalidate();
	}




	@Override
	public void authentication(Member dto) {
		SqlSession.insert(CP+"apiLoginMember", dto);
		
	}







//	회원가입 (이메일 중복확인)

	public static int confirmEmail(String email){
		return 0;
	}

	//이메일 중복 확인
	@Override
	public int userEmailCheck(Member mdto) {
		return SqlSession.selectOne(CP+"EMDuplicateCheck", mdto);
	}

		//이메일 발송
		@Override
		public void sendEmail(Member vo, String dto) {
			
			
		}


		//비밀번호 찾기
		@Override
		public void findPw(HttpServletResponse resp, Member vo) {
			
			
		}



		@Override
		public int updatePw(Member vo) throws Exception {
			
			return SqlSession.update(CP+"resetPassword", vo);
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


	//마이페이지
	@Override
	public int update_mypage(Member mdto) {
		mdto.setPassword(passwordencoder.encode(mdto.getPassword()));
		return SqlSession.update(CP+"update_mypage", mdto);
	}



	//관리자페이지
	@Override
	public List<QuestionDto> adminQuestionboardList(Map<String, Object> map) {
		return SqlSession.selectList(CP+"allBoard", map);
	}
	//글갯수
	@Override
	public int adminTotalCount() {
		return SqlSession.selectOne(CP+"adminTotalCountOne");
	}




}
