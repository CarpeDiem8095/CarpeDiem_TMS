package com.cp.tms.model.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.ReviewDto;

@Service
public class ReviewServiceImpl implements IReviewService {

	@Autowired
	private IReviewDao dao;
	
	@Override
	public boolean writeReveiw(ReviewDto dto) {
		return dao.writeReveiw(dto);
	}

	@Override
	public ReviewDto reviewList(String place_seq) {
		return dao.reviewList(place_seq);
	}

	@Override
	public boolean deleteReview(String place_seq) {
		return dao.deleteReview(place_seq);
	}

	@Override
	public boolean modifyReview(ReviewDto dto) {
		return dao.modifyReview(dto);
	}

	@Override
	public List<OnedayDto> oneBoardList(Map<String, Object> map) {
		return dao.oneBoardList(map);
	}

	@Override
	public int totalCount() {
		return dao.totalCount();
				
	}

}
