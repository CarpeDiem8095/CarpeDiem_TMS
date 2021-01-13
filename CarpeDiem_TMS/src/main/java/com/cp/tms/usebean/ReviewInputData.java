package com.cp.tms.usebean;

import java.util.List;

import com.cp.tms.dto.OnedayDto;
import com.cp.tms.dto.PlaceDto;

public class ReviewInputData {
	
	private List<OnedayDto> lists;

	public void setLists(List<OnedayDto> lists) {
		this.lists = lists;
	}
	
	
	// 전체 글 목록 
	public String getRevForm() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < lists.size(); i++) {
			
				sb.append(revForm(lists.get(i)));
		}
		return sb.toString(); 
	}
	
	// 글 목록 출력 양식 
	public String revForm(OnedayDto dto) {
		StringBuffer sb = new StringBuffer();
		
	sb.append("<tr>");
	sb.append("	<td colspan='2' >");
	sb.append("	<input type='file' id='uploadFile' name='filename'");
	sb.append("		class='uploadFile' accept='image/*'></td>");
	sb.append("</tr>");
	sb.append("	<td");
	sb.append("		style='border: 1px solid black; width: 200px; height: 200px;'></td>");
	sb.append("	<td><textarea></textarea></td>");
	sb.append("</tr>");
	sb.append("<tr>");
	sb.append("	<td><input type='submit' value='저장' /></td>");
	sb.append("</tr>");
		
		return sb.toString(); 
	}
	
	
	

}
