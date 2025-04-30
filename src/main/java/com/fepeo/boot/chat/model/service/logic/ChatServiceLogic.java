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
			image.transferTo(new File("C:/uploadImage/chat/" + imgRename));
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

	@Override // 참여인원수 증가
	public int updateChatMember(int chatroomNo) {
		return cMapper.updateChatMember(chatroomNo);
	}

	@Override // 참여인원수 감소
	public int subtractionChatMember(int chatroomNo) {
		return cMapper.subtractionChatMember(chatroomNo);
	}

	@Override // 전체리스트 출력
	public List<ChatRoom> selectChatRoomList() {
		return cMapper.selectChatRoomList();
	}

	@Override // 내가 속한 채팅방 목록
	public List<MyChatroom> selectMyChatRoomList(int memberNo) {
		return cMapper.selectMyChatRoomList(memberNo);
	}

	@Override // 채팅방 가입인원수 출력 CHAT_MEMBER_COUNT
	public List<ChatMember> selectChatMember() {
		return cMapper.selectChatMember();
	}

	@Override // 전체 채팅방 검색
	public List<ChatRoom> searchChatRoom(String searchKeyword) {
		return cMapper.searchChatRoom(searchKeyword);
	}

	@Override // 채팅방 정보 가져오기
	public ChatRoom selectChatRoomByNo(int chatroomNo) {
		return cMapper.selectChatRoomByNo(chatroomNo);
	}

	/** 메시지(말풍선) 
	 * @throws IOException 
	 * @throws IllegalStateException */
	@Override // 메시지 입력
	public int insertChatMsg(MsgInsertRequest msg) throws IllegalStateException, IOException {
		if(msg.getUplodeFile() != null && !msg.getUplodeFile().isEmpty()) {
			MultipartFile file = msg.getUplodeFile();
			String fileName = file.getOriginalFilename();
			String fileRename = Util.fileRename(fileName);
			String filePath = "/images/chat/" + fileRename;
			file.transferTo(new File("C:/uploadImage/chat/" + fileRename));
			msg.setChatFileName(fileName);
			msg.setChatFileRename(fileRename);
			msg.setChatFilePath(filePath);
		}		
		
		int result = msgMapper.insertChatMsg(msg);
		
		if(result > 0) {
			// 메시지 번호 가져오기
			int msgNo = msg.getChatMsgNo();
			// 안 들어온 사람 수 구하기
			int nonEnterCount = mMapper.countNonEnterMembers(msg.getChatroomNo());
			// 안 읽은 사람 수 기록
			msgMapper.nonReadMemberCount(msgNo, nonEnterCount);
		}
		return result;
	}
	
	@Override // 채팅메시지 조회
	public List<ChatMsg> selectChatMsgListByNo(int chatroomNo) {
		return msgMapper.selectChatMsgListByNo(chatroomNo);
	}

//	@Override // 나의 채팅방 검색
//	public List<ChatRoom> searchChatRoomByNo(String mySearchKeyword, int memberNo) {
//		return cMapper.searchChatRoomByNo(mySearchKeyword, memberNo);
//	}

	@Override // 회원 입장시 메세지 읽음 처리(non_read_member -1)
	public int subtractionNonReadMemberCount(int chatroomNo) {
		return msgMapper.subtractionNonReadMemberCount(chatroomNo);
	}

	/** 채팅방 유저 */
	@Override // 신규 입장 등록
	public int insertChatRoom(int chatroomNo, int memberNo) {
		return mMapper.insertChatRoom(chatroomNo,memberNo);
	}
	
	@Override // 채팅방 탈퇴
	public int leaveChatMember(int chatroomNo, int memberNo) {
		return mMapper.leaveChatMember(chatroomNo,memberNo);
	}

	@Override // 채팅방 가입 여부 조회
	public ChatMember selectChatMember(int chatroomNo, int memberNo) {
		return mMapper.selectChatMemberList(chatroomNo, memberNo);
	}

	@Override // 입장 상태 변경 (가입상태아님 주의)
	public int enterMemberYn(int chatroomNo, int memberNo) {
		return mMapper.enterMemberYn(chatroomNo,memberNo);
	}
	
	@Override // 입장상태 'N'으로 변경
	public int exitChatRooms(int memberNo,int chatroomNo) {
		return mMapper.exitChatRooms(memberNo, chatroomNo);
	}

	@Override // 가입 멤버 프로필 출력(나-방장-일반 순으로)
	public List<MemberProfileList> chatMemberList(int chatroomNo, int memberNo, int bangjangNo) {
		List<MemberProfileList> memberList = mMapper.chatMemberList(chatroomNo);

		List<MemberProfileList> sortedList = new ArrayList<>(); // 순서로 나눠서 담기
		
		// 1st (나)
		for (MemberProfileList member : memberList) {
			if(member.getMemberNo() == memberNo){
				sortedList.add(member);
				break;
			}
		}
		// 2nd 방장(나와 방장이 다를 때)
		for (MemberProfileList member : memberList) {
			if(member.getMemberNo() == bangjangNo && member.getMemberNo() != memberNo){
				sortedList.add(member);
				break;
			}
		}
		// 3rd 나머지
		for (MemberProfileList member : memberList) {
			if(member.getMemberNo() != bangjangNo && member.getMemberNo() != memberNo){
				sortedList.add(member);
			}
		}
		return sortedList;
	}

	@Override // 멤버 강퇴
	public int blockChatMember(int chatroomNo, int memberNo) {
		return mMapper.blockChatMember(chatroomNo,memberNo);
	}

	@Override // 미입장 회원에게 채팅개수 +1
	public int notReadMsgCount(int chatroomNo) {
		return mMapper.notReadMsgCount(chatroomNo);
	}

	@Override // 입장한 방 메시지 갯수 0개
	public int resetNonCheckMsg(int chatroomNo, int memberNo) {
		return mMapper.resetNonCheckMsg(chatroomNo,memberNo);
	}

	@Override // chatrommNo 으로 방 생성자 memberNo 검색
	public int selectMemberNoByNo(int num) {
		return cMapper.selectMemberNoByNo(num);
	}

	@Override
	public int exitAllChatrooms(int memberNo) {
		return mMapper.exitAllChatrooms(memberNo);
	}

	@Override
	public ChatMember checkBlackList(int chatroomNo, int memberNo) {
		return mMapper.checkBlackList(chatroomNo,memberNo);
	}

}
