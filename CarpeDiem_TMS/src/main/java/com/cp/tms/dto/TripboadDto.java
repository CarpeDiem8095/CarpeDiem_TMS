package com.cp.tms.dto;

import java.util.Date;

public class TripboadDto {

	private int seq;
	private int rn;
	private String userid;
	private String nickname;
	private String boardtitle;
	private String delflag;
	private Date tripregdate;

	public TripboadDto() {
	}

	public TripboadDto(int seq, int rn, String userid, String nickname, String boardtitle, String delflag,
			Date tripregdate) {
		super();
		this.seq = seq;
		this.rn = rn;
		this.userid = userid;
		this.nickname = nickname;
		this.boardtitle = boardtitle;
		this.delflag = delflag;
		this.tripregdate = tripregdate;
	}

	@Override
	public String toString() {
		return "TripboadDto [seq=" + seq + ", rn=" + rn + ", userid=" + userid + ", nickname=" + nickname
				+ ", boardtitle=" + boardtitle + ", delflag=" + delflag + ", tripregdate=" + tripregdate + "]";
	}

	
	
	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getBoardtitle() {
		return boardtitle;
	}

	public void setBoardtitle(String boardtitle) {
		this.boardtitle = boardtitle;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public Date getTripregdate() {
		return tripregdate;
	}

	public void setTripregdate(Date tripregdate) {
		this.tripregdate = tripregdate;
	}

}
