package com.fepeo.boot.chat.controller.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberProfileList {
	
	private int memberNo;
	private String nickname;
	private String profileFilePath;
	private String memberYn;
	private String blockYn;	// CHAT_MEMBER
	private int chatroomNo;
}
