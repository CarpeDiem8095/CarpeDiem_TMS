package com.cp.tms.dto;

import java.util.Date;

public class CommentDto {

	private String comm_seq;
	private String oneday_seq;
	private String email;
	private String nickname;
	private int reffer;
	private int depth;
	private int step;
	private Date regdate;
	private String content;
	private String reportchk;
	
	public CommentDto() {
	}
	

	@Override
	public String toString() {
		return "CommentDto [comm_seq=" + comm_seq + ", oneday_seq=" + oneday_seq + ", email=" + email + ", nickname="
				+ nickname + ", reffer=" + reffer + ", depth=" + depth + ", step=" + step + ", regdate=" + regdate
				+ ", content=" + content + ", reportchk=" + reportchk + "]";
	}


	public CommentDto(String comm_seq, String oneday_seq, String email, String nickname, int reffer, int depth,
			int step, Date regdate, String content, String reportchk) {
		super();
		this.comm_seq = comm_seq;
		this.oneday_seq = oneday_seq;
		this.email = email;
		this.nickname = nickname;
		this.reffer = reffer;
		this.depth = depth;
		this.step = step;
		this.regdate = regdate;
		this.content = content;
		this.reportchk = reportchk;
	}


	public String getComm_seq() {
		return comm_seq;
	}

	public void setComm_seq(String comm_seq) {
		this.comm_seq = comm_seq;
	}

	public String getOneday_seq() {
		return oneday_seq;
	}

	public void setOneday_seq(String oneday_seq) {
		this.oneday_seq = oneday_seq;
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

	public int getReffer() {
		return reffer;
	}

	public void setReffer(int reffer) {
		this.reffer = reffer;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReportchk() {
		return reportchk;
	}

	public void setReportchk(String reportchk) {
		this.reportchk = reportchk;
	}
	
	
	

}
