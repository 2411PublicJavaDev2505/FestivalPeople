package com.fepeo.boot.notice.controller.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeAddRequest {
	
	private String noticeTitle;
	private String noticeContent;
	private String noticeFileName;
	private String noticeFileRename;
	private String noticeFilePath;
	private MultipartFile file;
	
}
