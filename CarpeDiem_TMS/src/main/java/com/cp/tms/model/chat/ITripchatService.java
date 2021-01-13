package com.cp.tms.model.chat;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.UserDto;

public interface ITripchatService {
	
	/**
	 * 로그인 테스트
	 *  userid
	 */
	public UserDto logintest(String userid);
	
	/**
	 * 채팅 만들기
	 * @param dto (chatmyid,chatyourid,chatgroupid)
	 * @return T/F 성공/실패
	 */
	public boolean chatboardinsert(ChatingDto dto);
	
	/**
	 * 채팅 생성했을시 가져오기
	 * @param map (chatmyid,chatyourid)
	 * @return T/F 성공/실패
	 */
	public ChatingDto selchatboardcontent(Map<String, Object> map); 
	
	/**
	 * 채팅 삭제 하기
	 * @param dto (chatmyid, groupChatid)
	 * @return T/F 성공/ 실패
	 */
	public boolean delchatboard(ChatingDto dto);
	
	/**
	 * 채팅방에 내용 입력하기
	 * @param dto(chatmyid,chatcontent)
	 * @return
	 */
	public boolean chatboardcontentinsert(ChatingDto dto);
	
	/**
	 * 내 채팅 현황 보기
	 * @param chatMyId
	 * @return 내 채팅 현황이 나온다.
	 */
	public List<ChatingDto> selmychatboard(String chatMyId);
	
	/**
	 * 채팅 신고하기
	 * @param groupid
	 * @return 채팅 신고 완료시 채팅은 신고현황으로 넘어간다.
	 */
	public boolean reportchatboard(String groupid);
	
}
