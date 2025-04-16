package com.fepeo.boot.member.model.vo;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Getter
@ToString
public class Member {

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
	private String memberYn;
	private String managerYn;
	private int reportCount;
}
