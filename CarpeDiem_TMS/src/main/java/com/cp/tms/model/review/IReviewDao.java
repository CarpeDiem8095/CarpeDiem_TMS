package com.cp.tms.model.review;

import com.cp.tms.dto.ReviewDto;

public interface IReviewDao {

	public boolean writeReveiw(ReviewDto dto);
}
