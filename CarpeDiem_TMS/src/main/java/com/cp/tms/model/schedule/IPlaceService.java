package com.cp.tms.model.schedule;

import com.cp.tms.dto.PlaceDto;

public interface IPlaceService {
	public boolean writePlace(PlaceDto dto);

	public boolean modifyUpPlace1(PlaceDto dto);

	public boolean modifyUpPlace2(PlaceDto dto);

	public boolean modifyDownPlace1(PlaceDto dto);

	public boolean modifyDownPlace2(PlaceDto dto);

	public boolean stepMinusNdelPlace(String seq, PlaceDto dto);

	public boolean addMemo(PlaceDto dto);
	
	public PlaceDto reviewList(String seq);
	
	public PlaceDto viewPath(PlaceDto dto);
	public PlaceDto viewPathFirst(PlaceDto dto);
	
}
