package com.cp.tms.model.tripsearchboard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cp.tms.dto.TripboadDto;

@Service
public class TripsearchboardImplService implements ITripsearchboardService {

	@Autowired
	private ITripsearchboardDao tripdao;
	
	@Override
	public List<TripboadDto> tripboardselectadmin(Map<String, Object> map) {
		return tripdao.tripboardselectadmin(map);
	}

	@Override
	public List<TripboadDto> tripboardselectuser(Map<String, Object> map) {
		return tripdao.tripboardselectuser(map);
	}

	@Override
	public boolean tripboardinsert(TripboadDto dto) {
		return tripdao.tripboardinsert(dto);
	}

	@Override
	public boolean delfalgtripboarduser(Map<String, Object> map) {
		return tripdao.delfalgtripboarduser(map);
	}

	@Override
	public boolean delfalgtripboardadmin(int seq) {
		return tripdao.delfalgtripboardadmin(seq);
	}

	@Override
	public int countboard() {
		return tripdao.countboard();
	}

}
