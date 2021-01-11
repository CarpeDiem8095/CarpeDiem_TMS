package com.cp.tms.dto;

public class PagingDto {

	private int selectpage;	// 내가 선택한 페이지 x
	private int countList;	// 내가 보여줄 게시글의 수 x
	private int countpage;	// 내가 보여줄 페이지의 수 x
	private int startpage;	// 시작 페이지 x
	private int lastpage;	// 마지막 페이지 x
	private int totalcount;	// 총 게시글의 수 x
	private int totalpage;	// 총 페이지 수 x
	
	public PagingDto() {
	}
	
	public PagingDto(int selectpage, int countList, int countpage, int startpage, int lastpage, int totalcount,
			int totalpage) {
		super();
		this.selectpage = selectpage;
		this.countList = countList;
		this.countpage = countpage;
		this.startpage = startpage;
		this.lastpage = lastpage;
		this.totalcount = totalcount;
		this.totalpage = totalpage;
	}
	
	@Override
	public String toString() {
		return "PagingDto [selectpage=" + selectpage + ", countList=" + countList + ", countpage=" + countpage
				+ ", startpage=" + startpage + ", lastpage=" + lastpage + ", totalcount=" + totalcount + ", totalpage="
				+ totalpage + "]";
	}
	
	// 선택한 페이지
	public int getSelectpage() {
		return selectpage;
	}
	public void setSelectpage(int selectpage) {
		
		if(totalpage < selectpage) {
			selectpage=totalpage;
		}
		
		this.selectpage = selectpage;
	}
	
	// 보여줄 게시글 수
	public int getCountList() {
		return countList;
	}
	public void setCountList(int countList) {
		this.countList = countList;
	}
	
	// 보여줄 페이지 수
	public int getCountpage() {
		return countpage;
	}
	public void setCountpage(int countpage) {
		this.countpage = countpage;
	}
	
	// 시작 페이지
	public int getStartpage() {
		return startpage;
	}
	public void setStartpage(int selectpage) {
		
		selectpage=((selectpage-1)/countpage)*countpage+1;
		
		this.startpage = selectpage;
	}
	
	//마지막 페이지
	public int getLastpage() {
		return lastpage;
	}
	
	public void setLastpage(int lastpage) {
		
		lastpage=startpage+countpage-1;
		
		if(lastpage>=totalpage) {
			lastpage=totalpage;
		}
		
		this.lastpage = lastpage;
	}
	
	// 총 게시글 수
	public int getTotalcount() {
		return totalcount;
	}
	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}
	
	// 총 페이지수
	public int getTotalpage() {
		return totalpage;
	}
	
	public void setTotalpage(int totalpage) {
		
		totalpage=totalpage/countList;
		
		if(totalcount%countList!=0) {
			totalpage++;
		}
		this.totalpage = totalpage;
	}
	
}
