package com.fepeo.boot.chat.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.fepeo.boot.chat.controller.dto.MemberProfileList;
import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.controller.dto.MyChatroom;
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
	
	private final ChatService service;
	
	// 채팅방 개설
	@GetMapping("/insert")
	public String showChatRoomInsert(HttpSession session, Model model) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();	

		// 내가 속한 방만 출력
		List<ChatMember> myChatRoomList = service.selectMyChatRoomList(memberNo);
		List<ChatRoom> myList = service.selectMyChatRoomListByChatMember(myChatRoomList);
		model.addAttribute("myList",myList);
		
		// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberList = service.selectChatMember();

		return "chat/chatInsert";
	}
	@PostMapping("/insert")
	public String insertChatRoom(@ModelAttribute ChatroomRegisterRequest chatRoom,
			@RequestParam(value="image", required=false) MultipartFile image
			, HttpSession session, Model model) throws IllegalStateException, IOException {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();	

		// 내가 속한 방만 출력
		List<ChatMember> myChatRoomList = service.selectMyChatRoomList(memberNo);
		List<ChatRoom> myList = service.selectMyChatRoomListByChatMember(myChatRoomList);
		// ↑ 내가 속한 채팅방(nonBlock방의 채팅방 정보를 가져오기 위한 과정)
		model.addAttribute("myList",myList);
		
		chatRoom.setImage(image);
		int result = service.insertChatRoom(chatRoom);
		
		// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberList = service.selectChatMember();
		model.addAttribute("memberList", memberList);		

		return "redirect:/chat/enter/" + chatRoom.getChatroomNo();
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
			List<ChatMember> myChatRoomList = service.selectMyChatRoomList(memberNo);
			List<ChatRoom> myList = service.selectMyChatRoomListByChatMember(myChatRoomList);
			model.addAttribute("myList",myList);
			
//			// 전체 리스트 출력
			List<ChatRoom> cRooms = service.selectChatRoomList();
			model.addAttribute("cRooms", cRooms);
			
//			// 각 채팅방별 참여인원수 불러오기
			List<ChatMember> memberList = service.selectChatMember();
			model.addAttribute("memberList", memberList);
			return "chat/list";
		}
	}
	
	// 채팅방 가입여부 확인 (JS에서 확인을 위해서)
	@GetMapping("/check-access")
	@ResponseBody
	public Map<String, Object> checkAccess(@RequestParam int chatroomNo, HttpSession session) {
	    Member member = (Member) session.getAttribute("member");
	    int memberNo = member.getMemberNo();
	    Map<String, Object> result = new HashMap<>(); // DTO 생성 대신에 여러 정보를 묶어서 보냄

	    // 가입여부 확인**
	    ChatMember cMember = service.selectChatMember(chatroomNo, memberNo);

	    if (cMember != null) {
	        result.put("status", "joined"); // 상태, 기가입
	    } else {
	        result.put("status", "notJoined"); // 상태, 미가입
	    }
	    return result;
	}
	
	// 채팅방 가입(처음 입장)
	@GetMapping("/enter/{chatroomNo}")
	public String insertChatRoom(@PathVariable int chatroomNo, 
			HttpSession session, Model model) {
		// 회원 로그인 정보 가져오기		
		Member member =(Member) session.getAttribute("member");
		int memberNo = member.getMemberNo();
		// 채팅방 정보 조회
		ChatRoom chatRoom = service.selectChatRoomByNo(chatroomNo); 
		model.addAttribute("chatRoom", chatRoom);
		
		// 가입여부 확인***
		ChatMember cMember = service.selectChatMember(chatroomNo, memberNo);
		
		if(cMember == null) { // 처음 입장한 사람은 가입 처리
			int result = service.insertChatRoom(chatroomNo, memberNo); // CHAT_MEMBER 인서트
			int count = service.updateChatMember(chatroomNo); // CHATROOM > chat_member_count +1
		} else if("N".equals(cMember.getEnterYn())) {
			// 이미 가입한 회원 - 재입장
			int yn = service.enterMemberYn(chatroomNo, memberNo);
		}
		return showChatMsgList(chatroomNo, session, model); // 중복부분 있어서 기존 입장(detail) 메서드 호출
	}
	
	// 채팅방 입장(상세페이지)
	@GetMapping("/detail/{chatroomNo}")
	public String showChatMsgList(@PathVariable("chatroomNo") int chatroomNo
				,HttpSession session, Model model) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();	

		// 채팅방 정보 조회 (제목,태그 등 출력용)
		ChatRoom chatRoom = service.selectChatRoomByNo(chatroomNo); 
		model.addAttribute("chatRoom", chatRoom);

		// 내가 속한 방만 출력
		List<ChatMember> myChatRoomList = service.selectMyChatRoomList(memberNo);
		List<ChatRoom> myList = service.selectMyChatRoomListByChatMember(myChatRoomList);
		model.addAttribute("myList",myList);
		
		// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberCount = service.selectChatMember();
		
		// 가입 멤버 프로필 출력
		List<MemberProfileList>  memberList = service.chatMemberList(chatroomNo);
		model.addAttribute("memberList", memberList);
		
		// 대화내용(말풍선) 출력
		List<ChatMsg> msgList = service.selectChatMsgListByNo(chatroomNo);
		model.addAttribute("msgList", msgList);

		session.setAttribute("chatroomTitle", chatRoom.getChatroomTitle());
		session.setAttribute("memberNo", member.getMemberNo());
		model.addAttribute("member", member);
		model.addAttribute("nickname", member.getNickname());
		model.addAttribute("profileFilePath", member.getProfileFilePath());
		
		model.addAttribute("chatroomNo", chatroomNo); // 채팅방 번호 전달
		
		return "chat/chatDetail";
	}
	
	// 채팅방 검색(전체)
	@GetMapping("/totalSearch")
	public String searchChatRoom(HttpSession session,Model model
			,@RequestParam("searchKeyword") String searchKeyword) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();			
		
		// 내가 속한 방만 출력
		List<ChatMember> myChatRoomList = service.selectMyChatRoomList(memberNo);
		List<ChatRoom> myList = service.selectMyChatRoomListByChatMember(myChatRoomList);
		model.addAttribute("myList",myList);		
		
		List<ChatRoom> rSearchList = service.searchChatRoom(searchKeyword);
		model.addAttribute("rSearchList", rSearchList);
		
		// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberList = service.selectChatMember();
		model.addAttribute("memberList", memberList);				
		
		return "chat/chatSearch";
	}
	
	// 나의 채팅방 검색
