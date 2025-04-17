package com.fepeo.boot.chat.model.service;

import java.io.IOException;
import java.util.List;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.vo.ChatMember;
import com.fepeo.boot.chat.model.vo.ChatRoom;

public interface ChatService {

	int insertChatRoom(ChatroomRegisterRequest chatRoom) throws IllegalStateException, IOException;

	List<ChatRoom> selectChatRoomList();

	List<MyChatroom> selectChatRoomListByNo(int memberNo);

	List<ChatMember> selectChatMember();

	int deleteCahtRoom(int chatroomNom);

}
