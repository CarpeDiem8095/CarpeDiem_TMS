package com.cp.tms.socket;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


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
	}
	
	
	
}
