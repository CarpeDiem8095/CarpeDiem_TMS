package com.cp.tms.model.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.ReviewDto;

@Service
public class ReviewServiceImpl implements IReviewService {

	@Autowired
	private IReviewDao dao;
	
	@Override
	public boolean writeReveiw(ReviewDto dto) {
		return dao.writeReveiw(dto);
	}

}
