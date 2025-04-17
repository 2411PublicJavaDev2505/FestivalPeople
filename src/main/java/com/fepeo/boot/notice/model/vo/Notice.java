package com.fepeo.boot.notice.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Timestamp noticeWriteDate;
	private Timestamp noticeUpdateDate;
	private String noticeFileName;
	private String noticeFileRename;
	private String noticeFilePath;
	private int noticeCount;
}
