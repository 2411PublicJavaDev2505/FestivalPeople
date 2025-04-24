package com.fepeo.boot.report.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Report {
	
	private int reportNo;
	private int memberNo;
	private String reportObject;
	private String reportContent;
	private int chatRoomNo;
	private int commentNo;
	private int reviewNo;
	private String detleYn;

}
