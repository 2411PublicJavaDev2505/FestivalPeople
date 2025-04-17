package com.fepeo.boot.chat.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.chat.controller.dto.ChatroomRegisterRequest;
import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
import com.fepeo.boot.chat.model.service.ChatMsgService;
import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.chat.model.vo.ChatMember;
import com.fepeo.boot.chat.model.vo.ChatMsg;
import com.fepeo.boot.chat.model.vo.ChatRoom;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {
	
	private final ChatService cService;
	private final ChatMsgService msgService;
	
	// 채팅방 개설
	@GetMapping("/insert")
	public String showChatRoomInsert() {
		return "chat/chatInsert";
	}
	
	@PostMapping("/insert")
	public String insertChatRoom(@ModelAttribute ChatroomRegisterRequest chatRoom,
			@RequestParam(value="image", required=false) MultipartFile image
			, HttpSession session, Model model) throws IllegalStateException, IOException {
		Member member = (Member)session.getAttribute("member"); 
    	// 세션에서 memberNo 가져오기
    	int memberNo = member.getMemberNo();
    	// 내가 속한 방만 출력
    	List<MyChatroom> myList = cService.selectChatRoomListByNo(memberNo);
    	model.addAttribute("myList",myList);
    	
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
		// 미로그인 시 로그인 페이지로
		Member member = (Member)session.getAttribute("member"); 
	    if (member == null) {
	        return "redirect:/member/login";
	    }else {
	    	// 세션에서 memberNo 가져오기
	    	int memberNo = member.getMemberNo();
	    	// 내가 속한 방만 출력
	    	List<MyChatroom> myList = cService.selectChatRoomListByNo(memberNo);
	    	model.addAttribute("myList",myList);
	    	// 전체 리스트 출력
	    	List<ChatRoom> cRooms = cService.selectChatRoomList();
	    	model.addAttribute("cRooms", cRooms);
	    	
	    	// 각 채팅방별 참여인원수 불러오기
	    	List<ChatMember> memberList = cService.selectChatMember();
	    	model.addAttribute("memberList", memberList);
	    	
	    	return "chat/list";
	    }
	}
	
	// 채팅방 입장(상세페이지)
	@GetMapping("/detail/{chatroomNo}")
	public String showChatMsgList(@PathVariable("chatroomNo") int chatroomNo
				,HttpSession session, Model model) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		ChatRoom chatRoom = (ChatRoom)session.getAttribute("chatRoom");
		int memberNo = member.getMemberNo();	
		// 좌측 목록(내가 속한 방) 출력
		List<MyChatroom> myList = cService.selectChatRoomListByNo(memberNo);
		model.addAttribute("myList",myList);
		// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberList = cService.selectChatMember();
		
		// 대화내용(말풍선) 출력
		List<ChatMsg> msgList = msgService.selectChatMsgListByNo(chatroomNo);
		model.addAttribute("msgList", msgList);
		
		model.addAttribute("chatroomNo", chatroomNo);
		session.setAttribute("memberNo", member.getMemberNo());
		model.addAttribute("member", member);
		model.addAttribute("chatRoom", chatRoom);
		
		// 채팅방 회원수 업데이트
		//int member = cService.updateChatMember();
		
		return "chat/chatDetail";
	}
	
	
	// 채팅방 검색(전체)
	// 나의 채팅방 검색
	// 채팅방 퇴장
	
	// 채팅방 삭제
	@GetMapping("/delete")
	public String deleteCahtRoom(@RequestParam("chatroomNo")int chatroomNom) {
		int result = cService.deleteCahtRoom(chatroomNom);
		return "redirect:/chat/list";
	}
	
	// 메시지입력
	@PostMapping("/msgInsert")
	@ResponseBody
	public int insertChatMsg(@ModelAttribute MsgInsertRequest msg,
				@RequestParam(value="uplodeFile", required=false) MultipartFile uplodeFile,
				@RequestParam("chatroomNo") int chatroomNo
				,HttpSession session, Model model) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();	
		
    	// 각 채팅방별 참여인원수 불러오기
    	List<ChatMember> memberList = cService.selectChatMember();

    	// 말풍선 생성
    	msg.setUplodeFile(uplodeFile);
    	int result = msgService.insertChatMsg(msg);
    	
    	// 안 읽은 사람 숫자 출력
    	// int count = msgService.nonReadMemberCount(chatMsgNo);
    	
		// 대화내용(말풍선) 출력
		List<ChatMsg> msgList = msgService.selectChatMsgListByNo(chatroomNo);
		model.addAttribute("msgList", msgList);
		model.addAttribute("nickname", member.getNickname()); // 참가자 닉네임

		return result; 
	}
	
	// 메시지 검색
	
	// 멤버 강퇴
	
	
	
}
