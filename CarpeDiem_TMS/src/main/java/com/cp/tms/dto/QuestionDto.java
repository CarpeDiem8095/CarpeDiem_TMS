package com.cp.tms.dto;

import java.io.Serializable;

public class QuestionDto implements Serializable {

	private static final long serialVersionUID = -1746682995405036869L;
	
	private int seq;
	private String writer;
	private String title;
	private String content;
	private String text_pw;
	private String text_regdate;
	private String public_status;
	private String delflag;
	private int refer;
	private int depth;
	
	public QuestionDto() {
		super();
	}

	public QuestionDto(String writer, String title, String content, String text_pw, String public_status) {
		super();
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.text_pw = text_pw;
		this.public_status = public_status;
	}

	public QuestionDto(String writer, String title, String content) {
		super();
		this.writer = writer;
		this.title = title;
		this.content = content;
	}

	public QuestionDto(int seq, String writer, String title, String content) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.content = content;
	}

	@Override
	public String toString() {
		return "QuestionDto [seq=" + seq + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", text_pw=" + text_pw + ", text_regdate=" + text_regdate + ", public_status=" + public_status
				+ ", delflag=" + delflag + ", refer=" + refer + ", depth=" + depth + "]";
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getText_pw() {
		return text_pw;
	}

	public void setText_pw(String text_pw) {
		this.text_pw = text_pw;
	}

	public String getText_regdate() {
		return text_regdate;
	}

	public void setText_regdate(String text_regdate) {
		this.text_regdate = text_regdate;
	}

	public String getPublic_status() {
		return public_status;
	}

	public void setPublic_status(String public_status) {
		this.public_status = public_status;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public int getRefer() {
		return refer;
	}

	public void setRefer(int refer) {
		this.refer = refer;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}
	
}
