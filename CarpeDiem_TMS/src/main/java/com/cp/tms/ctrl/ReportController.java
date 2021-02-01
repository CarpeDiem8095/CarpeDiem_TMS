package com.cp.tms.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cp.tms.dto.Member;
import com.cp.tms.dto.Paging;
import com.cp.tms.dto.ReportDto;
import com.cp.tms.model.member.IMemberService;
import com.cp.tms.model.report.IReportService;

@Controller
public class ReportController {

	@Autowired
	private IReportService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private IMemberService mService;
	
	// 신고처리 게시판으로 이동(전체글 조회-페이징)
	@RequestMapping(value = "/reportBoard.do", method = RequestMethod.GET)
	public String reportBoard(Model model, String page) {
		if (page == null) {
			page = "1";
		}
		
		int selPage = Integer.parseInt(page);
		
		Paging p = new Paging();
		
		// 총 게시글의 수
		p.setTotalCount(service.totalCount());
		
		// 보여줄 게시글의 수
		p.setCountList(3);
				
		// 보여줄 페이지의 수
		p.setCountPage(3);
		
		// 총 페이지의 수
		p.setTotalPage(p.getTotalCount());
		
		// 선택한 페이지
		p.setPage(selPage);
		
		// 시작 페이지
		p.setStartPage(selPage);
		
		// 마지막 페이지
		p.setEndPage(p.getCountPage());
		
//		System.out.println(p);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("first", (p.getPage()-1)*p.getCountList()+1);
		map.put("last", p.getPage()*p.getCountList());
		
		List<ReportDto> rDto = service.reportboardList(map);
		
		model.addAttribute("reDto", rDto);
		model.addAttribute("page", p);
		
		System.out.println("선택된 페이지의 글 목록: "+rDto);
		System.out.println("선택된 페이지의 페이징dto: "+p);
		
		return "reportBoard/reportBoard";
	}
	
	// 상세글 조회
	@RequestMapping(value = "/reportDetail.do", method = RequestMethod.GET)
	public String reportDetail(Model model, String seq, String reporter_email, String subject_email) {
		System.out.println("상세글 seq: " + seq);
//		System.out.println("상세글 reporter_email: " + reporter_email);
//		System.out.println("상세글 subject_email: " + subject_email);
		ReportDto dto = service.reportDetailBoard(seq);
//		Member mDto = (Member)mService.allMember();
		System.out.println("상세글 결과값: " + dto);
		model.addAttribute("detail", dto);
		model.addAttribute("reporter_email", dto.getReporter_email());
		model.addAttribute("subject_email", dto.getSubject_email());
		System.out.println("신고자 email: " + dto.getReporter_email());
		System.out.println("신고대상 email: " + dto.getSubject_email());
		return "reportBoard/reportDetailBoard";
	}
	
	// 신고처리(메일 전송)
	// 메일 작성 폼으로 이동_to.신고자
	@RequestMapping(value = "/mailForm.do", method = RequestMethod.GET)
	public String mailForm(Model model, String seq, String reporter_email) {
		System.out.println("상세글 seq: " + seq);
		ReportDto dto = service.reportDetailBoard(seq);
		model.addAttribute("rDto", dto);
		model.addAttribute("reporter_email", dto.getReporter_email());
		System.out.println("상세글 reporter_email: " + reporter_email);
		return "reportBoard/mailForm";
	}
	
	// 메일 작성 폼으로 이동_to.신고대상
	@RequestMapping(value = "/mailForm2.do", method = RequestMethod.GET)
	public String mailForm2(Model model, String seq, String subject_email) {
		System.out.println("상세글 seq: " + seq);
		ReportDto dto = service.reportDetailBoard(seq);
		model.addAttribute("rDto", dto);
		model.addAttribute("subject_email", dto.getSubject_email());
		System.out.println("상세글 subject_email: " + subject_email);
		return "reportBoard/mailForm2";
	}
	
	// 메일 전송
	@RequestMapping(value = "/sendEmail.do", method = RequestMethod.POST)
	public String sendEmail(@RequestParam Map<String, String> mailMap) {
		System.out.println(mailMap.get("receiver"));
		
		// 내 메일 주소 필요
		String sender = "carpediem8095@gmail.com";
		
		// 메일의 내용을 전송하기 위한 객체  // 담아서 보내면 SMTP가 받아서 처리
		MimeMessage message = mailSender.createMimeMessage();
		
		// MimeMessage, 파일하고 text 같이 할건지 t/f, Encoding
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(sender); // 보내는 사람(생략하면 오류 발생함)
			messageHelper.setTo(mailMap.get("receiver")); // 받는 사람
			messageHelper.setSubject(mailMap.get("title")); // 메일의 제목(생략 가능함)
			messageHelper.setText(mailMap.get("content"));
//			messageHelper.setText(text, html); // 글자, true라면 전송되는 글자를 html로 인식하겠다.
//			messageHelper.setText(mailMap.get("content"),true);
			
			// MimeMessageHelper에 옵션중에 multipart를 true로 했을 경우
			// 파일 첨부 가능
			// 절대경로, 상대경로 중 편한걸로 사용하면 됨
//			FileSystemResource fileResource = new FileSystemResource("C:/Users/yasmi/OneDrive/바탕 화면/YEJI/구디아카데미/수업 교재 및 자료/자료/ogu2.png"); // 절대경로
			// 파일명 변경
//			messageHelper.addAttachment("오구.png", fileResource);
			
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/reportDetail.do";
	}
	
	// 신고처리(탈퇴여부/처리여부 변경)
	@RequestMapping(value = "/reportProcessing.do", method = RequestMethod.GET)
	public String changeWithdrawal(String email, String seq) {
		boolean isc = mService.deleteUser(email);
		System.out.println("email: " + email);
		System.out.println("탈퇴여부 변경 성공여부: " + isc);
		boolean isc2 = service.changeProcessingStatus(seq);
		System.out.println("처리여부 변경 성공여부: " + isc2);
		return "redirect:/reportBoard.do";
	}
	
}
