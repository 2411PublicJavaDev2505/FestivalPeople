package com.fepeo.boot.review.controller.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewUpdateRequest {
	
	private	int			reviewNo;			
	private	String		reviewTitle;		
	private String		reviewContent;
	private String 		reviewCount;
	private int			memberNo;
	private List<ImgAddRequest> imageList;
}
