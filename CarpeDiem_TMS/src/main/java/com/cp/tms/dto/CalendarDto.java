package com.cp.tms.dto;

import java.util.Date;

public class CalendarDto {
	
	private int oneday_seq;
	private int note_seq;
	private String oneday_title;
	private String content;
	private String mdate;
	private Date onedate;
	
	public CalendarDto() {
	}

	public CalendarDto(String oneday_title, String content, String mdate) {
		this.oneday_title = oneday_title;
		this.content = content;
		this.mdate = mdate;
	}

	@Override
	public String toString() {
		return "CalendarDto [oneday_seq=" + oneday_seq + ", note_seq=" + note_seq + ", oneday_title=" + oneday_title
				+ ", content=" + content + ", mdate=" + mdate + ", onedate=" + onedate + "]";
	}

	public int getOneday_seq() {
		return oneday_seq;
	}

	public void setOneday_seq(int oneday_seq) {
		this.oneday_seq = oneday_seq;
	}

	public int getNote_seq() {
		return note_seq;
	}

	public void setNote_seq(int note_seq) {
		this.note_seq = note_seq;
	}

	public String getOneday_title() {
		return oneday_title;
	}

	public void setOneday_title(String oneday_title) {
		this.oneday_title = oneday_title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMdate() {
		return mdate;
	}

	public void setMdate(String mdate) {
		this.mdate = mdate;
	}

	public Date getOnedate() {
		return onedate;
	}

	public void setOnedate(Date onedate) {
		this.onedate = onedate;
	}

}
