package com.fepeo.boot.chat.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;

@Mapper
public interface ChatMapper {

	int insertChatRoom(ChatroomRegisterRequest chatRoom);

}
