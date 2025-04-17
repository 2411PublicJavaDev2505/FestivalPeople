package com.fepeo.boot.chat.model.service.logic;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.model.mapper.ChatMsgMapper;
import com.fepeo.boot.chat.model.service.ChatMsgService;
import com.fepeo.boot.chat.model.vo.ChatMsg;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatMsgServiceLogic implements ChatMsgService {
	
	private final ChatMsgMapper mapper;
	
	@Override // 채팅메시지 조회
	public List<ChatMsg> selectChatMsgListByNo(int chatroomNo) {
		return mapper.selectChatMsgListByNo(chatroomNo);
	}

	@Override // 메시지 입력
	public int insertChatMsg(MsgInsertRequest msg) {
		return mapper.insertChatMsg(msg);
	}

}
