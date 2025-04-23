package com.fepeo.boot.festival.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Festival {
	
	private int festivalNo;
	private String festivalName;
	private Date festivalStartDate;
	private Date festivalEndDate;
	private String festivalFilePath;
	private String festivalPhone;
	private String festivalAddress;
	private String festivalDetailAddress;
	private String mapVCode;
	private String mapHCode;
	
}
