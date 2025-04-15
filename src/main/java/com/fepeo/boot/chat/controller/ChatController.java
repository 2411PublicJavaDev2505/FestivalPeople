package com.fepeo.boot.chat.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.model.service.ChatService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {
	
	private final ChatService cService;
	
	// 채팅방 개설
	@GetMapping("/insert")
	public String showChatRoomInsert() {
		return "chat/chatInsert";
	}
	@PostMapping("/insert")
	public String insertChatRoom(@ModelAttribute ChatroomRegisterRequest chatRoom,
			@RequestParam(value="image", required=false) MultipartFile image
			, HttpSession session, Model model) throws IllegalStateException, IOException {
		
		chatRoom.setImage(image);
		int result = cService.insertChatRoom(chatRoom);
		
		return "redirect:/chat/list"; // 추후 상세페이지로 수정필요
	}

	@GetMapping("/list")
	public String showChatRoomList() {
		return "chat/list";
	}

	@GetMapping("/detail")
	public String showChatMsgList() {
		return "chat/chatDetail";
	}
	
}
