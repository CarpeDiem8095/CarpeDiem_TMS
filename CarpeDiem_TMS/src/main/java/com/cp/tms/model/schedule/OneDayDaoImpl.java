package com.cp.tms.model.schedule;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.PlaceDto;
@Repository
public class OneDayDaoImpl implements IOneDayDao {

	private String NS = "oneday.mapper.";
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public boolean writeOneday(OnedayDto dto) {
		return session.insert(NS+"writeOneday", dto)>0?true:false;
	}

	@Override
	public boolean modifyOneday(OnedayDto dto) {
		return session.update(NS+"modifyOneday", dto)>0?true:false;
	}

	@Override
	public boolean delOneday(String seq) {
		return session.update(NS+"delOneday", seq)>0?true:false;
	}

	@Override
	public List<OnedayDto> selDetailOneday(String seq) {
		return session.selectList(NS+"selDetailOneday", seq);
	}

	@Override
	public List<OnedayDto> noteCollectOnedayAP(String note_seq) {
		return session.selectList(NS+"noteCollectOnedayAP", note_seq);
	}
	
	@Override
	public OnedayDto selOnedayOne(String oneday_seq) {
		return session.selectOne(NS+"selOnedayOne", oneday_seq);
	}

}
