package com.cp.tms.ctrl;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cp.tms.dto.ReviewDto;
import com.cp.tms.model.review.IReviewService;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



@Controller
public class ReviewController {

	@Autowired
	private IReviewService service;
	
	@RequestMapping(value="/reviewForm.do", method = RequestMethod.GET)
	public String reviewForm() {

		return "reviewForm";
	}
	
	@RequestMapping(value = "/fileUpload.do", method=RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest req, Model model, ReviewDto dto) throws IOException {
		
		// 경로
		String directory = "/Users/EUNSOL/CarpeDiem_TMS_WorkSpace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps";
		
		System.out.println("절대경로 :"+directory);
		
		int maxPortSize = 10*1024*1024; // 1kb -> 1Mb -> 10Mb
		String encoding = "UTF-8";

		MultipartRequest multi = new MultipartRequest(req, directory, maxPortSize, encoding, new DefaultFileRenamePolicy());
		
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
		dto.setPlace_seq("2");
	//	dto.setContent("aaaa");
		dto.setReview_title("bbbbb");
		
		System.out.println("완성된 파일 DTO : "+ dto);
		
		// 서비스 실행
		boolean isc = service.writeReveiw(dto);
		System.out.println(isc);
		
		
		return null;
	}
	
}
