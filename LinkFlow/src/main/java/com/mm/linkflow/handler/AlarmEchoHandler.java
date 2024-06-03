package com.mm.linkflow.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.mm.linkflow.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlarmEchoHandler extends TextWebSocketHandler{

	// 현재 웹소켓과 연결된 클라이언트들을 저장해놓는 리스트
		private List<WebSocketSession> sessionList = new ArrayList<>();
		
		

		
		/**
		 * 1) afterConnectionEstablished : 클라이언트와 연결되었을 때 처리할 내용을 정의
		 * 
		 * @param session - 현재 웹소켓과 연결된 클라이언트 정보를 가지고 있는 객체
		 */
		@Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			log.debug("================ websocket 연결됨 =================");
//			log.debug("WebSocketSession : {}", session);
//			log.debug("session Id : {}", session.getId());
//			log.debug("session Attributes : {}",session.getAttributes());
//			log.debug("현재 채팅방에 참가한 회원 : {}", session.getAttributes().get("loginUser"));
			
			sessionList.add(session);
			
	    	
		}
		
	    /**
	     * 2) handleMessage : 데이터(텍스트,파일 등)가 웹소켓으로 전송되었을 때 처리할 내용을 정의
	     * 
	     * @param message - 현재 웹소켓으로 전달된 데이터에 대한 정보를 가지고 있는 객체
	     */
	    @Override
	    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
	    	
	    }
	    
	    /**
	     * 3) afterConnectionClosed : 클라이언트와 연결이 끊겼을 때 처리할 내용을 정의
	     */
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    	
	    	log.debug("================ websocket 끊김 =================");
//	    	log.debug("WebSocketSession : {}", session);
//			log.debug("session Id : {}", session.getId());
//			log.debug("현재 채팅방에서 나간 회원 : {}", session.getAttributes().get("loginUser"));
			
			sessionList.remove(session);
			
			
	    }
	    
	    /**
	       * List<WebSocketSession> sessionList의 getter메소드
	       * @return
	       */
	      public List<WebSocketSession> getSessionList(){
	         return sessionList;
	      }

}
