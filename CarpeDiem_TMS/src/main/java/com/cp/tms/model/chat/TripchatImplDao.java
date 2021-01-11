package com.cp.tms.model.chat;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.UserDto;

@Repository
public class TripchatImplDao implements ITripchatDao {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private String NS ="com.cp.tms.model.chat.";
	
	@Autowired
	private SqlSessionTemplate sqlsessiontemplate;
	
	@Override
	public boolean chatboardinsert(ChatingDto dto) {
		logger.info("chatboardinsert 채팅방 생성");
		return (sqlsessiontemplate.insert(NS+"chatboardinsert", dto)>0)?true:false;
	}

	@Override
	public boolean chatboardupdate(Map<String, Object> map) {
		logger.info("chatboardupdate 채팅방 시간 업데이트");
		return (sqlsessiontemplate.update(NS+"chatboardupdate", map)>0)?true:false;
	}

	@Override
	public ChatingDto selchatboardcontent(Map<String, Object> map) {
		logger.info("selchatboardcontent 채팅방 내용가져오기");
		return sqlsessiontemplate.selectOne(NS+"selchatboardcontent", map);
	}

	@Override
	public boolean delchatboard(ChatingDto dto) {
		logger.info("delchatboard 채팅방 삭제");
		return (sqlsessiontemplate.delete(NS+"delchatboard",dto)>0)?true:false;
	}

	@Override
	public boolean chatboardcontentinsert(ChatingDto dto) {
		logger.info("chatboardcontentinsert 채팅방 내용입력");
		return (sqlsessiontemplate.insert(NS+"chatboardcontentinsert", dto)>0)?true:false;
	}

	@Override
	public List<ChatingDto> selmychatboard(String chatMyId) {
		logger.info("selmychatboard 내 채팅방 생성");
		return sqlsessiontemplate.selectList(NS+"selmychatboard", chatMyId);
	}

	@Override
	public UserDto logintest(String userid) {
		return sqlsessiontemplate.selectOne(NS+"logintest", userid);
	}

}
