package com.fepeo.boot.chat.model.service;

import java.util.List;

import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.model.vo.ChatMsg;

public interface ChatMsgService {

	List<ChatMsg> selectChatMsgListByNo(int chatroomNo);

	int insertChatMsg(MsgInsertRequest msg);

}
