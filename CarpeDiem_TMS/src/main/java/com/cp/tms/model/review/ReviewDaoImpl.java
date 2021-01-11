package com.cp.tms.model.review;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.ReviewDto;

@Repository
public class ReviewDaoImpl implements IReviewDao {

	private final String NS = "com.cp.tms.dto.ReviewDto.";
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public boolean writeReveiw(ReviewDto dto) {
		int cnt = session.insert(NS+"writeReveiw", dto);
		return cnt>0?true:false;
	}

}
