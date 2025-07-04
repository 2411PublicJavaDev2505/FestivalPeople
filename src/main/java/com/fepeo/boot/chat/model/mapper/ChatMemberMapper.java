package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.MemberProfileList;
import com.fepeo.boot.chat.model.vo.ChatMember;

@Mapper
public interface ChatMemberMapper {

	// 신규 입장 등록
	int insertChatRoom(int chatroomNo, int memberNo);

	// 입장 상태 변경(입장'Y')
	int enterMemberYn(int chatroomNo, int memberNo);
	
	// 입장 상태 변경(나머지방 'N')
	int exitChatRooms(int memberNo, int chatroomNo);

	// 채팅방 참여 여부 조회
	ChatMember selectChatMemberList(int chatroomNo, int memberNo);

	// 가입 멤버 프로필 출력
	List<MemberProfileList> chatMemberList(int chatroomNo);

	// 채팅방 탈퇴
	int leaveChatMember(int chatroomNo, int memberNo);

	// 멤버 강퇴
	int blockChatMember(int chatroomNo, int memberNo);

	// 미입장 회원에게 채팅개수 +1
	int notReadMsgCount(int chatroomNo);
	
	// 입장한 방 메시지 갯수 0개
	int resetNonCheckMsg(int chatroomNo, int memberNo);

	// 안 들어온 사람 수 구하기(안 읽은 사람 수 구할 때 필요함)
	int countNonEnterMembers(int chatroomNo);

	int exitAllChatrooms(int memberNo);

	ChatMember checkBlackList(int chatroomNo, int memberNo);


}
