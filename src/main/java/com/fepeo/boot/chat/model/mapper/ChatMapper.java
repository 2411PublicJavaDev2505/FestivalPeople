package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.vo.ChatRoom;

@Mapper
public interface ChatMapper {

	//채팅방 생성
	int insertChatRoom(ChatroomRegisterRequest chatRoom);

	// 채팅방 전체 목록
	List<ChatRoom> selectChatRoomList();
	// 회원별 채팅방 목록
	List<MyChatroom> selectChatRoomListByNo(int memberNo);

}
