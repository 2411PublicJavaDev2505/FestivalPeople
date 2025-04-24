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
	private int			reviewYn;
	private int			memberNo;
	private List<ImgAddRequest> imageList;
	//일단 밑에 수정작업 추가!!4/24
	private MultipartFile imageFile;
	//한번더 수정코드 작업 추가!!
	private String		reviewFileName;	//리뷰이름1
	private String		reviewFileRename;	//리뷰파일변경이름1
	private String		reviewFilePath;	//리뷰파일경로1
}
