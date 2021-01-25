package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cp.tms.dto.PagingDto;
import com.cp.tms.dto.TripboadDto;
import com.cp.tms.model.tripsearchboard.ITripsearchboardService;

@Controller
public class TripboardController {

	@Autowired
	ITripsearchboardService searchService;
	
	@RequestMapping(value = "/boardsearch.do",method = RequestMethod.GET)
	public String boardseach(Model model,String auth,String page) {
		
		if(page==null) {
			page ="1";
		}
		int selectpage = Integer.parseInt(page);
		
		PagingDto p =  new PagingDto();
		
		// 총 게시글 수
		p.setTotalcount(searchService.countboard());
		
		// 게시글 보여줄 수
		p.setCountList(10);
		
		p.setCountpage(5);
		
		p.setTotalpage(p.getTotalcount());
		
		p.setSelectpage(selectpage);
		
		p.setStartpage(selectpage);
		
		p.setLastpage(p.getCountpage());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (p.getSelectpage()-1)*p.getCountList()+1);
		map.put("last",(int)map.get("start")+p.getCountList()-1);
		
		List<TripboadDto> serchDto=searchService.tripboardselectuser(map);
		
		model.addAttribute("serchDto", serchDto);
		model.addAttribute("p", p);
		model.addAttribute("auth", auth);
		return "tripsearchboard/tripsearchboard";
	}
	
	@RequestMapping(value = "/serchboardmove.do", method = RequestMethod.GET)
	public String tripsearchboard() {
		return "tripsearchboard/serchboardwrite";
	}
	
	@RequestMapping(value = "/searchboardwrite.do",method = RequestMethod.POST)
	public String tripserchboardwrite(TripboadDto dto,Model model) {
		boolean isc=searchService.tripboardinsert(dto);
		return isc?"redirect:/boardsearch.do":"redirect:/serchboardmove.do";
	}
	
	@RequestMapping(value = "/deltripboard.do",method = RequestMethod.GET)
	public String deltripboard(TripboadDto dto,String auth) {
		
		if(auth.equals("ADMIN")) {
			searchService.delfalgtripboardadmin(dto.getSeq());
		}else {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("userid", dto.getUserid());
			map.put("seq", dto.getSeq());
			searchService.delfalgtripboarduser(map);
		}
		return "redirect:/boardsearch.do";
	}
	
}
