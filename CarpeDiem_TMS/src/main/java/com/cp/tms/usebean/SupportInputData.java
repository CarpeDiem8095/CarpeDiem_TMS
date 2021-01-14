package com.cp.tms.usebean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.cp.tms.dto.QuestionDto;

public class SupportInputData {

	private List<QuestionDto> questionLists;
	
	public void setQuestionLists(List<QuestionDto> lists) {
		this.questionLists = lists;
	}

	// 전체 글 목록
	public String getListForm() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < questionLists.size(); i++) {
			sb.append(listForm(questionLists.get(i)));
		}
		return sb.toString();
	}
	
	// 제목 댓글 이미지
	private String replyImage(int d) {
		StringBuffer sb = new StringBuffer();
		int depth = d;
		for (int i = 0; i < depth; i++) {
			sb.append("&nbsp;&nbsp;");
		}
		if (depth > 0) {
			sb.append("<img src='./images/questionReply.gif'/>&nbsp;&nbsp;");
		}
		return sb.toString();
	}
	
	// 날짜 형식(String 타입)
	private String dateFormat(String date) {
		return date.substring(0, date.indexOf(" "));
	}
	
	// 날짜 형식(Date 타입)
	private String dateFormat2(Date date) {
		SimpleDateFormat sf = new SimpleDateFormat("YYYY-mm-dd");
		return sf.format(date);
	}
	
	// 글 목록 출력 양식
	public String listForm(QuestionDto dto) {
		StringBuffer sb = new StringBuffer();
		int n = 5;
		
		if (dto.getDelflag().equalsIgnoreCase("N")) {
			sb.append("<tr>");
			// 체크박스는 관리자만 보이게
			sb.append("	<td style='text-align: center; vertical-align: middle; height: 56px;'>");
			sb.append("		<input type='checkbox' name='chkVal' value='"+dto.getSeq()+"'>");
			sb.append("	</td>");
			sb.append("	<td style='text-align: center; vertical-align: middle; width: 90px;'>"+dto.getSeq()+"</td>");
			sb.append("	<td class='panel-heading' style='vertical-align: middle; height: 56px; width: 295px;'>");
			sb.append("		<a data-toggle='collapse' data-parent='#accordion' href='#collapse"+dto.getSeq()+"' onclick='collapse(\""+dto.getSeq()+"\")'>");
			sb.append(replyImage(dto.getDepth()) + dto.getTitle());
			sb.append("		</a>");
			sb.append("	</td>");
			sb.append("	<td style='text-align: center; vertical-align: middle;'>");
			sb.append(dateFormat(dto.getText_regdate()));
			sb.append("	</td>");
			sb.append("	<td style='text-align: center; vertical-align: middle;'>");
			// 작성자: 비회원
			sb.append(dto.getWriter());
			// 작성자: 회원, 관리자는 session 가져오기
			sb.append("	</td>");
			// 관리자는 삭제여부 필요
			sb.append("	<td style='text-align: center; vertical-align: middle;'>"+dto.getDelflag()+"</td>");
			sb.append("</tr>");
			sb.append("<tr>");
			sb.append("	<td colspan='"+n+"'>");
			sb.append("		<div id='collapse"+dto.getSeq()+"' class='panel-collapse collapse'>");
			sb.append("			<div class='form-group'>");
			sb.append("				<label>내용</label><br>");
			// 내용: auth가 'U' or writer를 작성할 경우 비회원/회원은 글비밀번호가 일치하면 보이게
			//		auth가 'A'면 보이게
			sb.append("				<textarea rows='7' class='form-control' readonly>"+dto.getContent()+"</textarea>");
//			sb.append("				<textarea rows='7' class='form-control' readonly>"+dto.getContent()+"</textarea>");
			sb.append("				<input type='button' class='btn-primary' value='비밀번호 입력' onclick='textPw(\""+dto.getSeq()+"\")'>");
			
			sb.append("			</div>");
			sb.append("			<div class='form-group'>");
			// 수정버튼: 회원id와 게시글의 작성자가 동일하면 보이게
			//			비회원은..?
			sb.append("				<input type='button' class='btn btn-primary' value='수정' onclick='modify(\""+dto.getSeq()+"\")'>");
			// 답변버튼: 관리자만 보이게
			sb.append("				<input type='button' class='btn btn-primary' value='답변' onclick='reply(\""+dto.getSeq()+"\")'>");
			// 삭제버튼: 회원id와 게시글의 작성자가 동일하면 보이게
			//			비회원은..?
			//			auth가 'A'면 보이게
			sb.append("				<input type='button' class='btn btn-primary' value='삭제' onclick='del(\""+dto.getSeq()+"\")'>");
			sb.append("			</div>");
			sb.append("		</div>");
			sb.append("	</td>");
			sb.append("</tr>");
		}
		return sb.toString();
	}
	
}
