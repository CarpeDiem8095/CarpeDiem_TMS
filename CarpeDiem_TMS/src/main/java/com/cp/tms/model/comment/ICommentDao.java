package com.cp.tms.model.comment;

import java.util.List;
import java.util.Map;

import com.cp.tms.dto.CommentDto;

public interface ICommentDao {

	public List<CommentDto> commnetList(String one_seq);
	
	public boolean writeComment(CommentDto dto);
	
	public boolean updateReply(CommentDto dto);
	
	public boolean writeReply(CommentDto dto);
	
	public boolean modifyComment(CommentDto dto);
	
	public boolean delComment(CommentDto dto);
	
	public CommentDto getOneComment(CommentDto dto);
}
