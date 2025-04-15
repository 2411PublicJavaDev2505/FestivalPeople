package com.fepeo.boot.chat.model.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ChatMember {
	
	private int chatroomNo;
	private int memberNo;
	private String blockYn;
	private String enterYn;
	private int nonCheckMsg;

}
