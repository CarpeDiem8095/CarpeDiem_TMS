package com.cp.tms.usebean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.cp.tms.dto.Member;
import com.cp.tms.dto.QuestionDto;

public class QuestionInputData {

	private List<QuestionDto> questionLists;
	private Member mDto;
	
	public void setQuestionLists(List<QuestionDto> lists) {
		this.questionLists = lists;
	}

	public void setmDto(Member mDto) {
		this.mDto = mDto;
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
		
		sb.append("<tr>");
		if (mDto.getAuth().equalsIgnoreCase("A")) {
			sb.append("	<td style='text-align: center; vertical-align: middle; height: 56px; width: 40px;'>");
			sb.append("		<input type='checkbox' name='chkVal' value='"+dto.getSeq()+"'>");
			sb.append("	</td>");
		}
		sb.append("	<td style='text-align: center; vertical-align: middle;'>"+dto.getSeq()+"</td>");
		sb.append("	<td class='panel-heading' style='vertical-align: middle; height: 56px;'>");
		sb.append("		<a data-toggle='collapse' data-parent='#accordion' href='#collapse"+dto.getSeq()+"' onclick='collapse(\""+dto.getSeq()+"\")'>");
		sb.append(replyImage(dto.getDepth()) + dto.getTitle());
		sb.append("		</a>");
		sb.append("	</td>");
		sb.append("	<td style='text-align: center; vertical-align: middle;'>");
		sb.append(dateFormat(dto.getText_regdate()));
		sb.append("	</td>");
		sb.append("	<td style='text-align: center; vertical-align: middle;'>");
		sb.append(dto.getWriter());
		sb.append("	</td>");
		if (mDto.getAuth().equalsIgnoreCase("A")) {
			sb.append("	<td style='text-align: center; vertical-align: middle;'>"+dto.getPublic_status()+"</td>");
			sb.append("	<td style='text-align: center; vertical-align: middle;'>"+dto.getDelflag()+"</td>");
			n = 7;
		}
		sb.append("</tr>");
		sb.append("<tr>");
		sb.append("	<td colspan='"+n+"'>");
		sb.append("		<div id='collapse"+dto.getSeq()+"' class='panel-collapse collapse'>");
		sb.append("			<div class='form-group'>");
		sb.append("				<label>내용</label><br>");
		// 내용은 auth가 'A'가 아니라면 글 비밀번호가 일치해야 볼 수 있음
//		if (mDto.getAuth().equalsIgnoreCase("A")) {
			sb.append("				<textarea rows='7' class='form-control' readonly>"+dto.getContent()+"</textarea>");
//		} else {
//			sb.append("				<textarea rows='7' class='form-control' style='display: none;' readonly>"+dto.getContent()+"</textarea>");
//			sb.append("				<div style='border: 1px solid #CCC; border-radius: 4px; background-color: #eee; width: 778.4px; height: 150px; text-align: center;'>");
//			sb.append("					<br>");
//			sb.append("					<p>비밀글입니다.</p>");
//			sb.append("					<p style='color: tomato;'>글 비밀번호를 입력해주세요.</p>");
//			sb.append("					<input type='password' class='form-control' id='text_pw' name='text_pw' maxlength='4' required>");
////			sb.append("					<input type='button' class='btn-primary' value='확인' onclick='textPw(\""+dto.getSeq()+"\")'>");
//			sb.append("					<input type='submit' class='btn-primary' value='확인' onclick='textPw(\""+dto.getText_pw()+"\")'>");
//			sb.append("				</div>");
//		}
		sb.append("			</div>");
		sb.append("			<div class='form-group'>");
		// 수정, 삭제 버튼은 글 비밀번호가 일치해야 볼 수 있음
		// 관리자는 관리자가 작성한 글만 수정 가능(questionBoard에 AUTH가 있어야할것같은데 이거 하나 비교하자고 만드는게 맞나..?)
		if (mDto.getAuth().equalsIgnoreCase("A")) {
			sb.append("				<input type='button' class='btn btn-primary' value='수정' onclick='modify(\""+dto.getSeq()+"\")'>");
			sb.append("				<input type='button' class='btn btn-primary' value='답변' onclick='reply(\""+dto.getSeq()+"\")'>");
			sb.append("				<input type='button' class='btn btn-primary' value='삭제' onclick='del(\""+dto.getSeq()+"\")'>");
		} else {
			sb.append("				<input type='button' class='btn btn-primary' value='수정' onclick='modify(\""+dto.getSeq()+"\")'>");
			sb.append("				<input type='button' class='btn btn-primary' value='삭제' onclick='del(\""+dto.getSeq()+"\")'>");
		}
		sb.append("				<input type='button' class='btn btn-warning' value='신고' onclick='report(\""+dto.getSeq()+"\")'/>");
		sb.append("			</div>");
		sb.append("		</div>");
		sb.append("	</td>");
		sb.append("</tr>");
		
		return sb.toString();
	}
	
}
