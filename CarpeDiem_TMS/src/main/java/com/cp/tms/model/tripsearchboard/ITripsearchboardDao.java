package com.cp.tms.model.tripsearchboard;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.TripboadDto;

public interface ITripsearchboardDao {
	
	/**
	 * admin 동행찾기게시판 페이징
	 * @param map 페이징을 위해 start랑 last가 들어감
	 * @return 페이징된 리스트를 가져옴
	 */
	public List<TripboadDto> tripboardselectadmin(Map<String, Object> map);
	
	/**
	 * user 동행찾기 게시판 페이징
	 * @param map 페이징을 위해 start랑 last가 들어감
	 * @return 페이징된 리스트를 가져옴
	 */
	public List<TripboadDto> tripboardselectuser(Map<String, Object> map);
	
	
	/**
	 *  user 동행찾기 게시판 글입력
	 * @param dto(userid,nickname,boardtitle)
	 * @return T/F 성공/실패
	 */
	public boolean tripboardinsert(TripboadDto dto);
	
	/**
	 * user 동행찾기 게시판 글 삭제
	 * @param map (userid, seq)
	 * @return T/F 성공/실패
	 */
	public boolean delfalgtripboarduser(Map<String, Object> map);
	
	/**
	 * @param seq 글번호
	 * @return
	 */
	public boolean delfalgtripboardadmin(int seq);
	
	/**
	 * @param auth 권한
	 * @return 권한에 따른 전체개수
	 */
	public int countboard();
	
}
