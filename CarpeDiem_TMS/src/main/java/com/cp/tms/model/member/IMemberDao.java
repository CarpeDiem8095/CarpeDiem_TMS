package com.cp.tms.model.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cp.tms.dto.Member;

public interface IMemberDao {
	
	// 회원 가입 처리
    public boolean singupMember(Member dto);
    
    //회원 인증관련 메소드
    public void authentication(Member dto);        
    
  //이메일 중복 체크
    public int userEmailCheck(String userEmail);
    
    // 로그인 처리
    public Member loginMember(Map<String, Object> map);
    
 // 로그아웃
    public void logout(HttpSession session);
    
    
    
 // 비밀번호 변경
    public int updatePw(Member vo) throws Exception;

    
  
    
    
    
    // 회원탈퇴 기능
    public boolean deleteUser(String email);
  
    // 전체 회원 조회(탈퇴test용)
    public List<Member> allMember();
    
    // 글 개수
    public int allBoardTotal();

}
