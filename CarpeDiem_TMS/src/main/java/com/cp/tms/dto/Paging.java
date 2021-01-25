package com.cp.tms.dto;

public class Paging {

	private int page; // 현재 선택된 페이지 0
	private int countList; // 페이지당 몇 개의 게시글을 보여줄건지 1(8) 2(8) 3(1)
	private int totalCount; // 총 게시글의 개수 17
	private int countPage; // 화면에 몇 개의 페이지를 보여줄건지 
	private int totalPage; // 
	private int startPage; // 현재 화면의 시작 페이지 번호  1 / 4 / 7 
	private int endPage; // 현재 화면의 끝 페이지 번호         3 / 6 / 7
	
	public Paging() {		
	}	
	
	@Override
	public String toString() {
		return "Paging [page=" + page + ", countList=" + countList + ", totalCount=" + totalCount + ", countPage="
				+ countPage + ", totalPage=" + totalPage + ", startPage=" + startPage + ", endPage=" + endPage + "]";
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (totalPage < page) {
			page = totalPage;
		}		
		this.page = page;
	}

	public int getCountList() {
		return countList;
	}

	public void setCountList(int countList) {
		this.countList = countList;
	}

	public int getCountPage() {
		return countPage;
	}

	public void setCountPage(int countPage) {
		this.countPage = countPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		
		int totalPageResult = totalCount/countList; 
		if (totalCount%countList > 0) { 
			totalPageResult++;			
		} 
		
		this.totalPage = totalPageResult;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		
		int startPageResult = ((page-1)/countPage)*countPage+1;
		
		this.startPage = startPageResult;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		
		int endPageResult = startPage+countPage-1;
		
		if (endPageResult > totalPage) {
			endPageResult = totalPage;
		}
		
		this.endPage = endPageResult;
	}		
	
}
