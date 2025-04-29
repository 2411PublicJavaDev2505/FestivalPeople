package com.fepeo.boot.review.model.vo;

import java.sql.Timestamp;
import java.util.List;

import com.fepeo.boot.review.controller.dto.ImgAddRequest;


import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class Review {
	
	private	int			reviewNo;			
	private	String		reviewTitle;		
	private String		reviewContent;		
	private	Timestamp	reviewWriteTime;	
	private int			reviewCount;		
	private String		reviewYn;			
	private String		reviewFileName1;	
	private String		reviewFileRename1;	
	private String		reviewFilePath1;	
	private String		reviewFileName2;
	private String		reviewFileRename2;
	private String		reviewFilePath2;
	private String		reviewFileName3;
	private String		reviewFileRename3;
	private String		reviewFilePath3;
	private int			memberNo;
	private List<ReviewComment> commentList;
	private List<ImgAddRequest> imgList; 
	private String memberName;
	private String nickname;
}
