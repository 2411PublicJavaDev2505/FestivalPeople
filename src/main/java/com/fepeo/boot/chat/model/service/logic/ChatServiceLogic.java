package com.fepeo.boot.chat.model.service.logic;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.mapper.ChatMapper;
import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.chat.model.vo.ChatRoom;
import com.fepeo.boot.common.util.Util;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceLogic implements ChatService {
	
	private final ChatMapper mapper;
	
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
		int result = mapper.insertChatRoom(chatRoom);
		return result;
	}

	@Override // 전체리스트 출력
	public List<ChatRoom> selectChatRoomList() {
		return mapper.selectChatRoomList();
	}

	@Override // 회원별 리스트 출력
	public List<MyChatroom> selectChatRoomListByNo(int memberNo) {
		return mapper.selectChatRoomListByNo(memberNo);
	}

}
