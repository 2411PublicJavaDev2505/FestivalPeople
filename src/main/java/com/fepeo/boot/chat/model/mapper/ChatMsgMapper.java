package com.fepeo.boot.chat.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fepeo.boot.chat.controller.dto.MsgInsertRequest;
import com.fepeo.boot.chat.model.vo.ChatMsg;

@Mapper
public interface ChatMsgMapper {

	// 채팅내용 출력
	List<ChatMsg> selectChatMsgListByNo(int chatroomNo);

	// 메시지 입력
	int insertChatMsg(MsgInsertRequest msg);

	// 안 읽은 사람 수 기록
	void nonReadMemberCount(@Param("chatMsgNo") int msgNo, @Param("nonReadMember") int count);
	/* @RequestParam은 컨트롤러에서 HTTP요청 파라미터를 메서드에 매핑할 때 씀
	 * (클라이언트에서 보낸 데이터를 받기 위함)
	 * @Param XML 매퍼파일의 #{}과 자바 메서드 파라미터를 매핑
	 * (SQL에 값을 넘겨줄 때 이름을 지정해주는 역할)
	 */

	// 회원 입장시 메세지 읽음 처리(non_read_member -1)
	int subtractionNonReadMemberCount(@Param("chatroomNo") int chatroomNo);
	
	
	
}
