package com.fepeo.boot.manager.controller.dto;

import lombok.Data;

@Data
public class MemberDeleteRequest {

	private int memberNo;
	private String socialYn;
}
