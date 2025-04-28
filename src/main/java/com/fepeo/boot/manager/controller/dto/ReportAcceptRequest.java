package com.fepeo.boot.manager.controller.dto;

import lombok.Data;

@Data
public class ReportAcceptRequest {

	private String reportObject;
	private int chatRoomNo;
	private int commentNo;
	private int reviewNo;
	private int reportNo;
}
