package com.cp.tms.model.comment;

import java.util.List;

import com.cp.tms.dto.CommentDto;

public interface ICommentService {

	public List<CommentDto> commnetList(String one_seq);
	
	public boolean writeComment(CommentDto dto);
	
	public boolean reply(CommentDto dto);
	
	public boolean modifyComment(CommentDto dto);
	
	public boolean delComment(CommentDto dto);
}
