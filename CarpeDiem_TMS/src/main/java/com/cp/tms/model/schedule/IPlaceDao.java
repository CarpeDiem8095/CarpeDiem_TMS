package com.cp.tms.model.schedule;

import com.cp.tms.dto.PlaceDto;

public interface IPlaceDao {
	public boolean writePlace(PlaceDto dto);

	public boolean modifyUpPlace1(PlaceDto dto);

	public boolean modifyUpPlace2(PlaceDto dto);

	public boolean modifyDownPlace1(PlaceDto dto);

	public boolean modifyDownPlace2(PlaceDto dto);

	public boolean stepMinus(String seq);

	public boolean delPlace(String seq);

	public boolean addMemo(PlaceDto dto);
	
	public PlaceDto reviewList(String seq);
}
