package com.cp.tms.model.review;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.OnedayDto;
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

	@Override
	public ReviewDto reviewList(String place_seq) {
		return session.selectOne(NS+"reviewList", place_seq);
	}

	@Override
	public boolean deleteReview(String place_seq) {
		int cnt = session.delete(NS+"deleteReview", place_seq);
		return cnt>0?true:false;
	}

	@Override
	public boolean modifyReview(ReviewDto dto) {
		int cnt = session.update(NS+"modifyReview", dto);
		return cnt>0?true:false;
	}

	@Override
	public List<OnedayDto> oneBoardList(Map<String, Object> map) {
		return session.selectList(NS+"oneBoardList",map);
	}

	@Override
	public int totalCount() {
		int cnt = session.selectOne(NS+"totalCount");
		return cnt;
	}

	@Override
	public int readCount(String oneday_seq) {
		int cnt = session.update(NS+"readCount",oneday_seq);
		return cnt;
	}

}
