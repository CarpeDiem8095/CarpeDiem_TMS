package com.cp.tms.model.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.PlaceDto;

@Service
public class PlaceServiceImpl implements IPlaceService {

	@Autowired
	IPlaceDao dao;

	@Override
	public boolean writePlace(PlaceDto dto) {
		return dao.writePlace(dto);
	}

	@Override
	public boolean modifyUpPlace1(PlaceDto dto) {
		return dao.modifyUpPlace1(dto);
	}


	@Override
	public boolean modifyUpPlace2(PlaceDto dto) {
		return dao.modifyUpPlace2(dto);
	}


	@Override
	public boolean modifyDownPlace1(PlaceDto dto) {
		return dao.modifyDownPlace1(dto);
	}


	@Override
	public boolean modifyDownPlace2(PlaceDto dto) {
		return dao.modifyDownPlace2(dto);
	}

	/* 사용하는 seq의 값이 같기 때문에 괜찮음*/
	@Transactional
	@Override
	public boolean stepMinusNdelPlace(String seq, PlaceDto dto) {
		boolean isc1 =dao.stepMinus(dto);
		boolean isc2 =dao.delPlace(seq);
		return (isc1 && isc2)?true:false;
	}

	@Override
	public boolean addMemo(PlaceDto dto) {
		return dao.addMemo(dto);
	}

	@Override
	public PlaceDto reviewList(String seq) {
		return dao.reviewList(seq);
	}

	@Override
	public PlaceDto viewPath(PlaceDto dto) {
		return dao.viewPath(dto);
	}

	@Override
	public PlaceDto viewPathFirst(PlaceDto dto) {
		return dao.viewPathFirst(dto);
	}

}
