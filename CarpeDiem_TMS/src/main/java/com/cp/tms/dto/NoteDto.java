package com.cp.tms.dto;

import java.util.List;

public class NoteDto {
	private String note_seq;
	private String email;
	private String note_del;
	private String note_readcnt;
	private String note_title;
	private String note_regdate;
	
	private List<OnedayDto> odto;

	public List<OnedayDto> getOdto() {
		return odto;
	}

	public void setOdto(List<OnedayDto> odto) {
		this.odto = odto;
	}

	public NoteDto() {
	}

	public String getNote_seq() {
		return note_seq;
	}

	public void setNote_seq(String note_seq) {
		this.note_seq = note_seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNote_del() {
		return note_del;
	}

	public void setNote_del(String note_del) {
		this.note_del = note_del;
	}

	public String getNote_readcnt() {
		return note_readcnt;
	}

	public void setNote_readcnt(String note_readcnt) {
		this.note_readcnt = note_readcnt;
	}

	public String getNote_title() {
		return note_title;
	}

	public void setNote_title(String note_title) {
		this.note_title = note_title;
	}

	public String getNote_regdate() {
		return note_regdate;
	}

	public void setNote_regdate(String note_regdate) {
		this.note_regdate = note_regdate;
	}

	public NoteDto(String note_seq, String note_title) {
		super();
		this.note_seq = note_seq;
		this.note_title = note_title;
	}

	@Override
	public String toString() {
		return "NoteDto [note_seq=" + note_seq + ", email=" + email + ", note_del=" + note_del + ", note_readcnt="
				+ note_readcnt + ", note_title=" + note_title + ", note_regdate=" + note_regdate + ", odto=" + odto
				+ "]";
	}

	public NoteDto(String note_seq, String email, String note_del, String note_readcnt, String note_title,
			String note_regdate, List<OnedayDto> odto) {
		super();
		this.note_seq = note_seq;
		this.email = email;
		this.note_del = note_del;
		this.note_readcnt = note_readcnt;
		this.note_title = note_title;
		this.note_regdate = note_regdate;
		this.odto = odto;
	}
}
