package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.MemberProfileList;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.vo.ChatMember;

@Mapper
public interface ChatMemberMapper {

	// 신규 입장 등록
	int insertChatRoom(int chatroomNo, int memberNo);

	// 입장 상태 변경
	int enterMemberYn(int chatroomNo, int memberNo);
	
	// 채팅방 참여 여부 조회
	ChatMember selectChatMemberList(int chatroomNo, int memberNo);

	// 내가 속한 채팅방의 목록
	List<ChatMember> selectMyChatRoomList(int memberNo);

	// 가입 멤버 프로필 출력
	List<MemberProfileList> chatMemberList(int chatroomNo);

	// 채팅방 탈퇴
	int leaveChatMember(int chatroomNo, int memberNo);

	// 멤버 강퇴
	int blockChatMember(int chatroomNo, int memberNo);

}
