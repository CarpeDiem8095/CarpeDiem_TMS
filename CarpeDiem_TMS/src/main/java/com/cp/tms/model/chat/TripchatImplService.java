package com.cp.tms.model.chat;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.UserDto;

@Service
public class TripchatImplService implements ITripchatService {

	@Autowired
	private ITripchatDao ichatdao;
	
	@Override
	public boolean chatboardinsert(ChatingDto dto) {
		return ichatdao.chatboardinsert(dto);
	}

	@Transactional
	@Override
	public ChatingDto selchatboardcontent(Map<String, Object> map) {
		ChatingDto chatdto=ichatdao.selchatboardcontent(map);
		if(chatdto!=null) {
			ichatdao.chatboardupdate(map);
		}
		return chatdto;
	}

	@Override
	public boolean delchatboard(ChatingDto dto) {
		return ichatdao.delchatboard(dto);
	}

	@Override
	public boolean chatboardcontentinsert(ChatingDto dto) {
		return ichatdao.chatboardcontentinsert(dto);
	}

	@Override
	public List<ChatingDto> selmychatboard(String chatMyId) {
		return ichatdao.selmychatboard(chatMyId);
	}

	@Override
	public UserDto logintest(String userid) {
		return ichatdao.logintest(userid);
	}

	@Override
	public boolean reportchatboard(String groupid) {
		return ichatdao.reportchatboard(groupid);
	}

}
