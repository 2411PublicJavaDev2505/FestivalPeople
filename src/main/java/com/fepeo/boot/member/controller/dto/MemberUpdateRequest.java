package com.fepeo.boot.member.controller.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberUpdateRequest {
	private int memberNo;
	private String memberPw;
	private String nickname;
	private String email;
	private String address;
	private String profileFileName;
	private String profileFileRename;
	private String profileFilePath;
	private String socialYn;
	private MultipartFile profile;
}
