package com.cp.tms.model.member;


import com.cp.tms.dto.LoginDTO;
import com.cp.tms.dto.Member;

public interface IMemberService {
	
	// 회원 가입 처리
    void register(Member member) throws Exception;
    
    // 로그인
    Member login(LoginDTO loginDTO) throws Exception;
}