//	@GetMapping("/mySearch")
//	@ResponseBody
//	public List<ChatRoom> searchChatRoomByNo(HttpSession session,Model model
//			,@RequestParam("mySearchKeyword") String mySearchKeyword) {
//	
//		// 세션에서 memberNo 가져오기
//		Member member = (Member)session.getAttribute("member");
//		int memberNo = member.getMemberNo();			
//		
//		// 각 채팅방별 참여인원수 불러오기
//		List<ChatMember> memberList = service.selectChatMember();
//		model.addAttribute("memberList", memberList);		
//		
//		// 검색
//		List<ChatRoom> mySearchList = service.searchChatRoomByNo(mySearchKeyword, memberNo);
//		
//		return mySearchList;
//	}
//	

	// 채팅방 퇴장(탈퇴)
	@GetMapping("/leave")
	public String leaveChatroom(@RequestParam("chatroomNo")int chatroomNo,HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();
		
		int result = service.leaveChatMember(chatroomNo, memberNo); // CHAT_MEMBER > delete
		int count = service.subtractionChatMember(chatroomNo); // CHATROOM > chat_member_count -1		
		return "redirect:/chat/list";
	}
	
	
	// 채팅방 삭제
	@GetMapping("/delete")
	public String deleteCahtRoom(@RequestParam("chatroomNo")int chatroomNom) {
		int result = service.deleteCahtRoom(chatroomNom);
		return "redirect:/chat/list";
	}
	
	// 메시지입력
	@PostMapping("/msgInsert")
	@ResponseBody
	public int insertChatMsg(@RequestParam("msgContent") String  msgContent,
				@RequestParam("chatroomNo") int chatroomNo,
				@RequestParam(value="uplodeFile", required=false) MultipartFile uplodeFile,
				HttpSession session, Model model) {
		// 세션에서 memberNo 가져오기
		Member member = (Member)session.getAttribute("member");
		int memberNo = member.getMemberNo();	
		
    	// 각 채팅방별 참여인원수 불러오기
		List<ChatMember> memberList = service.selectChatMember();

		// 말풍선 생성(채팅내용 입력)
		MsgInsertRequest msg = new MsgInsertRequest();
		msg.setChatroomNo(chatroomNo);
		msg.setChatMsgContent(msgContent);
		msg.setMemberNo(memberNo);
		msg.setUplodeFile(uplodeFile);
		int result = service.insertChatMsg(msg);
		
		// 안 읽은 사람 숫자 출력
		// int count = msgService.nonReadMemberCount(chatMsgNo);
		
		// 대화내용(말풍선) 출력
		List<ChatMsg> msgList = service.selectChatMsgListByNo(chatroomNo);
		model.addAttribute("msgList", msgList);
		model.addAttribute("nickname", member.getNickname()); // 참가자 닉네임

		System.out.println("chat내용: "+ msgContent);
		
		return result; 
	}
	
	// 메시지 검색
	
	// 멤버 강퇴
	
	// 채팅방 신고하기
	
	
}
