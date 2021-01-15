package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.CommentDto;
import com.cp.tms.model.comment.ICommentService;

@Controller
public class CommentController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ICommentService service;
	
	@RequestMapping(value = "/commnetList.do", method=RequestMethod.GET)
	public String commnetList(String oneday_seq,Model model) {
		//logger.info("댓글 게시판 : 하루 일정 seq {}",oneday_seq);
		System.out.println("댓글 게시판 Welcome! 하루 일정 seq : " + oneday_seq);
		model.addAttribute("commentList", service.commnetList(oneday_seq));
		model.addAttribute("oneday_seq", oneday_seq);
		return "commentBoard";
	}
	
	
	// 댓글 작성
	@RequestMapping(value = "/writeComment.do", method = RequestMethod.POST)
	public String writeComment(CommentDto dto, HttpServletRequest req) {
		dto.setEmail("A001");
		String oneday_seq = req.getParameter("oneday_seq");
		System.out.println("댓글 작성 ing 하루 일정 seq : "+ oneday_seq);
		boolean isc = service.writeComment(dto);
		System.out.println(isc);
		
		return "redirect:/commnetList.do?oneday_seq="+oneday_seq;
	}
	
	
	// 댓글의 댓글 작성 
	@RequestMapping(value = "/writeReply.do", method = RequestMethod.POST)
	@Transactional
	public String writeReply(CommentDto dto, HttpServletRequest req) {
		String oneday_seq = req.getParameter("oneday_seq");
		dto.setEmail("A002");
	// dto.setComm_seq("37");
	//	System.out.println("댓글 댓글에서 받는 oneday_seq : " + oneday_seq);
	//	model.addAttribute(comm_seq, "comm_seq");
		boolean isc = service.reply(dto);
		System.out.println(isc);
		return "redirect:/commnetList.do?oneday_seq="+oneday_seq;
		
	}
	
	// 댓글 삭제
	@RequestMapping(value = "/delComment.do",method=RequestMethod.GET)
	@ResponseBody
	public String delComment(CommentDto dto, HttpServletRequest req) {
		String oneday_seq = req.getParameter("oneday_seq");
		
		System.out.println("삭제에서 받아오는 dto : " + dto);
		boolean isc = service.delComment(dto);
		System.out.println(isc);
		System.out.println("삭제 후에 받는 oneday_seq : " + oneday_seq);

		return "redirect:/commnetList.do?oneday_seq="+oneday_seq;
	}
}
