package com.fepeo.boot.chat.model.service;

import java.io.IOException;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;

public interface ChatService {

	int insertChatRoom(ChatroomRegisterRequest chatRoom) throws IllegalStateException, IOException;

}
