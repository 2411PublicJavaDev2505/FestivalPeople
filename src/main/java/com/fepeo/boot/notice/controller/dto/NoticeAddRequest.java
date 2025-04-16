package com.fepeo.boot.notice.controller.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeAddRequest {
	
	private int noticeNO;
	private String noticeTitle;
	private String noticeContent;
}
