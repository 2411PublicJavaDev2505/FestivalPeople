package com.fepeo.boot.review.controller.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewUpdateRequest {
	
	// 4/23 10:41 안되서 주석처리함!
	//private int			reviewYn; 살리기
	//다시 주석하기!
	//private int			reviewYn; 를 살리면
	//org.springframework.web.bind.MethodArgumentNotValidException: Validation failed for argument [0] 
	//in public java.lang.String com.fepeo.boot.review.controller.ReviewController.
	//reviewUpdate(com.fepeo.boot.review.controller.dto.ReviewUpdateRequest
	//,java.util.List,jakarta.servlet.http.HttpSession,org.springframework.ui.Model)
	//throws java.lang.IllegalStateException,java.io.IOException: [Field error 
	//in object 'reviewUpdateRequest' on field 'reviewYn': rejected value [N]; 
	//codes [typeMismatch.reviewUpdateRequest.reviewYn,typeMismatch
	//.reviewYn,typeMismatch.int,typeMismatch]; 
	//arguments [org.springframework.context.support.
	//DefaultMessageSourceResolvable: 
	//codes [reviewUpdateRequest.reviewYn,reviewYn]; 
	//arguments []; default message [reviewYn]]; 
	//default message [Failed to convert property value 
	//of type 'java.lang.String' to required type 
	//'int' for property 'reviewYn'; For input string: "N"]]
	
	private	int			reviewNo;			
	private	String		reviewTitle;		
	private String		reviewContent;	
	private String 		reviewCount;
	//private int			reviewYn;
	private int			memberNo;
	private List<ImgAddRequest> imageList;
}
