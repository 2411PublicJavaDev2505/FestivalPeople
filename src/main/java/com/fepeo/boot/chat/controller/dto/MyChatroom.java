package com.fepeo.boot.chat.controller.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MyChatroom {

	private int chatroomNo;
	private int memberNo;
	private String chatroomTitle;
	private String tag1;
	private String tag2;
	private String tag3;
	private String chatImgName;
	private String chatImgRename;
	private String chatImgPath;
	private int chatLimit;
	private int chatMemberCount;
	private String blockYn;			// CHAT_MEMBER
	private String nonCheckMsg;		// CHAT_MEMBER
}
