package com.fepeo.boot.review.controller.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ImgAddRequest {
	private int 		reviewNo;
	private String		reviewFileName;	//리뷰이름1
	private String		reviewFileRename;	//리뷰파일변경이름1
	private String		reviewFilePath;	//리뷰파일경로1
	private int			memberNo;
	//임포트안됨!!어쩌다됨...
	private MultipartFile imageFile;
}
