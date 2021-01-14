package com.cp.tms.dto;

import java.io.Serializable;
import java.util.Date;

public class ReportDto implements Serializable {

	private static final long serialVersionUID = 2712529924623742976L;
	
	private int seq;
	private String email;
	private String report_type;
	private String content;
	private Date text_regdate;
	private String processing_status;
	private String board_type;
	
	public ReportDto() {
		super();
	}

	@Override
	public String toString() {
		return "ReportDto [seq=" + seq + ", email=" + email + ", report_type=" + report_type + ", content=" + content
				+ ", text_regdate=" + text_regdate + ", processing_status=" + processing_status + ", board_type="
				+ board_type + "]";
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getReport_type() {
		return report_type;
	}

	public void setReport_type(String report_type) {
		this.report_type = report_type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getText_regdate() {
		return text_regdate;
	}

	public void setText_regdate(Date text_regdate) {
		this.text_regdate = text_regdate;
	}

	public String getProcessing_status() {
		return processing_status;
	}

	public void setProcessing_status(String processing_status) {
		this.processing_status = processing_status;
	}

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	
}
