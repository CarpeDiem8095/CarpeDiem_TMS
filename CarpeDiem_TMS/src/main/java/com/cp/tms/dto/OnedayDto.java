package com.cp.tms.dto;

import java.util.List;

public class OnedayDto {

	private String oneday_seq;
	private String note_seq;

	private String oneday_delflag;
	private String oneday_title;
	private String onedate;
	private String reportchk;
	private String one_readcnt;
	private String note_public;
	
	private List<PlaceDto> placeDto;

	@Override
	public String toString() {
		return "OnedayDto [oneday_seq=" + oneday_seq + ", note_seq=" + note_seq + ", oneday_delflag=" + oneday_delflag
				+ ", oneday_title=" + oneday_title + ", onedate=" + onedate + ", reportchk=" + reportchk
				+ ", one_readcnt=" + one_readcnt + ", note_public=" + note_public + ", placeDto=" + placeDto + "]";
	}

	public OnedayDto() {
		// TODO Auto-generated constructor stub
	}
	
	public OnedayDto(String oneday_seq, String note_seq, String oneday_delflag, String oneday_title, String onedate,
			String reportchk, String one_readcnt, String note_public) {
		super();
		this.oneday_seq = oneday_seq;
		this.note_seq = note_seq;
		this.oneday_delflag = oneday_delflag;
		this.oneday_title = oneday_title;
		this.onedate = onedate;
		this.reportchk = reportchk;
		this.one_readcnt = one_readcnt;
		this.note_public = note_public;
	}

	public OnedayDto(String oneday_seq, String note_seq, String oneday_delflag, String oneday_title, String onedate,
			String reportchk, String one_readcnt, String note_public, List<PlaceDto> placeDto) {
		super();
		this.oneday_seq = oneday_seq;
		this.note_seq = note_seq;
		this.oneday_delflag = oneday_delflag;
		this.oneday_title = oneday_title;
		this.onedate = onedate;
		this.reportchk = reportchk;
		this.one_readcnt = one_readcnt;
		this.note_public = note_public;
		this.placeDto = placeDto;
	}

	public List<PlaceDto> getPlaceDto() {
		return placeDto;
	}

	public void setPlaceDto(List<PlaceDto> placeDto) {
		this.placeDto = placeDto;
	}

	
	public String getNote_seq() {
		return note_seq;
	}
	
	public void setNote_seq(String note_seq) {
		this.note_seq = note_seq;
	}
	public String getOneday_seq() {
		return oneday_seq;
	}
	public void setOneday_seq(String oneday_seq) {
		this.oneday_seq = oneday_seq;
	}
	public String getOneday_delflag() {
		return oneday_delflag;
	}
	public void setOneday_delflag(String oneday_delflag) {
		this.oneday_delflag = oneday_delflag;
	}
	public String getOneday_title() {
		return oneday_title;
	}
	public void setOneday_title(String oneday_title) {
		this.oneday_title = oneday_title;
	}
	public String getOnedate() {
		return onedate;
	}
	public void setOnedate(String onedate) {
		this.onedate = onedate;
	}
	public String getReportchk() {
		return reportchk;
	}
	public void setReportchk(String reportchk) {
		this.reportchk = reportchk;
	}
	public String getOne_readcnt() {
		return one_readcnt;
	}
	public void setOne_readcnt(String one_readcnt) {
		this.one_readcnt = one_readcnt;
	}
	public String getNote_public() {
		return note_public;
	}
	public void setNote_public(String note_public) {
		this.note_public = note_public;
	}

}
