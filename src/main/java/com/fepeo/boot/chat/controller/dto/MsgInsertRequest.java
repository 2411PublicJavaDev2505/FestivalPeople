package com.fepeo.boot.chat.controller.dto;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MsgInsertRequest {

	private int chatMsgNo;
	private String chatMsgContent;
	private Timestamp chatMsgTime;
	private String chatFileName;
	private String chatFileRename;
	private String chatFilePath;
	private int nonReadMember;
	private int memberNo;
	private int chatroomNo;
	private MultipartFile uplodeFile;
}
