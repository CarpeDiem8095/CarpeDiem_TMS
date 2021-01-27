package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;

import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.Member;
import com.cp.tms.dto.UserDto;
import com.cp.tms.model.chat.ITripchatService;

@Controller
public class TripChatController implements ServletConfigAware {
	private ServletContext servletContext;
	
	@Autowired
	private ITripchatService tripchatservice;
	
	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
	}
	
	@RequestMapping(value = "/mainchat.do", method = RequestMethod.POST)
	@ResponseBody
	public void loginChat(HttpSession session,String userid,Model model) {
		String gr_id = "main";
		session.setAttribute("chat_id", userid);
		HashMap<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		if (chatList == null) {
			chatList = new HashMap<String, String>();
			chatList.put(userid,gr_id);
			servletContext.setAttribute("chatList", chatList);
		} else {
			chatList.put(userid,gr_id);
			servletContext.setAttribute("chatList", chatList);
		}
	}
	
	@RequestMapping(value = "/selmychatboard.do",method = RequestMethod.POST)
	@ResponseBody
	public void selmychatboard(HttpSession session) {
		Member mDto=(Member)session.getAttribute("mDto");
		List<ChatingDto> myChatLists=tripchatservice.selmychatboard(mDto.getEmail());
		session.setAttribute("myChatLists", myChatLists);
		
	}
	
	
	@RequestMapping(value = "/viewChatList.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Map<String, String>> viewChatList() {
		Map<String, Map<String, String>> map = new HashMap<String, Map<String, String>>();
		Map<String, String> chatList = (HashMap<String, String>) servletContext.getAttribute("chatList");
		map.put("list", chatList);
		System.out.println(map.get("list"));
		return map;
	}
	
	@RequestMapping(value = "/socketOpen.do", method = RequestMethod.GET)
	public String socketOpen(HttpSession session,ChatingDto dto, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatmyid",session.getAttribute("chat_id"));
		map.put("chatyourid", dto.getChatyourid());
		ChatingDto seldto=tripchatservice.selchatboardcontent(map);
		if(seldto == null) {
			dto.setChatmyid((String)session.getAttribute("chat_id"));
			boolean isc=tripchatservice.chatboardinsert(dto);
			System.out.println("채팅생성 : "+isc);
			seldto=tripchatservice.selchatboardcontent(map);
		}else {
			seldto=tripchatservice.selchatboardcontent(map);
		}
		if(seldto.getReport_status()=="Y") {
			return "main/TripMainpage";
		}
		seldto.setChatgroupid(dto.getChatgroupid());
		model.addAttribute("chatDto", seldto);
		session.setAttribute("gr_id", seldto.getChatgroupid());
		return "chattingroom/chatingroom";
	}
	
	@RequestMapping(value = "/socketOpen2", method = RequestMethod.GET)
	public String socketOpen2(HttpSession session,ChatingDto dto, Model model) {
		System.out.println("상대방아이디는?" + dto.getChatyourid());
		System.out.println("그룹아이디는?" + dto.getChatgroupid());
		System.out.println(dto);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatmyid",dto.getChatmyid());
		map.put("chatyourid", dto.getChatyourid());
		// 가져오기
		ChatingDto seldto=tripchatservice.selchatboardcontent(map);
		seldto.setChatgroupid(dto.getChatgroupid());
		model.addAttribute("chatDto", seldto);
		model.addAttribute("mychatid",(String)session.getAttribute("chat_id"));
		session.setAttribute("gr_id", seldto.getChatgroupid());
		return "chattingroom/chatingroom";
	}
	
	@RequestMapping(value = "/chatboardcontentinsert.do",method = RequestMethod.POST)
	@ResponseBody
	public String updateChat(HttpSession session,ChatingDto dto) {
		System.out.println("groupid :"+dto.getChatgroupid());
		System.out.println("content :"+dto.getChatcontent());
		String [] chatgroup=dto.getChatgroupid().split(",");
		System.out.println("그룹 쪼개기 1 : "+chatgroup[0] +"그룹 쪼개기 2"+chatgroup[1]);
		dto.setChatmyid(chatgroup[0]);
		dto.setChatyourid(chatgroup[1]);
		boolean	isc =tripchatservice.chatboardcontentinsert(dto);
		System.out.println(dto);
		return isc == true ? "성공" : "실패";
	}
	
	@RequestMapping(value = "/reportchatboard.do", method = RequestMethod.POST)
	@ResponseBody
	public String reportchatboard(String groupid) {
		System.out.println(groupid);
		boolean isc=tripchatservice.reportchatboard(groupid);
		return isc == true ? "신고성공" : "신고실패";
	}
	
	@RequestMapping(value = "/delchatboard.do",method = RequestMethod.POST)
	@ResponseBody
	public String chatdel(ChatingDto dto) {
		System.out.println("삭제");
		System.out.println(dto);
		boolean isc=tripchatservice.delchatboard(dto);
		return isc== true ?"삭제성공":"삭제실패";
	}
}



