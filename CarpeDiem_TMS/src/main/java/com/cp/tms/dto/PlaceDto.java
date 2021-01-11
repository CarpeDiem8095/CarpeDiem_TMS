package com.cp.tms.dto;

public class PlaceDto {

	private String place_seq;
	private String oneday_seq;
	private String step;
	private String place_name;
	private String xlat;
	private String ylng;
	private String memo;
	
	public String getPlace_seq() {
		return place_seq;
	}
	public void setPlace_seq(String place_seq) {
		this.place_seq = place_seq;
	}
	public String getOneday_seq() {
		return oneday_seq;
	}
	public void setOneday_seq(String oneday_seq) {
		this.oneday_seq = oneday_seq;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getXlat() {
		return xlat;
	}
	public void setXlat(String xlat) {
		this.xlat = xlat;
	}
	public String getYlng() {
		return ylng;
	}
	public void setYlng(String ylng) {
		this.ylng = ylng;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public String toString() {
		return "PlaceDto [place_seq=" + place_seq + ", oneday_seq=" + oneday_seq + ", step=" + step + ", place_name="
				+ place_name + ", xlat=" + xlat + ", ylng=" + ylng + ", memo=" + memo + "]";
	}
	public PlaceDto(String place_seq, String oneday_seq, String step, String place_name, String xlat, String ylng,
			String memo) {
		super();
		this.place_seq = place_seq;
		this.oneday_seq = oneday_seq;
		this.step = step;
		this.place_name = place_name;
		this.xlat = xlat;
		this.ylng = ylng;
		this.memo = memo;
	}
	
	public PlaceDto() {
	}
	
}
