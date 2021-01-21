package com.cp.tms.ctrl;


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
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.CommentDto;
import com.cp.tms.dto.Member;
import com.cp.tms.model.comment.ICommentService;

@Controller
public class CommentController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private ICommentService service;
	
	@RequestMapping(value = "/commnetList.do", method=RequestMethod.GET)
	public String commnetList(String oneday_seq,Model model) {
		//System.out.println("댓글 게시판 Welcome! 하루 일정 seq : " + oneday_seq);
		model.addAttribute("commentList", service.commnetList(oneday_seq));
		model.addAttribute("oneday_seq", oneday_seq);
		return "review/commentBoard";
	}
	
	
	// 댓글 작성
	@RequestMapping(value = "/writeComment.do", method = RequestMethod.POST)
	public String writeComment(CommentDto dto, HttpServletRequest req, HttpSession session) {
		
		Member mDto = (Member)session.getAttribute("mDto");
		System.out.println("로그인 된 사용자 : " + mDto);
		dto.setEmail(mDto.getEmail());
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
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/delComment.do",method=RequestMethod.GET)
	@ResponseBody
	public String delComment(CommentDto dto, HttpServletRequest req) {
		String oneday_seq = req.getParameter("oneday_seq");
		JSONObject json = new JSONObject();
		
		System.out.println("삭제에서 받아오는 dto : " + dto);
		boolean isc = service.delComment(dto);
		System.out.println(isc);
		System.out.println("삭제 후에 받는 oneday_seq : " + oneday_seq);

		json.put("result", isc);
		return json.toString();
	}
	
	
	// 댓글 수정 폼 
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/modifyCommForm.do", method = RequestMethod.GET,
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String modifyCommForm(String comm_seq, CommentDto dto) {
		//System.out.println("수정할 글의 seq : " + comm_seq);
		JSONObject json = new JSONObject();
		
		dto.setComm_seq(comm_seq);
		//System.out.println("comm_seq dto에 집어 넣기 : " + comm_seq);
		CommentDto newDto = service.getOneComment(dto);
		//System.out.println("service로 가져온 dto : "+newDto);
		//json.put("comm_seq", comm_seq);
		//json.put("newDto", newDto);
		//System.out.println(newDto.getContent());
		//System.out.println(newDto.getComm_seq());
		json.put("content", newDto.getContent());
		json.put("comm_seq",newDto.getComm_seq());
		
		return json.toString();
		
	}
	
	// 댓글 수정 
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/modifyComment.do", method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String modifyComment(String moval_comm_seq, String content) {
		
		System.out.println(moval_comm_seq);
		String[] moval =  moval_comm_seq.split("/");
		String modifyVal = moval[0];
		String comm_seq = moval[1];
		
		System.out.println(modifyVal);
		System.out.println(comm_seq);
		
		CommentDto dto = new CommentDto();
		dto.setComm_seq(comm_seq);
		dto.setContent(modifyVal);
		
//		CommentDto newDto = service.getOneComment(dto);
//		
//		System.out.println("수정 할 dto : " + newDto);
		
		boolean isc = service.modifyComment(dto);
		
		
		JSONObject json = new JSONObject();
		

		System.out.println("수정 결과 : " + isc);
		json.put("result", isc);
		return json.toString();
	}
}
