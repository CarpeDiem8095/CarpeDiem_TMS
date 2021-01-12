package com.cp.tms.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.context.ServletConfigAware;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.cp.tms.dto.ChatingDto;
import com.cp.tms.dto.UserDto;


@Component(value = "tripChat.do")
public class TripSocketHandler extends TextWebSocketHandler {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private ArrayList<WebSocketSession> list ;
	
	public TripSocketHandler() {
		list = new ArrayList<WebSocketSession>();
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("afterConnectionEstablished()실행");
		super.afterConnectionEstablished(session);

		list.add(session);	//전체 접속자 리스트에 새로운 접속자 추가
		System.out.println("client session cnt : "+list.size()); 
		System.out.println("session connected : "+session.getId());
		System.out.println(list);
	}
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("handleTextMessage()실행");
		String msg = message.getPayload();
		String txt = "";
		
		System.out.println(session.getAttributes());
		Map<String, Object> mySession = session.getAttributes();
		String myGrSession = (String)mySession.get("gr_id");	//접속자의 그룹 아이디
		String myMemSession = (String)mySession.get("chat_id");	//접속자 아이디

		System.out.println("접속자의 그룹 아이디"+myGrSession);
		System.out.println("접속자 아이디"+myMemSession);
		
		if( msg != null && !msg.equals("")) {
			for(WebSocketSession s : list) {
				System.out.println("s는 ?"+s);
				Map<String, Object> ChatSession =s.getAttributes();
				String otherGrSession = (String)ChatSession.get("gr_id");
				String otherMemSession = (String)ChatSession.get("chat_id");
				ArrayList<String> grMemList = new ArrayList<String>();
				String [] other_gr_session =otherGrSession.split(",");
				if(other_gr_session[0].equals(myMemSession) || other_gr_session[1].equals(myMemSession)) {	//같은 그룹 소속일 때
					s.sendMessage(
							new TextMessage("<font color='red' size='1px'>"+myMemSession+" 님이 입장했습니다.</font>")
					);
				}
			}
		}
		
	}
	
	
}
