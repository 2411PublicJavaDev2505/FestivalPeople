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
	private String		reviewFileName;	
	private String		reviewFileRename;	
	private String		reviewFilePath;	
	private int			memberNo;
	private MultipartFile imageFile;
}
