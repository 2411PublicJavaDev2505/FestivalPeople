package com.fepeo.boot.member.controller.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberLoginRequest {

	private String memberId;
	private String memberPw;
	
}
