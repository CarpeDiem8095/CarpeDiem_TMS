package com.cp.tms.model.schedule;

import com.cp.tms.dto.PlaceDto;

public interface IPlaceService {
	public boolean writePlace(PlaceDto dto);

	public boolean modifyUpPlace(PlaceDto dto);


	public boolean modifyDownPlace(PlaceDto dto);

	public boolean stepMinusNdelPlace(String seq);

	public boolean addMemo(PlaceDto dto);
}
