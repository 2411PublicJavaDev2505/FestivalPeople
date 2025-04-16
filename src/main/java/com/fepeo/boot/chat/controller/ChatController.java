package com.fepeo.boot.chat.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.chat.model.vo.ChatMember;
import com.fepeo.boot.chat.model.vo.ChatRoom;
import com.fepeo.boot.member.model.vo.Member;

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
		
		// 채팅방 회원수 업데이트
		//int member = cService.updateChatMember(); 
		
		// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberList = cService.selectChatMember();

		return "redirect:/chat/list"; // 추후 상세페이지로 수정필요
	}

	// 채팅방 목록
	@GetMapping("/list")
	public String showChatRoomList(HttpSession session, Model model) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();
		System.out.println("Session memberNo: "+session.getAttribute("memberNo"));
	    // 미로그인 시 로그인 페이지로
	    if (member == null) {
	        return "redirect:/member/login";
	    }else {
	    	// 내가 속한 방만 출력
	    	List<MyChatroom> myList = cService.selectChatRoomListByNo(memberNo);
	    	model.addAttribute("myList",myList);
	    	// 전체 리스트 출력
	    	List<ChatRoom> cRooms = cService.selectChatRoomList();
	    	model.addAttribute("cRooms", cRooms);
	    	
	    	// 각 채팅방별 참여인원수 불러오기
	    	List<ChatMember> memberList = cService.selectChatMember();
	    	return "chat/list";
	    }
	}
	
	// 채팅방 입장(상세페이지)
	@GetMapping("/detail")
	public String showChatMsgList(HttpSession session, Model model) {
//		// 세션에서 memberNo 가져오기
//		Member member = (Member)session.getAttribute("member");
//		int memberNo = member.getMemberNo();	
//		// 좌측 목록 출력
//		List<MyChatroom> myList = cService.selectChatRoomListByNo(memberNo);
//		model.addAttribute("myList",myList);
		
		// 각 채팅방별 참여인원수 불러오기
		// List<ChatMember> memberList = cService.selectChatMember();
		
		// 채팅방 회원수 업데이트
		//int member = cService.updateChatMember();
		
		return "chat/chatDetail";
	}
	
	
	// 채팅방 검색(전체)
	// 나의 채팅방 검색
	// 채팅방 퇴장
	
	// 채팅방 삭제
	
	// 메시지입력
	// 메시지 검색
	
	// 멤버 강퇴
	
	
	
}
