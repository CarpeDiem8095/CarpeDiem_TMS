package com.cp.tms.dto;

import java.io.Serializable;

public class ReviewDto implements Serializable{

	private static final long serialVersionUID = -17914218884959450L;
	
	private String place_seq;
	private String uuid_name;
	private String origin_name;
	private String img_url;
	private String review_title;
	private String content;
	
	public ReviewDto() {
		// TODO Auto-generated constructor stub
	}

	public ReviewDto(String place_seq, String uuid_name, String origin_name, String img_url, String review_title,
			String content) {
		super();
		this.place_seq = place_seq;
		this.uuid_name = uuid_name;
		this.origin_name = origin_name;
		this.img_url = img_url;
		this.review_title = review_title;
		this.content = content;
	}

	@Override
	public String toString() {
		return "ReviewDto [place_seq=" + place_seq + ", uuid_name=" + uuid_name + ", origin_name=" + origin_name
				+ ", img_url=" + img_url + ", review_title=" + review_title + ", content=" + content + "]";
	}

	public String getPlace_seq() {
		return place_seq;
	}

	public void setPlace_seq(String place_seq) {
		this.place_seq = place_seq;
	}

	public String getUuid_name() {
		return uuid_name;
	}

	public void setUuid_name(String uuid_name) {
		this.uuid_name = uuid_name;
	}

	public String getOrigin_name() {
		return origin_name;
	}

	public void setOrigin_name(String origin_name) {
		this.origin_name = origin_name;
	}

	public String getImg_url() {
		return img_url;
	}

	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
