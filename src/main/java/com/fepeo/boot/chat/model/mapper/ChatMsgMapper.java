package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.model.vo.ChatMsg;

@Mapper
public interface ChatMsgMapper {

	// 채팅내용 출력
	List<ChatMsg> selectChatMsgListByNo(int chatroomNo);

	// 메시지 입력
	int insertChatMsg(MsgInsertRequest msg);

}
