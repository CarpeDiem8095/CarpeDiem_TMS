package com.cp.tms.dto;

public class UserDto {
	private int userseq;
	private String nickname;
	private String userid;
	private String auth;
	
	public UserDto() {
	}

	public UserDto(int userseq, String nickname, String userid, String auth) {
		super();
		this.userseq = userseq;
		this.nickname = nickname;
		this.userid = userid;
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "UserDto [userseq=" + userseq + ", nickname=" + nickname + ", userid=" + userid + ", auth=" + auth + "]";
	}

	public int getUserseq() {
		return userseq;
	}

	public void setUserseq(int userseq) {
		this.userseq = userseq;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	
}
