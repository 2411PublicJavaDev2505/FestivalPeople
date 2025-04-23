package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.model.vo.ChatMember;
import com.fepeo.boot.chat.model.vo.ChatRoom;

@Mapper
public interface ChatMapper {

	// 채팅방 생성
	int insertChatRoom(ChatroomRegisterRequest chatRoom);

	// 채팅방 전체 목록
	List<ChatRoom> selectChatRoomList();

	// 채팅방 참여인원수 출력
	List<ChatMember> selectChatMember();

	// 채팅방 삭제
	int deleteCahtRoom(int chatroomNom);

	// 채팅방 정보 가져오기
	ChatRoom selectChatRoomByNo(int chatroomNo);

	// 참여인원수 증가
	int updateChatMember(int chatroomNo);

	// 내 채팅방 정보 출력
	ChatRoom selectMyChatRoomListByChatMember(ChatMember chatMember);

	// 참여인원수 감소
	int subtractionChatMember(int chatroomNo);

	// 전체 채팅방 검색
	List<ChatRoom> searchChatRoom(String searchKeyword);

	// 나의 채팅방 검색
//	List<ChatRoom> searchChatRoomByNo(String searchKeyword, int memberNo);

}
