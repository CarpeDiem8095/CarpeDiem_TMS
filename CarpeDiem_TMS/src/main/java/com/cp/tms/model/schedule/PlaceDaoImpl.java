package com.cp.tms.model.schedule;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.PlaceDto;

@Repository
public class PlaceDaoImpl implements IPlaceDao{

	private String NS = "place.mapper.";
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public boolean writePlace(PlaceDto dto) {
		return session.insert(NS+"writePlace", dto)>0?true:false;
	}

	@Override
	public boolean modifyUpPlace1(PlaceDto dto) {
		return session.update(NS+"modifyUpPlace1", dto)>0?true:false;
	}

	@Override
	public boolean modifyUpPlace2(PlaceDto dto) {
		return session.update(NS+"modifyUpPlace2", dto)>0?true:false;
	}

	@Override
	public boolean modifyDownPlace1(PlaceDto dto) {
		return session.update(NS+"modifyDownPlace1", dto)>0?true:false;
	}

	@Override
	public boolean modifyDownPlace2(PlaceDto dto) {
		return session.update(NS+"modifyDownPlace2", dto)>0?true:false;
	}

	@Override
	public boolean stepMinus(PlaceDto dto) {
		return session.update(NS+"stepMinus", dto)>0?true:false;
	}

	@Override
	public boolean delPlace(String seq) {
		return session.delete(NS+"delPlace", seq)>0?true:false;
	}

	@Override
	public boolean addMemo(PlaceDto dto) {
		return session.update(NS+"addMemo", dto)>0?true:false;
	}

	@Override
	public PlaceDto reviewList(String seq) {
		return session.selectOne(NS+"reviewList", seq);
	}

}
