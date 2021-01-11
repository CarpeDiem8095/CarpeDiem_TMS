package com.cp.tms.dto;

public class Member {
	
	private String email;
	private String nickname;
	private String password;
	private String auth;
	private String withdrawal;
	private String joindate;
	
	
	public Member() {
	
	}

	public Member(String email, String nickname, String password, String auth, String withdrawal, String joindate) {
		super();
		this.email = email;
		this.nickname = nickname;
		this.password = password;
		this.auth = auth;
		this.withdrawal = withdrawal;
		this.joindate = joindate;
	}


	@Override
	public String toString() {
		return "Member [email=" + email + ", nickname=" + nickname + ", password=" + password + ", auth=" + auth
				+ ", withdrawal=" + withdrawal + ", joindate=" + joindate + "]";
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getAuth() {
		return auth;
	}


	public void setAuth(String auth) {
		this.auth = auth;
	}


	public String getWithdrawal() {
		return withdrawal;
	}


	public void setWithdrawal(String withdrawal) {
		this.withdrawal = withdrawal;
	}


	public String getJoindate() {
		return joindate;
	}


	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
   
	
	
}
