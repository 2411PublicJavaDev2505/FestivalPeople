package com.fepeo.boot.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {
	
	@GetMapping("/list")
	public String showChatRoomList() {
		return "chat/list";
	}

	@GetMapping("/detail")
	public String showChatMsgList() {
		return "chat/chatDetail";
	}
	
	@GetMapping("/insert")
	public String insertChatRoom() {
		return "chat/chatInsert";
	}
}
