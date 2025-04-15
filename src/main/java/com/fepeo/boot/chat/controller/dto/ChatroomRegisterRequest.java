package com.fepeo.boot.chat.controller.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatroomRegisterRequest {

	private int memberNo;
	private String chatroomTitle;
	private String tag1;
	private String tag2;
	private String tag3;
	private String chatImgName;
	private String chatImgRename;
	private String chatImgPath;
	private int chatLimit;
	private MultipartFile image;
}
