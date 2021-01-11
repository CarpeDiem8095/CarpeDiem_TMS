package com.cp.tms.model.tripsearchboard;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.TripboadDto;

@Repository
public class TripsearchboardImplDao implements ITripsearchboardDao {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private String NS ="com.cp.tms.model.tripsearchboard.";
	
	@Autowired
	private SqlSessionTemplate sqlsessiontemplate;
	
	@Override
	public List<TripboadDto> tripboardselectadmin(Map<String, Object> map) {
		logger.info("tripboardselectadmin 동행찾기 게시판 조회 페이징");
		return sqlsessiontemplate.selectList(NS+"tripboardselectadmin", map);
	}

	@Override
	public List<TripboadDto> tripboardselectuser(Map<String, Object> map) {
		logger.info("tripboardselectuser 동행찾기 게시판 조회 페이징");
		return sqlsessiontemplate.selectList(NS+"tripboardselectuser", map);
	}

	@Override
	public boolean tripboardinsert(TripboadDto dto) {
		logger.info("tripboardinsert 동행찾기 게시판 입력 페이징");
		return (sqlsessiontemplate.insert(NS+"tripboardinsert", dto)>0)?true:false;
	}

	@Override
	public boolean delfalgtripboarduser(Map<String, Object> map) {
		logger.info("delfalgtripboarduser 동행찾기 게시판 삭제 페이징");
		return (sqlsessiontemplate.update(NS+"delfalgtripboarduser", map)>0)?true:false;
	}

	@Override
	public boolean delfalgtripboardadmin(int seq) {
		logger.info("delfalgtripboardadmin 동행찾기 게시판 삭제 페이징");
		return (sqlsessiontemplate.update(NS+"delfalgtripboardadmin", seq)>0)?true:false;
	}

	@Override
	public int countboard() {
		logger.info("countboard 권한에 따른 동행찾기 게시판 개수");
		return sqlsessiontemplate.selectOne(NS+"countboard");
	}

}
