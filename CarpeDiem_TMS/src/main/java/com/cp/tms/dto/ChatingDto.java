package com.cp.tms.dto;

import java.util.Date;

public class ChatingDto {

	private int seq;
	private String chatmyid;
	private String chatyourid;
	private String chatgroupid;
	private String chatcontent;
	private Date chatregdate;

	public ChatingDto() {

	}

	public ChatingDto(int seq, String chatmyid, String chatyourid, String chatgroupid, String chatcontent,
			Date chatregdate) {
		super();
		this.seq = seq;
		this.chatmyid = chatmyid;
		this.chatyourid = chatyourid;
		this.chatgroupid = chatgroupid;
		this.chatcontent = chatcontent;
		this.chatregdate = chatregdate;
	}

	@Override
	public String toString() {
		return "ChatingDto [seq=" + seq + ", chatmyid=" + chatmyid + ", chatyourid=" + chatyourid + ", chatgroupid="
				+ chatgroupid + ", chatcontent=" + chatcontent + ", chatregdate=" + chatregdate + "]";
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getChatmyid() {
		return chatmyid;
	}

	public void setChatmyid(String chatmyid) {
		this.chatmyid = chatmyid;
	}

	public String getChatyourid() {
		return chatyourid;
	}

	public void setChatyourid(String chatyourid) {
		this.chatyourid = chatyourid;
	}

	public String getChatgroupid() {
		return chatgroupid;
	}

	public void setChatgroupid(String chatgroupid) {
		this.chatgroupid = chatgroupid;
	}

	public String getChatcontent() {
		return chatcontent;
	}

	public void setChatcontent(String chatcontent) {
		this.chatcontent = chatcontent;
	}

	public Date getChatregdate() {
		return chatregdate;
	}

	public void setChatregdate(Date chatregdate) {
		this.chatregdate = chatregdate;
	}

}
