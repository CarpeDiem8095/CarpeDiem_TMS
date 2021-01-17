package com.cp.tms.model.review;

import java.util.List;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.ReviewDto;

public interface IReviewDao {

	public boolean writeReveiw(ReviewDto dto);
	
	public ReviewDto reviewList(String place_seq);
	
	public boolean deleteReview(String place_seq);
	
	public boolean modifyReview(ReviewDto dto);

	public List<OnedayDto> oneBoardList();
}
