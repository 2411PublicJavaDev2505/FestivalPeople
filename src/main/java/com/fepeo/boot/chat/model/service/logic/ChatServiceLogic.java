package com.fepeo.boot.chat.model.service.logic;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MemberProfileList;
import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.mapper.ChatMapper;
import com.fepeo.boot.chat.model.mapper.ChatMemberMapper;
import com.fepeo.boot.chat.model.mapper.ChatMsgMapper;
import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.chat.model.vo.ChatMember;
import com.fepeo.boot.chat.model.vo.ChatMsg;
import com.fepeo.boot.chat.model.vo.ChatRoom;
import com.fepeo.boot.common.util.Util;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceLogic implements ChatService {
	
	private final ChatMapper cMapper;
	private final ChatMsgMapper msgMapper;
	private final ChatMemberMapper mMapper;
	
	/** 채팅방 */
	@Override // 채팅방 생성
	public int insertChatRoom(ChatroomRegisterRequest chatRoom) throws IllegalStateException, IOException {
		
		if(chatRoom.getImage() != null && !chatRoom.getImage().isEmpty()) {
			MultipartFile image = chatRoom.getImage();
			String imgName = image.getOriginalFilename();
			String imgRename = Util.fileRename(imgName);
			String imgPath = "/images/chat/" + imgRename;
			image.transferTo(new File("C:/uploadFile/chat/" + imgRename));
			chatRoom.setChatImgName(imgName);
			chatRoom.setChatImgRename(imgRename);
			chatRoom.setChatImgPath(imgPath);
		}
		int result = cMapper.insertChatRoom(chatRoom);
		return result;
	}

	@Override // 채팅방 삭제
	public int deleteCahtRoom(int chatroomNom) {
		return cMapper.deleteCahtRoom(chatroomNom);
	}

	@Override // 전체리스트 출력
	public List<ChatRoom> selectChatRoomList() {
		return cMapper.selectChatRoomList();
	}

	@Override // 내가 속한 채팅방의 목록
	public List<ChatMember> selectMyChatRoomList(int memberNo) {
		return mMapper.selectMyChatRoomList(memberNo);
	}

	@Override // 내가 속한 채팅방의 정보 가져오기
	public List<ChatRoom> selectMyChatRoomListByChatMember(List<ChatMember> myChatRoomList) {
		List<ChatRoom> myList  = new ArrayList<>();
		for(int i=0;i<myChatRoomList.size();i++) {
			myList.add(cMapper.selectMyChatRoomListByChatMember(myChatRoomList.get(i)));
		}
		return myList;
	}

	@Override // 채팅방 가입인원수 출력 CHAT_MEMBER_COUNT
	public List<ChatMember> selectChatMember() {
		return cMapper.selectChatMember();
	}

	@Override // 채팅방 정보 가져오기
	public ChatRoom selectChatRoomByNo(int chatroomNo) {
		return cMapper.selectChatRoomByNo(chatroomNo);
	}

	/** 메시지(말풍선) */
	@Override // 메시지 입력
	public int insertChatMsg(MsgInsertRequest msg) {
		return msgMapper.insertChatMsg(msg);
	}
	
	@Override // 채팅메시지 조회
	public List<ChatMsg> selectChatMsgListByNo(int chatroomNo) {
		return msgMapper.selectChatMsgListByNo(chatroomNo);
	}

	@Override // 참여인원수 증가
	public int updateChatMember(int chatroomNo) {
		return cMapper.updateChatMember(chatroomNo);
	}

	/** 채팅방 유저 */
	@Override // 신규 입장 등록
	public int insertChatRoom(int chatroomNo, int memberNo) {
		return mMapper.insertChatRoom(chatroomNo,memberNo);
	}
	
	@Override // 채팅방 가입 여부 조회
	public ChatMember selectChatMember(int chatroomNo, int memberNo) {
		return mMapper.selectChatMemberList(chatroomNo, memberNo);
	}

	@Override // 입장 상태 변경 (가입상태아님 주의)
	public int enterMemberYn(int chatroomNo, int memberNo) {
		return mMapper.enterMemberYn(chatroomNo,memberNo);
	}

	@Override // 가입 멤버 프로필 출력
	public List<MemberProfileList> chatMemberList(int chatroomNo) {
		return mMapper.chatMemberList(chatroomNo);
	}
	
}
