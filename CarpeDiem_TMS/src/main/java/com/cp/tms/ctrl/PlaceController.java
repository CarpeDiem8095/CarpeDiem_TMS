package com.cp.tms.ctrl;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.PlaceDto;
import com.cp.tms.model.schedule.IOneDayService;
import com.cp.tms.model.schedule.IPlaceService;

@Controller
public class PlaceController {

	@Autowired
	IPlaceService service;
	
	@Autowired
	IOneDayService oService;
	
	@RequestMapping(value = "/insertPlace.do", method = RequestMethod.POST)
	public String insertPlace(String placeName, String day, String myX, String myY, String note_seq, String selDate) {
		
		String Xlat = myX.substring(0,11);
		String Ylng = myY.substring(0,11);
		
		PlaceDto dto = new PlaceDto();
		dto.setOneday_seq(day);
		dto.setPlace_name(placeName);
		dto.setXlat(Xlat);
		dto.setYlng(Ylng);
		System.out.println(dto);
		boolean isc = service.writePlace(dto);
		
		
		
		return isc?"redirect:/insertPlacePage.do?seq="+day+"&noteSeq="+note_seq+"&selDate="+selDate+"":"error";
	}

//	@RequestMapping(value = "/insertPlace.do", method = RequestMethod.POST, 
//			produces = "application/text; charset=UTF-8;")
//	@ResponseBody
//	public String insertPlace(String placeName, String day, String myX, String myY, String note_seq){
//		String Xlat = myX.substring(0,11);
//		String Ylng = myY.substring(0,11);
//		
//		
//		PlaceDto dto = new PlaceDto();
//		dto.setOneday_seq(day);
//		dto.setPlace_name(placeName);
//		dto.setXlat(Xlat);
//		dto.setYlng(Ylng);
//		System.out.println(dto);
//		boolean isc = service.writePlace(dto);
//		
//		
//		return "";
//	}
	
	@RequestMapping(value="/delPlace.do", method = RequestMethod.POST,		
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String delPlace(String placeSeq, String onedaySeq) {
		
		PlaceDto dto = new PlaceDto();
		dto.setPlace_seq(placeSeq);
		dto.setOneday_seq(onedaySeq);
		
		boolean isc = service.stepMinusNdelPlace(placeSeq, dto);
		
		return null;
	}
	
	@RequestMapping(value="/selDetailOneday.do", method = RequestMethod.GET)
	public String selDetailOneday(Model model, String seq) {
		
		List<OnedayDto> selDetailOneday = oService.selDetailOneday(seq);
		model.addAttribute("selDetailOneday", selDetailOneday);
		model.addAttribute("oneday_seq", seq);
		return selDetailOneday.size()>0?"schedules/onedayAllPlace":"error";
	}
	
	@RequestMapping(value="/modifyUpPlace.do", method = RequestMethod.POST,		
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String modifyUpPlace(String onedaySeq, String placeSeq) {
//		System.out.println(onedaySeq);
		/*받은 seq로 해당 장소 특정*/
		PlaceDto change1 = new PlaceDto();
		change1.setOneday_seq(onedaySeq);
		change1.setPlace_seq(placeSeq);
		
		PlaceDto stepDown = service.viewPath(change1);
		stepDown.setOneday_seq(onedaySeq);
		/* onedaySeq와 step값으로 바꿀 장소 가져오기
		 * 이유 : 하루 일정의 step은 중복이 안됨
		 * */
		int step = Integer.parseInt(stepDown.getStep())-1;
		System.out.println(step);
		
		PlaceDto change2 = new PlaceDto();
		change2.setOneday_seq(onedaySeq);
		change2.setStep(String.valueOf(step));
		
		change2 = service.viewPathFirst(change2);
		
		PlaceDto stepUp = service.viewPath(change2);
		stepUp.setOneday_seq(onedaySeq);
		
		System.out.println("(현재 선택된) step 다운 시킬 장소 :"+stepDown.getPlace_name()+stepDown.getStep());
		System.out.println("(위에 장소인) step 업 시킬 장소 :"+stepUp.getPlace_name()+stepUp.getStep());
		
		boolean isc1 = service.modifyUpPlace1(stepDown);
		
		
		System.out.println(isc1+"성공?실패?");
		
		boolean isc2 = service.modifyUpPlace2(stepUp);
		
		System.out.println(isc2+"성공?실패?");
		
		return null;
	}
	
	@RequestMapping(value="/modifyDownPlace.do", method = RequestMethod.POST,		
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String modifyDownPlace(String onedaySeq, String placeSeq) {
		/*받은 seq로 해당 장소 특정*/
		PlaceDto change1 = new PlaceDto();
		change1.setOneday_seq(onedaySeq);
		change1.setPlace_seq(placeSeq);
		
		PlaceDto stepUp = service.viewPath(change1);
		stepUp.setOneday_seq(onedaySeq);
		/* onedaySeq와 step값으로 바꿀 장소 가져오기
		 * 이유 : 하루 일정의 step은 중복이 안됨
		 * */
		int step = Integer.parseInt(stepUp.getStep())+1;
		System.out.println(step);
		
		PlaceDto change2 = new PlaceDto();
		change2.setOneday_seq(onedaySeq);
		change2.setStep(String.valueOf(step));
		
		change2 = service.viewPathFirst(change2);
		
		PlaceDto stepDown = service.viewPath(change2);
		stepDown.setOneday_seq(onedaySeq);
		
		System.out.println("(현재 선택된) step 다운 시킬 장소 :"+stepUp.getPlace_name()+stepUp.getStep());
		System.out.println("(위에 장소인) step 업 시킬 장소 :"+stepDown.getPlace_name()+stepDown.getStep());
		
		boolean isc1 = service.modifyDownPlace1(stepUp);
		
		
		System.out.println(isc1+"성공?실패?");
		
		boolean isc2 = service.modifyDownPlace2(stepDown);
		
		System.out.println(isc2+"성공?실패?");
		
		return null;
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/viewPath", method = RequestMethod.POST, 
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String viewPath(String onedaySeq, String placeSeq) {
		
		PlaceDto path1 = new PlaceDto();
		PlaceDto path2 = new PlaceDto();
		
		path1.setOneday_seq(onedaySeq);
		path1.setPlace_seq(placeSeq);
		path1 = service.viewPath(path1);
		
		path1.getPlace_name();
		
		int step = Integer.parseInt(path1.getStep())-1;
		System.out.println(step);
		
		path2.setOneday_seq(onedaySeq);
		path2.setStep(String.valueOf(step));
		path2 = service.viewPathFirst(path2);
		
		
//		System.out.println(path2);
//		System.out.println(path1);
		
//		String firstPName = path2.getPlace_name();
//		String secondPName = path1.getPlace_name();
		
		JSONObject json = new JSONObject();
		json.put("firstPName", path2.getPlace_name());
		json.put("secondPName", path1.getPlace_name());
		
		return json.toString();
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/showMemo", method = RequestMethod.POST,
			produces = "application/text; charset=UTF-8;")
	@ResponseBody
	public String showMemo(String onedaySeq, String placeSeq) {
		
		PlaceDto dto = new PlaceDto();
		dto.setOneday_seq(onedaySeq);
		dto.setPlace_seq(placeSeq);
		
		dto = service.viewPath(dto);
		dto.setOneday_seq(onedaySeq);
		
		JSONObject json = new JSONObject();
		json.put("memo",dto.getMemo());
		json.put("placeSeq", dto.getPlace_seq());
		json.put("onedaySeq", dto.getOneday_seq());
		
		return json.toString();
	}
	
}
