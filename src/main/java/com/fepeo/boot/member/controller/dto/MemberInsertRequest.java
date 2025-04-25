package com.fepeo.boot.member.controller.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberInsertRequest {

	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberCode;
	private String memberName;
	private String nickname;
	private String email;
	private String address;
	private String gender;
	private String profileFileName;
	private String profileFileRename;
	private String profileFilePath;
	private String profileUrl;
	private String socialYn;
	private MultipartFile profile;
	
}
