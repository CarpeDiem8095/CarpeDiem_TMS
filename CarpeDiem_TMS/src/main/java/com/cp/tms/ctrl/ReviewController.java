package com.cp.tms.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.ReviewDto;
import com.cp.tms.model.review.IReviewService;
import com.cp.tms.model.schedule.IOneDayService;
import com.cp.tms.model.schedule.IPlaceService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



@Controller
public class ReviewController {

	@Autowired
	private IReviewService service;
	
	@Autowired
	private IPlaceService plService;
	
	@Autowired
	private IOneDayService oneService;
	
	@RequestMapping(value="/reviewForm.do", method = RequestMethod.GET)
	public String reviewForm() {
		
		return "reviewForm";
	}
	
	// 테이블 리스트로 이동
	@RequestMapping(value = "/onedayTableList.do", method = RequestMethod.GET)
	public String onedayTableList(Model model, String oneday_seq) {
		System.out.println("테이블 게시판 이동 : "+oneday_seq);
		model.addAttribute("onedayList", oneService.selDetailOneday(oneday_seq));
		model.addAttribute("oneday_seq", oneday_seq);
		System.out.println(oneService.selDetailOneday(oneday_seq));
		return "onedayTableList";
	}
	
	// 글 작성 
	@RequestMapping(value = "/fileUpload.do", method=RequestMethod.POST)
	//@ResponseBody
	public String fileUpload(HttpServletRequest req, Model model, ReviewDto dto) throws IOException {
		
		
		// 경로
		String path = req.getSession().getServletContext().getRealPath("/");
	
		String directory = path+"uploadFiles";
		//System.out.println("절대경로 :"+directory);
		int maxPortSize = 10*1024*1024; // 1kb -> 1Mb -> 10Mb
		String encoding = "UTF-8";

		MultipartRequest multi = new MultipartRequest(req, directory, maxPortSize, encoding, new DefaultFileRenamePolicy());

		String oneday_seq = multi.getParameter("oneday_seq");
		
		String content = multi.getParameter("content");
		String place_seq = multi.getParameter("place_seq");
		System.out.println("fileupload place seq : " + place_seq);
		
		System.out.println("받아오는 컨텐트 값 : "+content);
		
		// 파일 내용 
		String origin_name = multi.getOriginalFileName("filename");
		
		System.out.println("전달 받은 파일명 :"+origin_name);
		
		// 파일 받기
		String uuid_name = UUID.randomUUID().toString().replaceAll("-", "");
		origin_name.substring(origin_name.lastIndexOf("."));
			
		System.out.println("저장 할 파일 명 : "+uuid_name);
			
		dto.setOrigin_name(origin_name);
		dto.setUuid_name(uuid_name);
		dto.setImg_url(directory);
		dto.setPlace_seq(place_seq);
		dto.setContent(content);
		
		System.out.println("완성된 파일 DTO : "+ dto);
		
		
		// 서비스 실행
		boolean isc = service.writeReveiw(dto);
		System.out.println(isc);
		
//		File oldFile = new File(directory+"/"+multi.getFilesystemName("filename"));
//		File newFile = new File(directory+"/"+uuid_name);
//		oldFile.renameTo(newFile);
		
		
		return "redirect:/selDetailOneday.do?seq="+oneday_seq;
				//"redirect:/reviewsList.do?one_seq="+one_seq;
				
				
	}
	
	
	//조회 
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/reviewList.do", method= RequestMethod.GET,
			produces = "application/text; charset=UTF-8;"			)
	@ResponseBody
	public String reviewList(String place_seq) {
		
		JSONObject json = new JSONObject();
		System.out.println("조회 아작스 seq : " + place_seq);
		
		ReviewDto dto = new ReviewDto();
		
		if(service.reviewList(place_seq) == null) {
			System.out.println("x");
		
			return json.toString();
	
		}else{
			
			dto = service.reviewList(place_seq);
			System.out.println("조회 아작스 dto : " + dto);
			json.put("place_seq", dto.getPlace_seq());
			json.put("content", dto.getContent());
			json.put("origin_name", dto.getOrigin_name());
			json.put("uuid_name", dto.getOrigin_name());
			
			return json.toString();
		}
	}
	
	
	// 수정 폼 생성 
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value = "/modifyRevForm.do", method = RequestMethod.GET,
//			produces = "application/text; charset=UTF-8;")
//	@ResponseBody
//	public String modifyRevForm(String place_seq) {
//		JSONObject json = new JSONObject();
//		ReviewDto dto = new ReviewDto();
//		dto.setPlace_seq(place_seq);
//		json.put("content", dto.getContent());
//		json.put("place_seq",dto.getPlace_seq());
//		return json.toString();
//	}
	
	@RequestMapping(value="/modifyRev.do", method = RequestMethod.POST)
	public String modifyRev(HttpServletRequest req, Model model, ReviewDto dto) throws IOException {
		
		// 경로
		String path = req.getSession().getServletContext().getRealPath("/");
	
		String directory = path+"uploadFiles";
		//System.out.println("절대경로 :"+directory);
		int maxPortSize = 10*1024*1024; // 1kb -> 1Mb -> 10Mb
		String encoding = "UTF-8";

		MultipartRequest multi = new MultipartRequest(req, directory, maxPortSize, encoding, new DefaultFileRenamePolicy());

		String oneday_seq = multi.getParameter("oneday_seq");
		
		String content = multi.getParameter("content");
		String place_seq = multi.getParameter("place_seq");
		System.out.println("fileupload place seq : " + place_seq);
		
		System.out.println("받아오는 컨텐트 값 : "+content);
		
		// 파일 내용 
		String origin_name = multi.getOriginalFileName("filename");
		
		System.out.println("전달 받은 파일명 :"+origin_name);
		
		// 파일 받기
		String uuid_name = UUID.randomUUID().toString().replaceAll("-", "");
		origin_name.substring(origin_name.lastIndexOf("."));
			
		System.out.println("저장 할 파일 명 : "+uuid_name);
			
		dto.setOrigin_name(origin_name);
		dto.setUuid_name(uuid_name);
		dto.setImg_url(directory);
		dto.setPlace_seq(place_seq);
		dto.setContent(content);
		
		System.out.println("완성된 파일 DTO : "+ dto);
		
		
		// 서비스 실행
		boolean isc = service.modifyReview(dto);
		System.out.println(isc);
		
//		File oldFile = new File(directory+"/"+multi.getFilesystemName("filename"));
//		File newFile = new File(directory+"/"+uuid_name);
//		oldFile.renameTo(newFile);
		
		
		return "redirect:/selDetailOneday.do?seq="+oneday_seq;
	}
	
	// 글목록 조회 
	@RequestMapping(value="/oneBoardList.do", method=RequestMethod.GET)
	public String oneBoardList(Model model) {
		model.addAttribute("oneBoardList", service.oneBoardList());
		return "review/reviewsBoard"; 
	}
	
	// 상세 글 조회 
	@RequestMapping(value="/selOneBoard.do", method=RequestMethod.GET)
	public String reviewSelOneBoard(String oneday_seq, Model model) {
		model.addAttribute("selDetailOneday",oneService.selDetailOneday(oneday_seq));
		model.addAttribute("oneday_seq", oneday_seq);
		return "review/detailOnedayBoard";
	}
}
