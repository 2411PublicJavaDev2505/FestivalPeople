package com.fepeo.boot.chat.model.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ChatRoom {
	
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
}
