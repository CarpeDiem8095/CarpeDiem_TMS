package com.cp.tms.model.review;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.ReviewDto;

public interface IReviewService {

	public boolean writeReveiw(ReviewDto dto);
	
	public ReviewDto reviewList(String place_seq);
	
	public boolean deleteReview(String place_seq);
	
	public boolean modifyReview(ReviewDto dto);

	public List<OnedayDto> oneBoardList(Map<String, Object> map);
	
	public int totalCount();
	
	public int readCount(String oneday_seq);
}
