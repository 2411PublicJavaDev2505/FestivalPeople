package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.model.vo.ChatRoom;

@Mapper
public interface ChatMapper {

	int insertChatRoom(ChatroomRegisterRequest chatRoom);

	List<ChatRoom> selectChatRoomList();

}
