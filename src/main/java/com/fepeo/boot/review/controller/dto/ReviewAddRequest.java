package com.fepeo.boot.review.controller.dto;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewAddRequest {
	
	//
	private	int			reviewNo;			
	private	String		reviewTitle;		
	private String		reviewContent;		
	private int			memberNo;
	private List<ImgAddRequest> imageList;
	
	
}
