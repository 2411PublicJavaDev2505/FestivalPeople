package com.fepeo.boot.chat.model.service;

import java.io.IOException;
import java.util.List;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MemberProfileList;
import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.vo.ChatMember;
import com.fepeo.boot.chat.model.vo.ChatMsg;
import com.fepeo.boot.chat.model.vo.ChatRoom;

public interface ChatService {

	int insertChatRoom(ChatroomRegisterRequest chatRoom) throws IllegalStateException, IOException;

	List<ChatRoom> selectChatRoomList();

	List<ChatMember> selectChatMember();
	
	List<ChatMsg> selectChatMsgListByNo(int chatroomNo);

	int insertChatMsg(MsgInsertRequest msg);

	int deleteCahtRoom(int chatroomNom);

	ChatRoom selectChatRoomByNo(int chatroomNo);

	ChatMember selectChatMember(int chatroomNo, int memberNo);

	int insertChatRoom(int chatroomNo, int memberNo);

	int updateChatMember(int chatroomNo);

	int enterMemberYn(int chatroomNo, int memberNo);

	List<ChatMember> selectMyChatRoomList(int memberNo);

	List<ChatRoom> selectMyChatRoomListByChatMember(List<ChatMember> myChatRoomList);

	List<MemberProfileList> chatMemberList(int chatroomNo);

	int leaveChatMember(int chatroomNo, int memberNo);

	int subtractionChatMember(int chatroomNo);

	List<ChatRoom> searchChatRoom(String searchKeyword);

//	List<ChatRoom> searchChatRoomByNo(String mySearchKeyword, int memberNo);

}
