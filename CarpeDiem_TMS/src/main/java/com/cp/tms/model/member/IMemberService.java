package com.cp.tms.model.member;

import java.util.Map;

import com.cp.tms.dto.Member;

public interface IMemberService {
	
	// 회원 가입 처리
    public boolean singupMember(Member dto);
    
    //이메일 중복 체크
    public boolean idDuplicateCheck(String email);
    
    // 로그인 처리
    public Member loginMember(Map<String, Object> map);
    
 
  
    
    
}
