package com.fepeo.boot.chat.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.model.vo.ChatMember;

@Mapper
public interface ChatMemberMapper {

	// 채팅방 참여자 조회(목록)
	ChatMember selectChatMember(int chatroomNo, int memberNo);

	// 신규 입장 등록
	int insertChatRoom(int chatroomNo, int memberNo);

	// 입장 상태 변경
	int enterMemberYn(int chatroomNo, int memberNo);

}
