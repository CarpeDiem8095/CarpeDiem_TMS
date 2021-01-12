package com.cp.tms.ctrl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.model.comment.ICommentService;

@Controller
public class CommentController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ICommentService service;
	
	@RequestMapping(value = "/commnetList.do", method=RequestMethod.GET)
	public String commnetList(Model model, String one_seq) {
		logger.info("댓글 게시판 : 하루 일정 seq {}",one_seq);
		model.addAttribute("commentList", service.commnetList(one_seq));
		return "commentBoard";
	}
}
