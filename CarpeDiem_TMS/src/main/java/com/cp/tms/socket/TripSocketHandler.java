package com.cp.tms.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


@Component(value = "tripChat.do")
public class TripSocketHandler extends TextWebSocketHandler {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	private ArrayList<WebSocketSession> list;

	public TripSocketHandler() {
		list = new ArrayList<WebSocketSession>();
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("afterConnectionEstablished()실행");
		super.afterConnectionEstablished(session);

		list.add(session); // 전체 접속자 리스트에 새로운 접속자 추가
		System.out.println("client session cnt : " + list.size());
		System.out.println("session connected : " + session.getId());
		System.out.println(list);
	}

	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.info("handleTextMessage()실행");
		String msg = message.getPayload();
		String txt = "";

		System.out.println(session.getAttributes());
		Map<String, Object> mySession = session.getAttributes();
		String myGrSession = (String) mySession.get("gr_id"); // 접속자의 그룹 아이디
		String myMemSession = (String) mySession.get("chat_id"); // 접속자 아이디
		String[] my_gr_session = myGrSession.split(",");
		if (msg != null && !msg.equals("")) {
			if (msg.indexOf("#$nick_") > -1) {
				for (WebSocketSession s : list) {
					Map<String, Object> ChatSession = s.getAttributes();
					String otherGrSession = (String) ChatSession.get("gr_id");
					String otherMemSession = (String) ChatSession.get("chat_id");
					String[] other_gr_session = otherGrSession.split(",");
					if (my_gr_session[0].equals(other_gr_session[1])&&my_gr_session[1].equals(other_gr_session[0])) { 
						s.sendMessage(
								new TextMessage("<font color='red' size='1px'>" + myMemSession + " 님이 입장했습니다.</font>"));
					}
					if(myGrSession.equals(otherGrSession)) {
						s.sendMessage(
								new TextMessage("<font color='red' size='1px'>" + myMemSession + " 님이 입장했습니다.</font>"));
					}
					
				}
			} else {
				String msg2 = msg.substring(0, msg.indexOf(":")).trim();
				for (WebSocketSession s : list) {
					Map<String, Object> sessionMap = s.getAttributes();
					String otherGrSession = (String) sessionMap.get("gr_id");
					String otherMemSession = (String) sessionMap.get("chat_id");
					String[] other_gr_session = otherGrSession.split(",");
					if (myGrSession.equals(otherGrSession)) {
							String newMsg = myMemSession + ": "
									+ msg.replace(msg.substring(0, msg.trim().indexOf(":") + 1), "");
							String msgLog = myMemSession
									+ msg.replace(msg.substring(0, msg.trim().indexOf(":") + 1), "");
							logger.info("newMsg:" + msgLog);
							txt = newMsg;
						s.sendMessage(new TextMessage(txt));
					}
					if(my_gr_session[0].equals(other_gr_session[1])&&my_gr_session[1].equals(other_gr_session[0])) {
							String newMsg = myMemSession + ": "
									+ msg.replace(msg.substring(0, msg.trim().indexOf(":") + 1), "");
							String msgLog = myMemSession
									+ msg.replace(msg.substring(0, msg.trim().indexOf(":") + 1), "");
							logger.info("newMsg:" + msgLog);
							txt = newMsg;
						s.sendMessage(new TextMessage(txt));
					}
				}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		logger.info("afterConnectionClosed()실행");
		super.afterConnectionClosed(session, status);
		Map<String, Object> mySession = session.getAttributes();
		String myGrSession = (String) mySession.get("gr_id");
		String myMemSession = (String) mySession.get("chat_id");
		list.remove(session);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String now = sdf.format(new Date());
		String[] my_gr_session = myGrSession.split(",");
		for (WebSocketSession a : list) {
			Map<String, Object> sessionMap = a.getAttributes();
			String otherGrSession = (String) sessionMap.get("gr_id");
			String otherMemSession = (String) sessionMap.get("chat_id");
			String[] other_gr_session = otherGrSession.split(",");
			if(my_gr_session[0].equals(other_gr_session[1])&&my_gr_session[1].equals(other_gr_session[0])) {
				a.sendMessage(new TextMessage("<font color='blue' size='1px'>" + myMemSession + "님이 퇴장했습니다 (" + now + ")</font>"));
			}
			if (myGrSession.equals(otherGrSession)) {
				a.sendMessage(new TextMessage("<font color='blue' size='1px'>" + myMemSession + "님이 퇴장했습니다 (" + now + ")</font>"));
			}
		}
	}

}
