package com.cp.tms.model.schedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cp.tms.dto.PlaceDto;

@Service
public class PlaceServiceImpl implements IPlaceService {

	@Autowired
	IPlaceDao dao;

	@Override
	public boolean writePlace(PlaceDto dto) {
		return dao.writePlace(dto);
	}

	/* 사용하는 dto의 값이 다른데 이건 아닌 것 같음*/
	@Transactional
	@Override
	public boolean modifyUpPlace(PlaceDto dto) {
		boolean isc1 = dao.modifyUpPlace1(dto);
		boolean isc2 = dao.modifyUpPlace2(dto);
		return (isc1 || isc2)?true:false;
	}

	/* 사용하는 dto의 값이 다른데 이건 아닌 것 같음*/
	@Transactional
	@Override
	public boolean modifyDownPlace(PlaceDto dto) {
		boolean isc1 = dao.modifyDownPlace1(dto);
		boolean isc2 = dao.modifyDownPlace2(dto);
		return (isc1 || isc2)?true:false;
	}

	/* 사용하는 seq의 값이 같기 때문에 괜찮음*/
	@Transactional
	@Override
	public boolean stepMinusNdelPlace(String seq) {
		boolean isc1 =dao.stepMinus(seq);
		boolean isc2 =dao.delPlace(seq);
		return (isc1 || isc2)?true:false;
	}

	@Override
	public boolean addMemo(PlaceDto dto) {
		return dao.addMemo(dto);
	}

	@Override
	public PlaceDto reviewList(String seq) {
		return dao.reviewList(seq);
	}

}
