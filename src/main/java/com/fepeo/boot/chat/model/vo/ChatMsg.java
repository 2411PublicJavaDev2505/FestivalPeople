package com.fepeo.boot.chat.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ChatMsg {
	
	private int chatMsgNo;
	private String chatMsgContent;
	private Timestamp chatMsgTime;
	private String chatFileName;
	private String chatFileRename;
	private String chatFilePath;
	private int nonReadMember;
	private int memberNo;
	private int chatroomNo;
}
