package com.cp.tms.dto;

public class LoginDTO {
	
	private String Email;
	private String Password;
	private String Nickname;
	
	public LoginDTO() {
		
	}

	public LoginDTO(String email, String password, String nickname) {
		super();
		Email = email;
		Password = password;
		Nickname = nickname;
	}

	@Override
	public String toString() {
		return "LoginDTO [Email=" + Email + ", Password=" + Password + ", Nickname=" + Nickname + "]";
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public String getNickname() {
		return Nickname;
	}

	public void setNickname(String nickname) {
		Nickname = nickname;
	}
	
	
	
	

}
