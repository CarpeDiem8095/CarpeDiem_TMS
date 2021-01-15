package com.cp.tms.model.comment;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.CommentDto;

public interface ICommentService {

	public List<CommentDto> commnetList(String one_seq);
	
	public boolean writeComment(CommentDto dto);
	
	public boolean reply(CommentDto dto);
	
	public boolean modifyComment(Map<String, Object> map);
	
	public boolean delComment(CommentDto dto);
}
