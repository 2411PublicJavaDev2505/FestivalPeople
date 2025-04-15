package com.fepeo.boot.chat.model.service.logic;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.model.mapper.ChatMapper;
import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.common.util.Util;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceLogic implements ChatService {
	
	private final ChatMapper mapper;
	
	private String webPath = "/img/chat/"; // 브라우저를 통해 저장되는 url
	private String folderPath = "C:/uploadFile/chat/"; // 실제 서버 안에 저장되는 폴더 url
	
	@Override
	public int insertChatRoom(ChatroomRegisterRequest chatRoom) throws IllegalStateException, IOException {
		
		if(chatRoom.getImage() != null && !chatRoom.getImage().isEmpty()) {
			MultipartFile image = chatRoom.getImage();
			String imgName = image.getOriginalFilename();
			String imgRename = Util.fileRename(imgName);
			String imgPath = webPath + imgRename;
			image.transferTo(new File(folderPath + imgRename));
			chatRoom.setChatImgName(imgName);
			chatRoom.setChatImgRename(imgRename);
			chatRoom.setChatImgPath(imgPath);
			
		}
		int result = mapper.insertChatRoom(chatRoom);
		return result;
	}

}
